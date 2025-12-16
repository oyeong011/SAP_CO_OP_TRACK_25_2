
*&---------------------------------------------------------------------*

*&  Include           ZMM14_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SCREEN_OUTPUT .



  LOOP AT SCREEN.

    IF P_R1 = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

        SCREEN-INVISIBLE = 1.

        MODIFY SCREEN.

      ENDIF.

    ELSEIF P_R2 = 'X'.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 0.

        SCREEN-INVISIBLE = 1.

        MODIFY SCREEN.

      ENDIF.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CHECK_INPUT .



  IF P_BUKRS IS INITIAL.

    MESSAGE '##### #### ###.' TYPE 'E' DISPLAY LIKE 'W'.

  ENDIF.



  IF P_KTOKK IS INITIAL.

    MESSAGE '###### #### ###.' TYPE 'E' DISPLAY LIKE 'W'.

  ELSE.

    CASE P_KTOKK.

      WHEN '1000' OR '2000' OR '3000' OR '4000' OR '5000' OR '9000'.

      WHEN OTHERS.

        MESSAGE '### ###### #### ###.' TYPE 'E' DISPLAY LIKE 'W'.

    ENDCASE.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CHECK_SAVE_DATA .



  DATA : LV_ERROR TYPE C. "## ## ## ###

  CLEAR : LV_ERROR, SY-SUBRC.



  "#### ##: #, ###, ####(X), ####(0=##), ####(X)

  PERFORM VALIDATE_FIELD USING:

    GS_DATA-NAME1 '####' 'X' 0 '' CHANGING LV_ERROR,

    GS_DATA-LAND1 '###' 'X' 2 '' CHANGING LV_ERROR.

  CHECK LV_ERROR IS INITIAL.



  CASE P_KTOKK.

    WHEN '1000'.

      PERFORM VALIDATE_FIELD USING GS_DATA-STCD2 '#####' 'X' 10 'X'

                             CHANGING LV_ERROR.

    WHEN '3000'.

      PERFORM VALIDATE_FIELD USING GS_DATA-STCD1 '####' 'X' 13 'X'

                             CHANGING LV_ERROR.

  ENDCASE.

  CHECK LV_ERROR IS INITIAL.



  PERFORM VALIDATE_FIELD USING:

    GS_DATA-STRAS '##'   'X' 0 '' CHANGING LV_ERROR,

    GS_DATA-AKONT '####' 'X' 10 'X' CHANGING LV_ERROR,

    GS_DATA-ZTERM '####' 'X' 4 '' CHANGING LV_ERROR,

    GS_DATA-EKORG '####' 'X' 4 'X' CHANGING LV_ERROR,

    GS_DATA-EKGRP '####' 'X' 3 'X' CHANGING LV_ERROR,

    GS_DATA-WAERS '##'   'X' 3 '' CHANGING LV_ERROR,

    GS_DATA-MWSKZ '####' 'X' 2 '' CHANGING LV_ERROR.

  CHECK LV_ERROR IS INITIAL.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM VALIDATE_FIELD USING PV_VAL TYPE ANY      "### #

                          PV_NAME TYPE CLIKE   "## ## (####)

                          PV_REQ TYPE C        "## ## ('X')

                          PV_MIN TYPE I        "## ## (0## ##)

                          PV_NUM TYPE C        "## ## ## ('X')

                 CHANGING CV_ERROR TYPE C.     "## ###



  CHECK CV_ERROR IS INITIAL.



  DATA: LV_VAL_STR TYPE STRING.

  DATA: LV_LEN     TYPE I.

  DATA: LV_MSG     TYPE STRING.



  "## #### ##(## ## ## ##)

  LV_VAL_STR = PV_VAL.



  "## ## ##

  IF PV_REQ = 'X' AND LV_VAL_STR IS INITIAL.

    LV_MSG = |{ PV_NAME }#(#) ## ## #####.|.

    MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'W'.

    CV_ERROR = 'X'.

    SY-SUBRC = 1.

    EXIT.

  ENDIF.



  "## ## ## ## ## ##

  IF LV_VAL_STR IS NOT INITIAL.

    "## ## ##

    LV_LEN = STRLEN( LV_VAL_STR ).

    IF PV_MIN > 0 AND LV_LEN < PV_MIN.

      LV_MSG = |{ PV_NAME }#(#) { PV_MIN }## ## #### ###.|.

      MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'W'.

      CV_ERROR = 'X'.

      SY-SUBRC = 1.

      EXIT.

    ENDIF.

    "## ## ##

    IF PV_NUM = 'X'.

      IF NOT LV_VAL_STR CO '0123456789'.

        LV_MSG = |{ PV_NAME }#(#) #### #### ###.|.

        MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'W'.

        CV_ERROR = 'X'.

        SY-SUBRC = 1.

        EXIT.

      ENDIF.

    ENDIF.

  ENDIF.



  IF PV_NAME = '####'.

    CASE PV_VAL.

      WHEN 'V1' OR 'V2' OR 'V3' OR 'V4' OR 'V5'.

      WHEN OTHERS.

        MESSAGE '### ##### #### ###.' TYPE 'S' DISPLAY LIKE 'W'.

        CV_ERROR = 'X'.

        SY-SUBRC = 1.

        EXIT.

    ENDCASE.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SAVE_DATA .



  DATA : LV_MAX TYPE ZLFA1_14-LIFNR,

         LS_LFA1 TYPE ZLFA1_14,

         LS_LFB1 TYPE ZLFB1_14,

         LS_LFM1 TYPE ZLFM1_14.



  SELECT MAX( LIFNR ) INTO LV_MAX FROM ZLFA1_14.  "##### MAX



  IF LV_MAX IS INITIAL. LV_MAX = '1000000001'. ENDIF.

  GS_DATA-LIFNR = LV_MAX + 1.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING INPUT = GS_DATA-LIFNR IMPORTING OUTPUT = GS_DATA-LIFNR.

  GS_DATA-BUKRS = P_BUKRS.  "####

  GS_DATA-KTOKK = P_KTOKK.  "#####



  MOVE-CORRESPONDING GS_DATA TO LS_LFA1.

  MOVE-CORRESPONDING GS_DATA TO LS_LFB1.

  LS_LFB1-LIFNR = GS_DATA-LIFNR.

  MOVE-CORRESPONDING GS_DATA TO LS_LFM1.

  LS_LFM1-LIFNR = GS_DATA-LIFNR.



  INSERT ZLFA1_14 FROM LS_LFA1.

  INSERT ZLFB1_14 FROM LS_LFB1.

  INSERT ZLFM1_14 FROM LS_LFM1.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE S001(00) WITH '### ## ##. #####: ' GS_DATA-LIFNR.



    GV_MODE = ' '.   "## ##### ##

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA .



  CLEAR GT_OUT.



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_OUT

    FROM ZLFA1_14 AS A

    INNER JOIN ZLFB1_14 AS B ON A~LIFNR = B~LIFNR

    INNER JOIN ZLFM1_14 AS M ON A~LIFNR = M~LIFNR

    WHERE A~LIFNR = P_LIFNR AND B~BUKRS = P_BUKRS.



  IF GT_OUT[] IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .



  CREATE OBJECT GO_DOCKING

      EXPORTING

        REPID                       = SY-REPID

        DYNNR                       = SY-DYNNR

        SIDE                        = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        EXTENSION                   = 2000.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ##' TYPE 'E'.

  ENDIF.



  CREATE OBJECT GO_GRID

    EXPORTING

      I_PARENT = GO_DOCKING.



  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GO_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GT_FCAT, GS_FCAT.



  PERFORM FILL_FCAT USING :

        'LIFNR' '#####' '' 10 '' CHANGING GT_FCAT,

        'NAME1' '####'  '' 8 '' CHANGING GT_FCAT,

        'KTOKK' '#####' '' 8 '' CHANGING GT_FCAT,

        'LAND1' '###'   '' 8 '' CHANGING GT_FCAT,

        'STCD1' '####'  'X' 14 '' CHANGING GT_FCAT,

        'STCD2' '#####' 'X' 10 '' CHANGING GT_FCAT,

        'STRAS' '##'    '' 10 '' CHANGING GT_FCAT,

        'BUKRS' '####'  '' 10 '' CHANGING GT_FCAT,

        'AKONT' '##'    '' 10 '' CHANGING GT_FCAT,

        'ZTERM' '####'  '' 10 '' CHANGING GT_FCAT,

        'EKORG' '####'  '' 10 '' CHANGING GT_FCAT,

        'EKGRP' '####'  '' 10 '' CHANGING GT_FCAT,

        'WAERS' '######' '' 10 '' CHANGING GT_FCAT,

        'MWSKZ' '####'  '' 10 '' CHANGING GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_FCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FILL_FCAT USING PV_FIELD PV_TXT PV_EDIT PV_LEN PV_CFIELD

               CHANGING CT_FCAT TYPE LVC_T_FCAT.



  DATA : LS_FCAT TYPE LVC_S_FCAT.

  DATA : LS_OUT LIKE LINE OF GT_OUT.



  READ TABLE GT_OUT INTO LS_OUT INDEX 1.



  LS_FCAT-FIELDNAME = PV_FIELD.

  LS_FCAT-COLTEXT = PV_TXT.

  LS_FCAT-EDIT = PV_EDIT.

  LS_FCAT-OUTPUTLEN = PV_LEN.

  LS_FCAT-JUST = 'R'.



  IF PV_FIELD = 'STCD1' AND LS_OUT-KTOKK <> '3000'.

    LS_FCAT-NO_OUT = 'X'.

  ELSEIF PV_FIELD = 'STCD2' AND LS_OUT-KTOKK <> '1000'.

    LS_FCAT-NO_OUT = 'X'.

  ENDIF.



  APPEND LS_FCAT TO CT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.




