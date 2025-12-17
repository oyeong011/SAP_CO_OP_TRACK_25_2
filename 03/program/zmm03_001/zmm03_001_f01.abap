
*&---------------------------------------------------------------------*

*&  Include           ZMM03_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTROL_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'CRE'.

      IF P_CRE = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'DSP'.

      IF P_DISP = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INIT .

  IF P_CRE = 'X'.

    IF P_BUKRS IS INITIAL OR P_KTOKK IS INITIAL.

     MESSAGE S000 DISPLAY LIKE 'E'.

     LEAVE LIST-PROCESSING.

    ENDIF.

  ELSEIF P_DISP = 'X'.

    IF P_BUKRS IS INITIAL OR P_LIFNR IS INITIAL.

     MESSAGE S000 DISPLAY LIKE 'E'.

     LEAVE LIST-PROCESSING.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POPUP_CONFIRM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POPUP_CONFIRM .

    DATA: LV_ANSWER TYPE C.

    CALL FUNCTION 'POPUP_TO_CONFIRM'

      EXPORTING

        TITLEBAR              = '### ##'

        TEXT_QUESTION         = '#### ########?'

        TEXT_BUTTON_1         = '##'

        ICON_BUTTON_1         = 'ICON_INSERT'

        TEXT_BUTTON_2         = 'CANCEL'

        ICON_BUTTON_2         = 'ICON_CANCEL'

        DEFAULT_BUTTON        = '1'

        DISPLAY_CANCEL_BUTTON = ' '   "## CANCEL ## # ###

      IMPORTING

        ANSWER                = LV_ANSWER.



    "ANSWER = 2 ## CANCEL

    IF LV_ANSWER = '2'.

      "## # ## ## ### ##

      MESSAGE '#######' TYPE 'S'.

      LEAVE PROGRAM.

    ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT03_LFA1 AS A

           INNER JOIN ZEDT03_LFB1 AS B ON A~LIFNR = B~LIFNR

           INNER JOIN ZEDT03_LFM1 AS M ON A~LIFNR = M~LIFNR

           INTO CORRESPONDING FIELDS OF TABLE GT_MASTER

           WHERE A~LIFNR = P_LIFNR

           AND B~BUKRS = P_BUKRS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_DATA .

  IF GT_MASTER IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VIEW_EDIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VIEW_EDIT .

  LOOP AT SCREEN.

    IF P_CRE = 'X'.

      IF SCREEN-NAME = 'GV_LIFNR' OR SCREEN-NAME = 'GV_KTOKK' OR SCREEN-NAME = 'GV_BUKRS'.

        SCREEN-INPUT = 0.

      ENDIF.

    ELSE. "### #

      IF SCREEN-NAME = 'GV_STCD2' OR SCREEN-NAME = 'GV_SAVE'.

        SCREEN-INPUT = 1.

      ELSE.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.





    IF SCREEN-NAME = 'GV_STCD1' OR SCREEN-NAME = 'GV_STCD1_TXT'.

      SCREEN-ACTIVE = 0.

    ENDIF.



    CASE GV_KTOKK.

        WHEN '2000'. "##

          IF SCREEN-NAME = 'GV_STCD2' OR SCREEN-NAME = 'GV_STCD2_TXT'.

            SCREEN-ACTIVE = 0.

          ENDIF.

        WHEN '3000'. "##

          IF SCREEN-NAME = 'GV_STCD1' OR SCREEN-NAME = 'GV_STCD1_TXT'.

            SCREEN-ACTIVE = 1.

          ENDIF.

          IF SCREEN-NAME = 'GV_STCD2' OR SCREEN-NAME = 'GV_STCD2_TXT'.

            SCREEN-ACTIVE = 0.

          ENDIF.

        ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

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

  PERFORM SAVE_CHECK.



  CLEAR: GS_LFA1.

  GS_LFA1-LIFNR = GV_LIFNR.

  GS_LFA1-NAME1 = GV_NAME1.

  GS_LFA1-LAND1 = GV_LAND1.

  GS_LFA1-KTOKK = GV_KTOKK.

  GS_LFA1-STCD1 = GV_STCD1.

  GS_LFA1-STCD2 = GV_STCD2.

  GS_LFA1-STRAS = GV_STRAS.

  APPEND GS_LFA1 TO GT_LFA1.

  MODIFY ZEDT03_LFA1 FROM TABLE GT_LFA1.

  IF SY-SUBRC NE 0.

    MESSAGE '## ##' TYPE 'I'.

    LEAVE TO SCREEN 100.

  ENDIF.



  CLEAR: GS_LFB1.

  GS_LFB1-LIFNR = GV_LIFNR.

  GS_LFB1-BUKRS = GV_BUKRS.

  GS_LFB1-AKONT = GV_AKONT.

  GS_LFB1-ZTERM = GV_ZTERM.

  APPEND GS_LFB1 TO GT_LFB1.

  MODIFY ZEDT03_LFB1 FROM TABLE GT_LFB1.

  IF SY-SUBRC NE 0.

    MESSAGE '## ##' TYPE 'I'.

    LEAVE TO SCREEN 100.

  ENDIF.



  CLEAR: GS_LFM1.

  GS_LFM1-LIFNR = GV_LIFNR.

  GS_LFM1-EKORG = GV_EKORG.

  GS_LFM1-EKGRP = GV_EKGRP.

  GS_LFM1-WAERS = GV_WAERS.

  GS_LFM1-MWSKZ = GV_MWSKZ.

  APPEND GS_LFM1 TO GT_LFM1.

  MODIFY ZEDT03_LFM1 FROM TABLE GT_LFM1.

  IF SY-SUBRC NE 0.

    MESSAGE '## ##' TYPE 'I'.

    LEAVE TO SCREEN 100.

  ELSE.

    MESSAGE '## ##' TYPE 'I'.

    EXIT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_CHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_CHECK .

  IF GV_KTOKK = '3000'.

    IF GV_STCD1 = ''.

      MESSAGE '##### #####.' TYPE 'E'.

    ENDIF.

  ELSEIF GV_KTOKK NE '2000'.

    IF GV_STCD2 = ''.

      MESSAGE '### ### #####.' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_DATA CHANGING P_GV_LIFNR.

    GV_BUKRS = P_BUKRS.

    GV_KTOKK = P_KTOKK.



  "1) ####(KTOKK)# ## ### #### ## ##

  CLEAR GV_NR_RANGE.



  CASE GV_KTOKK.

    WHEN '1000'.     "1000 : ##

      GV_NR_RANGE = GC_NR_M1.

    WHEN '2000'.      "2000 : ##

      GV_NR_RANGE = GC_NR_M2.

    WHEN '3000'.       "3000 : ##

      GV_NR_RANGE = GC_NR_M3.

    WHEN '4000'.         "4000 : ##

      GV_NR_RANGE = GC_NR_M4.

    WHEN '5000'.         "5000 : ####

      GV_NR_RANGE = GC_NR_M5.

    WHEN '6000'.        "6000 : ####

      GV_NR_RANGE = GC_NR_M6.

    WHEN '9000'.          "9000 : 1##

      GV_NR_RANGE = GC_NR_M9.

    WHEN OTHERS.

      MESSAGE E001 WITH GV_KTOKK. "## # # ###### ## ##

      EXIT.

  ENDCASE.



  "2) SNRO (ZVENDNO_03)## # ## ##

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR             = GV_NR_RANGE

      OBJECT                  = GC_NR_OBJ       "ZVENDNO_03

      QUANTITY                = '1'

    IMPORTING

      NUMBER                  = P_GV_LIFNR

    EXCEPTIONS

      INTERVAL_NOT_FOUND      = 1

      NUMBER_RANGE_NOT_INTERN = 2

      OBJECT_NOT_FOUND        = 3

      QUANTITY_IS_0           = 4

      QUANTITY_IS_NOT_1       = 5

      INTERVAL_OVERFLOW       = 6

      OTHERS                  = 7.



  IF SY-SUBRC <> 0.

    MESSAGE '##### #### #####.' TYPE 'E'.

    EXIT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATA .

  READ TABLE GT_MASTER INTO GS_MASTER INDEX 1.

  GV_LIFNR = GS_MASTER-LIFNR.

  GV_NAME1 = GS_MASTER-NAME1.

  GV_LAND1 = GS_MASTER-LAND1.

  GV_KTOKK = GS_MASTER-KTOKK.

  GV_STCD1 = GS_MASTER-STCD1.

  GV_STCD2 = GS_MASTER-STCD2.

  GV_STRAS = GS_MASTER-STRAS.

  GV_BUKRS = GS_MASTER-BUKRS.

  GV_AKONT = GS_MASTER-AKONT.

  GV_ZTERM = GS_MASTER-ZTERM.

  GV_EKORG = GS_MASTER-EKORG.

  GV_EKGRP = GS_MASTER-EKGRP.

  GV_WAERS = GS_MASTER-WAERS.

  GV_MWSKZ = GS_MASTER-MWSKZ.

ENDFORM.