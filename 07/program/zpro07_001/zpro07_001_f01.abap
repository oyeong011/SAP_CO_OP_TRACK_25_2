
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'M1'. "#####

        IF p_rad1 = 'X'. "####

          screen-active = 0.

        ELSE.

          screen-active = 1.

        ENDIF.



      WHEN 'M2'. "#####

        IF p_rad1 = 'X'. "####

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'ALL'. "####

        screen-active = 1. "## ##



    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_DATA .

  CLEAR gs_001.



  IF gv_ktokk = '2000'. "2000### #### ##### ## #### INITIAL ## ## ##

    IF gv_lifnr IS INITIAL or gv_name1 IS INITIAL or gv_land1 IS INITIAL or

       gv_stras IS INITIAL.



    MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.



  ELSEIF gv_ktokk = '3000'. "3000### ####, ##### ###

    IF gv_lifnr IS INITIAL or gv_name1 IS INITIAL or gv_land1 IS INITIAL or

       gv_stcd1 IS INITIAL or gv_stcd2 IS INITIAL or gv_stras IS INITIAL.



    MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.



  ELSE. "##### ###### ###.

    IF gv_lifnr IS INITIAL or gv_name1 IS INITIAL or gv_land1 IS INITIAL or

       gv_stcd2 IS INITIAL or gv_stras IS INITIAL.

    MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.

  ENDIF.



  "ZPRO07_001# ##

  gs_001-lifnr = gv_lifnr.

  gs_001-name1 = gv_name1.

  gs_001-land1 = gv_land1.

  gs_001-ktokk = gv_ktokk.

  gs_001-stcd1 = gv_stcd1.

  gs_001-stcd2 = gv_stcd2.

  gs_001-stras = gv_stras.



  "##### ##

  APPEND gs_001 TO gt_001.



  "DB ## (INSERT or MODIFY)

  MODIFY zpro07_001 FROM gs_001.

  IF sy-subrc <> 0.

    INSERT zpro07_001 FROM gs_001.

  ENDIF.



  "ZPRO07_002# ##

  gs_002-lifnr = gv_lifnr.

  gs_002-bukrs = gv_bukrs.

  gs_002-akont = gv_akont.

  gs_002-zterm = gv_zterm.



  "##### ##

  APPEND gs_002 TO gt_002.



  "DB ## (INSERT or MODIFY)

  MODIFY zpro07_002 FROM gs_002.

  IF sy-subrc <> 0.

    INSERT zpro07_002 FROM gs_002.

  ENDIF.



  "ZPRO07_003# ##

  gs_003-lifnr = gv_lifnr.

  gs_003-ekorg = gv_ekorg.

  gs_003-ekgrp = gv_ekgrp.

  gs_003-waers = gv_waers.

  gs_003-mwskz = gv_mwskz.



  "##### ##

  APPEND gs_003 TO gt_003.



  "DB ## (INSERT or MODIFY)

  MODIFY zpro07_003 FROM gs_003.

  IF sy-subrc <> 0.

    INSERT zpro07_003 FROM gs_003.

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




FORM AUTO_CALCULATE_MAX_LIFNR .

  DATA : lv_max TYPE zpro07_001-lifnr.



  SELECT MAX( lifnr ) INTO lv_max FROM zpro07_001.



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




FORM VERIFY_KTOKK .



  IF p_rad1 = 'X'.

    SELECT SINGLE domvalue_l

    FROM dd07v

    INTO @DATA(lv_dummy)

    WHERE domname   = 'ZKTOKK07'

      AND domvalue_l = @p_ktokk.



    IF sy-subrc <> 0.

      MESSAGE '###### ### Fixed Value# ## #####.' TYPE 'I'.

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

  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-coltext = '#####'.

  gs_fieldcat-fieldname = 'LIFNR'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-fieldname = 'NAME1'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-fieldname = 'BUKRS'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-coltext = '#####'.

  gs_fieldcat-fieldname = 'STCD2'.

  gs_fieldcat-edit = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'LAND1'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'STRAS'.

  APPEND gs_fieldcat TO gt_fieldcat.

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




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

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

      IT_FIELDCATALOG               = gt_fieldcat

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

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .

  DATA : ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = ls_stable




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text1

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT a~lifnr a~name1 a~stcd2 a~stras a~land1 b~bukrs

  INTO CORRESPONDING FIELDS OF TABLE gt_search

  FROM zpro07_001 AS a

  INNER JOIN zpro07_002 AS b

    ON a~lifnr = b~lifnr

  WHERE a~lifnr = p_lifnr

    AND b~bukrs = p_bukrs.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO cl_alv_changed_data_protocol

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.



  DATA : ls_modi TYPE lvc_s_modi.



  CLEAR : ls_modi.



  LOOP AT p_data_changed->mt_good_cells INTO ls_modi.

    IF ls_modi-fieldname = 'STCD2'.



      READ TABLE gt_search INTO gs_search INDEX ls_modi-row_id.



      MODIFY gt_search FROM gs_search INDEX ls_modi-row_id.

      CLEAR gs_search.



    ENDIF.

  ENDLOOP.



  PERFORM refresh.

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

  DATA : gs_save LIKE zpro07_001.

  DATA : gt_save LIKE TABLE OF gs_save.



  LOOP AT gt_search INTO gs_search.



    " ## DB ### ## (## ##)

    CLEAR gs_save.

    SELECT SINGLE * FROM zpro07_001 INTO gs_save

      WHERE lifnr = gs_search-lifnr.



    " ### ### ####

    MOVE-CORRESPONDING gs_search TO gs_save.



    " ## #### ##

    APPEND gs_save TO gt_save.



  ENDLOOP.



  " DB ####

  MODIFY zpro07_001 FROM TABLE gt_save.



  IF sy-subrc = 0.

    MESSAGE '####' TYPE 'I'.

  ELSE.

    MESSAGE '####' TYPE 'I'.

  ENDIF.

ENDFORM.