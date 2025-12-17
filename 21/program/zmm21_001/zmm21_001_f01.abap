
*&---------------------------------------------------------------------*

*&  Include           ZMM21_001_F01

*&---------------------------------------------------------------------*






"============================================================

" Selection Screen ## ##/### ##

"============================================================

FORM SET_SCREEN.

  LOOP AT SCREEN.



    CASE SCREEN-GROUP1.



      "--------------------------------------------------------

      " ## #### ### ## (B1)

      "--------------------------------------------------------

      WHEN 'M1'.   "P_BUKRS1, P_KTOKK1 (###)

        IF P_RAD1 = 'X'.     "##

          SCREEN-ACTIVE = '0'.

        ELSE.                "##

          SCREEN-ACTIVE = '1'.

        ENDIF.



      "--------------------------------------------------------

      " ## #### ### ## (B2)

      "--------------------------------------------------------

      WHEN 'M2'.   "P_LIFNR2, P_BUKRS2 (###)

        IF P_RAD1 = 'X'.     "##

          SCREEN-ACTIVE = '1'.

        ELSE.                "##

          SCREEN-ACTIVE = '0'.

        ENDIF.



      "--------------------------------------------------------

      " #### (# ### ## ##)  #### ##

      "--------------------------------------------------------

      WHEN 'ALL'.

        SCREEN-ACTIVE = '1'.

    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.

"============================================================

" ### ## ### ####

"============================================================

 "### ####(LFA1) + ##### ##(LFB1) ## ##

FORM GET_DATA.

SELECT a~lifnr a~name1 a~stcd2 a~stras a~land1 b~bukrs

  INTO CORRESPONDING FIELDS OF TABLE gt_search

  FROM ZLFA1_21 AS A

  INNER JOIN ZLFB1_21 AS B

    ON a~lifnr = b~lifnr

  WHERE a~lifnr = p_lifnr

    AND b~bukrs = p_bukrs.



ENDFORM.

"============================================================

" Selection Screen ## # ## ##

"============================================================



FORM SCREEN_MODIFY .

    LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'M1'.

        IF p_rad1 = 'X'. "## ## ##

          screen-active = 0.

        ELSE.

          screen-active = 1.

        ENDIF.



      WHEN 'M2'.

        IF p_rad1 = 'X'. "## ## ##

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'ALL'.

        screen-active = 1. "## ##



    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.



"============================================================

" ALV ### ## ### ##

"============================================================




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA  text

*      -->P_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text



*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'STCD2'.



      READ TABLE GT_SEARCH INTO GS_SEARCH INDEX LS_MODI-ROW_ID.



      MODIFY GT_SEARCH FROM GS_SEARCH INDEX LS_MODI-ROW_ID.

      CLEAR GS_SEARCH.



    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.

ENDFORM.

"============================================================

" ALV ## Refresh (###/## ##)

"============================================================




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH.



   DATA : LS_STABLE TYPE LVC_S_STBL.



   LS_STABLE-ROW = 'X'.

   LS_STABLE-COL = 'X'.



     CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ### ## ##

"============================================================

FORM CREATE_DATA .

  "##### ### ##

  IF GV_KTOKK = '2000'. "## ##### ###

    IF GV_LIFNR IS INITIAL OR GV_NAME1 IS INITIAL OR GV_LAND1 IS INITIAL OR

       GV_STRAS IS INITIAL.



    MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.



  ELSEIF GV_KTOKK = '3000'. "## + ##### ##

    IF GV_LIFNR IS INITIAL OR GV_NAME1 IS INITIAL OR GV_LAND1 IS INITIAL OR

       GV_STCD1 IS INITIAL OR GV_STCD2 IS INITIAL OR GV_STRAS IS INITIAL.



    MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.



  ELSE. "##(###### ##)

    IF GV_LIFNR IS INITIAL OR GV_NAME1 IS INITIAL OR GV_LAND1 IS INITIAL OR

       GV_STCD2 IS INITIAL OR GV_STRAS IS INITIAL.

    MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.

  ENDIF.





  "-----------------------------

  " LFA1 (### ## ##)

  "-----------------------------

  GS_LFA1-LIFNR = GV_LIFNR.

  GS_LFA1-NAME1 = GV_NAME1.

  GS_LFA1-LAND1 = GV_LAND1.

  GS_LFA1-KTOKK = GV_KTOKK.

  GS_LFA1-STCD1 = GV_STCD1.

  GS_LFA1-STCD2 = GV_STCD2.

  GS_LFA1-STRAS = GV_STRAS.





  APPEND GS_LFA1 TO GT_LFA1.





  MODIFY ZLFA1_21 FROM GS_LFA1.

  IF SY-SUBRC <> 0.

    INSERT ZLFA1_21 FROM GS_LFA1.

  ENDIF.

 "-----------------------------

  " LFB1 (##### ###)

  "-----------------------------

  GS_LFB1-LIFNR = GV_LIFNR.

  GS_LFB1-BUKRS = GV_BUKRS.

  GS_LFB1-AKONT = GV_AKONT.

  GS_LFB1-ZTERM = GV_ZTERM.





  APPEND GS_LFB1 TO GT_LFB1.





  MODIFY ZLFB1_21 FROM GS_LFB1.

  IF SY-SUBRC <> 0.

    INSERT ZLFB1_21 FROM GS_LFB1.

  ENDIF.



 "-----------------------------

  " LFM1 (#### ##)

  "-----------------------------

  GS_LFM1-LIFNR = GV_LIFNR.

  GS_LFM1-EKORG = GV_EKORG.

  GS_LFM1-EKGRP = GV_EKGRP.

  GS_LFM1-WAERS = GV_WAERS.

  GS_LFM1-MWSKZ = GV_MWSKZ.





  APPEND GS_LFM1 TO GT_LFM1.





  MODIFY ZLFM1_21 FROM GS_LFM1.

  IF SY-SUBRC <> 0.

    INSERT ZLFM1_21 FROM GS_LFM1.

  ENDIF.



  MESSAGE '## ##' TYPE 'S'.



  LEAVE TO SCREEN 0.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  AUTO_CALCULATE_MAX_LIFNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ### ## ## ##

