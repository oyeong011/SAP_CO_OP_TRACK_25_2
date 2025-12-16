
*&---------------------------------------------------------------------*

*&  Include           ZMM15_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       #####. ### #### ## #### ##.

*----------------------------------------------------------------------*




FORM SCREEN_CONTROL .

 LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       ##### ### ##. #### ##.

*----------------------------------------------------------------------*




FORM CHECK_INPUT .

  IF P_R1 = C_X.

    IF P_KTOKK = '' OR P_BUKRS = ''.

      MESSAGE '## ## ## #####' TYPE 'E'.

    ENDIF.

  ELSEIF P_R2 = C_X.

    IF P_BUKRS = '' OR P_LIFNR = ''.

      MESSAGE '## ## ## #####' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       ### ### ### #### ##(##)

*----------------------------------------------------------------------*




FORM SAVE_DATA .

  "SNRO ####

  PERFORM GET_SNRO.



  "### ##

  PERFORM MATCH_VENDOR.



  "### ##

  PERFORM SAVE_VENDOR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_SNRO

*&---------------------------------------------------------------------*

*       ####, ### snro##

*----------------------------------------------------------------------*




FORM GET_SNRO .

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'     "### ## ## no

      OBJECT = 'ZVENDOR15'   "SNRO## ##

    IMPORTING

      NUMBER = GV_LIFNR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MATCH_VENDOR

*&---------------------------------------------------------------------*

*       #### ## #### ##

*----------------------------------------------------------------------*




FORM MATCH_VENDOR .

  CLEAR : GS_ZLFA1, GS_ZLFB1, GS_ZLFM1.



  "#####

  GS_ZLFA1-MANDT = SY-MANDT.

  GS_ZLFA1-LIFNR = GV_LIFNR.

  GS_ZLFA1-NAME1 = GV_NAME1.

  GS_ZLFA1-LAND1 = GV_LAND1.

  GS_ZLFA1-KTOKK = P_KTOKK. "##### #### #####

  GS_ZLFA1-STCD1 = GV_STCD1.

  GS_ZLFA1-STCD2 = GV_STCD2.

  GS_ZLFA1-STRAS = GV_STRAS.



  "#### ###

  GS_ZLFB1-MANDT = SY-MANDT.

  GS_ZLFB1-LIFNR = GV_LIFNR.

  GS_ZLFB1-BUKRS = P_BUKRS. "##### #### ####

  GS_ZLFB1-LOEVM = ''.      "##### ##

  GS_ZLFB1-AKONT = GV_AKONT.

  GS_ZLFB1-ZTERM = GV_ZTERM.



  "#### ###

  GS_ZLFM1-MANDT = SY-MANDT.

  GS_ZLFM1-LIFNR = GV_LIFNR.

  GS_ZLFM1-EKORG = GV_EKORG.

  GS_ZLFM1-EKGRP = GV_EKGRP.

  GS_ZLFM1-LOEVM = ''.      "##### ##

  GS_ZLFM1-WAERS = GV_WAERS.

  GS_ZLFM1-MWSKZ = GV_MWSKZ.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_VENDOR

*&---------------------------------------------------------------------*

*       ### ##

*----------------------------------------------------------------------*




FORM SAVE_VENDOR .



  INSERT INTO ZLFA1_15 VALUES GS_ZLFA1.

  IF SY-SUBRC <> 0.

    MESSAGE '##### ####' TYPE 'I'.

    ROLLBACK WORK. "##### ##

    EXIT.

  ENDIF.



  INSERT INTO ZLFB1_15 VALUES GS_ZLFB1.

  IF SY-SUBRC <> 0.

    MESSAGE '####### ####' TYPE 'I'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  INSERT INTO ZLFM1_15 VALUES GS_ZLFM1.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ####' TYPE 'I'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  "### ## ####

  MESSAGE |### { GV_NAME1 } { GV_LIFNR }# #######| TYPE 'I'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       ##### #####

*----------------------------------------------------------------------*




FORM SELECT_DATA .

  "#### #### #### ####

  SELECT *

    FROM ZLFA1_15 AS A

    INNER JOIN ZLFB1_09 AS B ON A~LIFNR = B~LIFNR

    INNER JOIN ZLFM1_09 AS C ON A~LIFNR = C~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_ALV

    WHERE A~LIFNR = P_LIFNR

    AND B~BUKRS = P_BUKRS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000

      .



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING

      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '#####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 3.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'KTOKK'.

  GS_FIELDCAT-COLTEXT = '#####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'STCD1'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 16.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'STCD2'.

  GS_FIELDCAT-COLTEXT = '#####'.

  GS_FIELDCAT-EDIT = 'X'.           "####

  GS_FIELDCAT-OUTPUTLEN = 11.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'LOEVM'.

  GS_FIELDCAT-COLTEXT = '#####'.

  GS_FIELDCAT-OUTPUTLEN = 1.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'AKONT'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 3.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '######'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = 2.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_TOOLBAR = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  "SCREEN# ITAB### / ### #### ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED

      .





  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT

      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE

      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       ### ##

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.

  DATA : LS_MOD_CELL TYPE LVC_S_MODI.



  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.



    "##### #### ##

    CASE LS_MOD_CELL-FIELDNAME.

      WHEN 'STCD2'.

        "## ##### 10### ### ##

        IF LS_MOD_CELL-VALUE IS INITIAL OR STRLEN( LS_MOD_CELL-VALUE ) <> 10.

          "## #### ## (### ## ###/### ## ##)

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID = '00'

              I_MSGTY = 'E'

              I_MSGNO = '001'

              I_MSGV1 = '###### 10#### ###.'

              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

              I_ROW_ID = LS_MOD_CELL-ROW_ID.

        ENDIF.

    ENDCASE.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       ## ## ##

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS TYPE LVC_T_MODI.

  MESSAGE '##### #####' TYPE 'S'.

ENDFORM.