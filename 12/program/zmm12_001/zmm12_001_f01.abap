
*&---------------------------------------------------------------------*

*&  Include           ZMM12_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.  " #####

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " #####

      IF P_RD1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  IS_VALID_INPUT

*&---------------------------------------------------------------------*




FORM IS_VALID_INPUT .

  DATA : LV_MAX_LIFNR TYPE ZLFA1_12-LIFNR.

  IF P_RD1 = 'X'. "#####

    IF P_BUKRS IS INITIAL OR P_ZKTOKK IS INITIAL.

      MESSAGE '## ### ## ####.' TYPE 'E'.

    ENDIF.

    PERFORM GET_LINFR CHANGING LV_MAX_LIFNR.

    GV_LIFNR = LV_MAX_LIFNR.

    GV_BUKRS = P_BUKRS.

    GV_KTOKK = P_ZKTOKK.



  ELSE. "#####

    IF P_LIFNR IS INITIAL OR P_BUKRS IS INITIAL.

      MESSAGE '## ### ## ####.' TYPE 'E'.

    ENDIF.

    GV_LIFNR = P_LIFNR.

    GV_BUKRS = P_BUKRS.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_VENDOR

*&---------------------------------------------------------------------*




FORM SAVE_VENDOR .




*-----------------------------------------------------------

* 2. ## # # ## ### ##

*   ( ZSCREEN_LFA1 / LFB1 / LFM1 )

*-----------------------------------------------------------






  CLEAR: GS_LFA1, GS_LFB1, GS_LFM1.



  "LFA1

  GS_LFA1-LIFNR = GV_LIFNR.       "#####"

  GS_LFA1-NAME1 = GV_NAME1.       "####"

  GS_LFA1-LAND1 = GV_LAND1.       "###"

  GS_LFA1-KTOKK = GV_KTOKK.       "#####, ####"



  GS_LFA1-STCD1 = GV_STCD1.       "####"



  GS_LFA1-STCD2 = GV_STCD2.       "#####"



  GS_LFA1-STRAS = GV_STRAS.       "##"





  "LFB1

  GS_LFB1-LIFNR = GV_LIFNR.       "#####"

  GS_LFB1-BUKRS = GV_BUKRS.       "####"

  GS_LFB1-LOEVM = ' '.            "#####, #####"

  GS_LFB1-AKONT = GV_AKONT.       "####"

  GS_LFB1-ZTERM = GV_ZTERM.



  "LFM1

  GS_LFM1-LIFNR = GV_LIFNR.       "#####"

  GS_LFM1-EKORG = GV_EKORG.       "####"

  GS_LFM1-LOEVM = ' '.            "#####, #####"

  GS_LFM1-EKGRP = GV_EKGRP.       "####"

  GS_LFM1-WAERS = GV_WAERS.       "######"

  GS_LFM1-MWSKZ = GV_MWSKZ.       "####"






*-----------------------------------------------------------

* 3. INSERT ##

*-----------------------------------------------------------




  INSERT ZLFA1_12 FROM GS_LFA1.

  IF SY-SUBRC <> 0.

    MESSAGE '#####(LFA1) ## ##' TYPE 'E'.

  ENDIF.



  INSERT ZLFB1_12 FROM GS_LFB1.

  IF SY-SUBRC <> 0.

    MESSAGE '#######(LFB1) ## ##' TYPE 'E'.

  ENDIF.



  INSERT ZLFM1_12 FROM GS_LFM1.

  IF SY-SUBRC <> 0.

    MESSAGE '#######(LFM1) ## ##' TYPE 'E'.

  ENDIF.






*-----------------------------------------------------------

* 4. ## ###

*-----------------------------------------------------------




  MESSAGE |### { GV_LIFNR } ## ##| TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID = SY-REPID

      DYNNR = SY-DYNNR

      EXTENSION = 2000.



  CREATE OBJECT GC_GRID

   EXPORTING

     I_PARENT = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'KTOKK'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  DATA : LV_COL_POS TYPE I VALUE 5. "## ## ## ##"



  IF GS_alv_output-KTOKK = '3000'.

    GS_FIELDCAT-COL_POS = 5.

    GS_FIELDCAT-FIELDNAME = 'STCD1'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    LV_COL_POS = LV_COL_POS + 1.

  ELSEIF GS_alv_output-KTOKK = '2000'. "2000# ## ## X"

  ELSE.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 5.

    GS_FIELDCAT-FIELDNAME = 'STCD2'.

    GS_FIELDCAT-SCRTEXT_M = '#####'.

    GS_FIELDCAT-EDIT = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    LV_COL_POS = LV_COL_POS + 1.

  ENDIF.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



   CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'LOEVM'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'AKONT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  LV_COL_POS = LV_COL_POS + 1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = LV_COL_POS.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.          " ## ## # ### ##

  GS_LAYOUT-EDIT = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