*  GS_LAYOUT-NO_TOOLBAR = 'X'.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CALL_METHOD .



  CALL METHOD GO_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_OUT

      IT_FIELDCATALOG = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM REFRESH_ALV .



  DATA: LS_STABLE TYPE LVC_S_STBL.



  " ## ### # ## ## ##

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DATA_CHANGED_PROCESS

*&---------------------------------------------------------------------*

*       ##### ##

*----------------------------------------------------------------------*

*      -->RR_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM DATA_CHANGED_PROCESS USING RR_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA : LS_MOD_CELL TYPE LVC_S_MODI,

         LS_OUT LIKE LINE OF GT_OUT.

  DATA : LV_ANSWER TYPE C.

  DATA : LV_CHECK_VALUE TYPE STRING.



  LOOP AT RR_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.



    IF LS_MOD_CELL-FIELDNAME = 'STCD2'.

      READ TABLE GT_OUT INTO LS_OUT INDEX LS_MOD_CELL-ROW_ID.



      IF SY-SUBRC = 0.

        IF LS_MOD_CELL-VALUE IS INITIAL.

          MESSAGE '###### ######.' TYPE 'S' DISPLAY LIKE 'W'.



          CALL METHOD RR_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

              I_VALUE     = LS_OUT-STCD2.



          CONTINUE.

        ENDIF.