"============================================================

FORM AUTO_CALCULATE_MAX_LIFNR .

  DATA : lv_max TYPE ZLFA1_21-LIFNR.



  SELECT MAX( lifnr ) INTO lv_max FROM ZLFA1_21.



  IF  lv_max IS INITIAL.

    gv_lifnr = '1000000000'.

  ELSE.

    gv_lifnr = lv_max + 1.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VERIFY_KTOKK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"============================================================

" ### ####(KTOKK) ### ##

"============================================================

FORM VERIFY_KTOKK .



  IF P_RAD1 = 'X'.

    SELECT SINGLE DOMVALUE_L

    FROM DD07V

    INTO @DATA(LV_DUMMY)

    WHERE DOMNAME   = 'ZKTOKK21'

      AND DOMVALUE_L = @P_KTOKK.



    IF SY-SUBRC <> 0.

      MESSAGE 'WARNING:INSERT ONLY FIXED VALUE' TYPE 'I'.

      LEAVE SCREEN.

    ENDIF.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VERIFY_MWSKZ

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF gc_docking IS INITIAL.

    PERFORM create_object.

    PERFORM fieldcat.

    PERFORM alv_layout.

    PERFORM alv_sort.

    PERFORM class_event.

    PERFORM alv_display.

  ELSE.

    PERFORM refresh.

  ENDIF.

ENDMODULE.

FORM ALV_DISPLAY.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = gs_variant

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = gs_layout




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = gt_search

      IT_FIELDCATALOG               = gt_fC

      IT_SORT                       = gt_sort




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = sy-repid

    DYNNR                       = sy-dynnr




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .



CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = gc_docking




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT .

  CLEAR : GS_FC, GT_FC.

  GS_FC-col_pos = 1.

  gs_fc-coltext = '#####'.

  gs_fc-fieldname = 'LIFNR'.

  APPEND gs_fc TO gt_fc.



  CLEAR : gs_fc.

  gs_fC-col_pos = 2.

  gs_Fc-coltext = '####'.

  gs_fc-fieldname = 'NAME1'.

  APPEND gs_fc TO gt_fc.



  CLEAR : gs_fC.

  gs_Fc-col_pos = 3.

  gs_fc-coltext = '####'.

  gs_fc-fieldname = 'BUKRS'.

  APPEND gs_fc TO gt_fC.



  CLEAR : gs_fC.

  gs_fC-col_pos = 4.

  gs_fC-coltext = '#####'.

  gs_fC-fieldname = 'STCD2'.

  gs_fC-edit = 'X'.

  APPEND gs_fC TO gt_fC.



  CLEAR : gs_fC.

  gs_fC-col_pos = 5.

  gs_fC-coltext = '##'.

  gs_fC-fieldname = 'LAND1'.

  APPEND gs_fc TO gt_fc.



  CLEAR : gs_FC.

  gs_fC-col_pos = 6.

  gs_fC-coltext = '##'.

  gs_fC-fieldname = 'STRAS'.

  APPEND gs_fC TO gt_fC.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.



FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

 CREATE OBJECT go_event.



 SET HANDLER go_event->handler_data_changed FOR gc_grid.



 CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = cl_gui_alv_grid=>mc_evt_modified




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA : gs_save LIKE ZLFA1_21.

  DATA : gt_save LIKE TABLE OF gs_save.



  LOOP AT gt_search INTO gs_search.





    CLEAR gs_save.

    SELECT SINGLE * FROM zlfa1_21 INTO gs_save

      WHERE lifnr = gs_search-lifnr.





    MOVE-CORRESPONDING gs_search TO gs_save.





    APPEND gs_save TO gt_save.



  ENDLOOP.



  " DB ####

  MODIFY zlfa1_21 FROM TABLE gt_save.



  IF sy-subrc = 0.

    MESSAGE '####' TYPE 'I'.

  ELSE.

    MESSAGE '####' TYPE 'I'.

  ENDIF.

ENDFORM.