"Register_edit : screen# ITAB ###

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING

    I_SAVE                        = 'A'

    IS_LAYOUT                     = GS_LAYOUT

  CHANGING

    IT_OUTTAB                     = GT_ALV_OUTPUT

    IT_FIELDCATALOG               = GT_FIELDCAT



        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA: LS_STABLE TYPE LVC_S_STBL. "####.




*   ####USERCOMMAND ######

*    CURSOR#####




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

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_LINFR

*&---------------------------------------------------------------------*




FORM GET_LINFR  CHANGING P_MAX_LIFNR.

  DATA : LV_MAX_LIFNR TYPE I.



  SELECT MAX( LIFNR ) INTO P_MAX_LIFNR FROM ZLFA1_12.



  IF SY-SUBRC = 0 AND P_MAX_LIFNR IS NOT INITIAL.

    LV_MAX_LIFNR = P_MAX_LIFNR. "### ### ##

    LV_MAX_LIFNR = LV_MAX_LIFNR + 1.

    P_MAX_LIFNR = LV_MAX_LIFNR. "### ## ### ##



    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT = P_MAX_LIFNR

      IMPORTING

        OUTPUT = P_MAX_LIFNR.

  ELSE.

    " # ## #####

    P_MAX_LIFNR = '1000000000'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SEARCH_VENDOR

*&---------------------------------------------------------------------*




FORM SEARCH_VENDOR .

   CLEAR : GS_ALV_OUTPUT, GT_ALV_OUTPUT.



  SELECT SINGLE

      A~LIFNR   "####

      A~NAME1   " ####

      A~LAND1   " ###

      A~KTOKK " #####

      A~STCD1   " ####

      A~STCD2   " #####

      A~STRAS   " ##

      B~BUKRS  "####

      B~LOEVM  " #####

      B~AKONT  " ##

      B~ZTERM  " ####

      C~EKORG  " ####

      C~EKGRP  " ####

      C~WAERS  " ######

      C~MWSKZ  " ####

    INTO CORRESPONDING FIELDS OF GS_ALV_OUTPUT

    FROM ZLFA1_12 AS A

      INNER JOIN ZLFB1_12 AS B

      ON A~LIFNR = B~LIFNR

      INNER JOIN ZLFM1_12 AS C

      ON A~LIFNR = C~LIFNR

    WHERE A~LIFNR = P_LIFNR

      AND B~BUKRS = P_BUKRS.



  APPEND GS_ALV_OUTPUT TO GT_ALV_OUTPUT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_VENDOR

*&---------------------------------------------------------------------*




FORM UPDATE_VENDOR .

  DATA: LS_ALV LIKE GS_ALV_OUTPUT.






*------------------------------------------------*

* GT_ALV_OUTPUT # ## ### ZLFA1_12 ##

*   - # : LIFNR

*   - ## : STCD1, STCD2 (## ### ###)

*------------------------------------------------*




  LOOP AT GT_ALV_OUTPUT INTO LS_ALV.



    UPDATE ZLFA1_12

      SET STCD2 = LS_ALV-STCD2

      WHERE LIFNR = LS_ALV-LIFNR.



    IF SY-SUBRC <> 0.

      MESSAGE '### ### ## # ### ######.' TYPE 'E'.

      EXIT.

    ENDIF.



  ENDLOOP.



  MESSAGE '### ###### #######.' TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA: LS_MODI TYPE LVC_S_MODI. "### # ## ###

  DATA: LV_STCD2 TYPE ZLFA1_12-STCD2.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

   IF LS_MODI-FIELDNAME = 'STCD2'.

    READ TABLE GT_ALV_OUTPUT INTO GS_ALV_OUTPUT INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    GS_ALV_OUTPUT-STCD2 = LS_MODI-VALUE.



    "### ### ##

    MODIFY GT_ALV_OUTPUT FROM GS_ALV_OUTPUT INDEX LS_MODI-ROW_ID.

   ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

DATA: LS_MODI TYPE LVC_S_MODI.



CLEAR: LS_MODI.



LOOP AT PT_GOOD_CELLS INTO LS_MODI.

  IF LS_MODI-FIELDNAME = 'STCD2'.

    READ TABLE GT_ALV_OUTPUT INTO GS_ALV_OUTPUT INDEX LS_MODI-ROW_ID.



    CLEAR GS_ALV_OUTPUT.

  ENDIF.

ENDLOOP.



 PERFORM REFRESH.

 PERFORM UPDATE_VENDOR.





ENDFORM.