*        IF NOT LS_MOD_CELL-VALUE CO '0123456789'.

*          MESSAGE '###### #### #### ###.' TYPE 'S' DISPLAY LIKE 'W'.

*

*          CALL METHOD RR_DATA_CHANGED->MODIFY_CELL

*            EXPORTING

*              I_ROW_ID    = LS_MOD_CELL-ROW_ID

*              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

*              I_VALUE     = LS_OUT-STCD2.

*          CONTINUE.

*        ENDIF.






        CALL FUNCTION 'POPUP_TO_CONFIRM'

          EXPORTING

            TITLEBAR              = '## ##'

            TEXT_QUESTION         = '###### ########?'

            TEXT_BUTTON_1         = '#'

            TEXT_BUTTON_2         = '###'

            DISPLAY_CANCEL_BUTTON = ' '

          IMPORTING

            ANSWER                = LV_ANSWER.



        IF LV_ANSWER = '1'.

          UPDATE ZLFA1_14

            SET STCD2 = LS_MOD_CELL-VALUE

            WHERE LIFNR = LS_OUT-LIFNR.



          IF SY-SUBRC = 0.

            COMMIT WORK.

            MESSAGE '###### #######.' TYPE 'S'.

          ELSE.

            ROLLBACK WORK.

            MESSAGE '##### ## ##' TYPE 'E'.

          ENDIF.

        ELSE.

          MESSAGE '### #######.' TYPE 'S'.

          CALL METHOD RR_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

              I_VALUE     = LS_OUT-STCD2.  "## #

        ENDIF.

      ENDIF.

    ENDIF.



    IF LS_MOD_CELL-FIELDNAME = 'STCD1'.

      READ TABLE GT_OUT INTO LS_OUT INDEX LS_MOD_CELL-ROW_ID.



      IF SY-SUBRC = 0.

        IF LS_MOD_CELL-VALUE IS INITIAL.

          MESSAGE '##### ######.' TYPE 'S' DISPLAY LIKE 'W'.



          CALL METHOD RR_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

              I_VALUE     = LS_OUT-STCD1.



          CONTINUE.

        ENDIF.



        CALL FUNCTION 'POPUP_TO_CONFIRM'

          EXPORTING

            TITLEBAR              = '## ##'

            TEXT_QUESTION         = '##### ########?'

            TEXT_BUTTON_1         = '#'

            TEXT_BUTTON_2         = '###'

            DISPLAY_CANCEL_BUTTON = ' '

          IMPORTING

            ANSWER                = LV_ANSWER.



        IF LV_ANSWER = '1'.

          UPDATE ZLFA1_14

            SET STCD1 = LS_MOD_CELL-VALUE

            WHERE LIFNR = LS_OUT-LIFNR.



          IF SY-SUBRC = 0.

            COMMIT WORK.

            MESSAGE '##### #######.' TYPE 'S'.

          ELSE.

            ROLLBACK WORK.

            MESSAGE '#### ## ##' TYPE 'E'.

          ENDIF.

        ELSE.

          MESSAGE '### #######.' TYPE 'S'.

          CALL METHOD RR_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = LS_MOD_CELL-FIELDNAME

              I_VALUE     = LS_OUT-STCD1.  "## #

        ENDIF.

      ENDIF.

    ENDIF.



  ENDLOOP.



ENDFORM.