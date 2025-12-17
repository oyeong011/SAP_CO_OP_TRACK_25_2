
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT001_F01

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

    IF P_R1 = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

      ELSE.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ELSE.

      IF SCREEN-GROUP1 = 'M3'.

        SCREEN-ACTIVE = 0.

      ELSE.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

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

  SELECT

    *

    INTO CORRESPONDING FIELDS OF TABLE GT_MASTER

    FROM ZEDT20_LFA1 AS A

      INNER JOIN ZEDT20_LFB1 AS B ON B~LIFNR = A~LIFNR

      INNER JOIN ZEDT20_LFM1 AS C ON C~LIFNR = A~LIFNR

    WHERE A~LIFNR = P_LIFNR

    AND B~BUKRS = P_BUKRS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT .

  IF P_BUKRS = ''.

   MESSAGE S000 DISPLAY LIKE 'E'.

   LEAVE LIST-PROCESSING.

  ENDIF.



  IF P_R1 ='X'.

    IF P_KTOKK = ''.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ELSE.

    IF P_LIFNR =''.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ENDIF.

  PERFORM CHECK_AVAILABLE_BUKRS.

  PERFORM CHECK_AVAILABLE_KTOKK.

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




*&---------------------------------------------------------------------*

*&      Form  NEW_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM NEW_DATA .

  CLEAR : GV_LIFNR, GV_NAME1, GV_LAND1, GV_STCD1, GV_STCD2, GV_STRAS,

          GV_AKONT, GV_ZTERM, GV_EKORG, GV_EKGRP, GV_WAERS, GV_MWSKZ.

  DATA: LV_LIFNR TYPE N LENGTH 10.

  GV_KTOKK = P_KTOKK.

  GV_BUKRS = P_BUKRS.



  SELECT MAX( LIFNR ) INTO GV_LIFNR FROM ZEDT20_LFA1.



  IF GV_LIFNR IS INITIAL.

    GV_LIFNR = '1000000001'.

  ELSE.

    MOVE GV_LIFNR TO LV_LIFNR.

    LV_LIFNR = LV_LIFNR + 1.

    MOVE LV_LIFNR TO GV_LIFNR.

  ENDIF.

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

  PERFORM CHECK_EMPTY_FIELD.

  CLEAR: GS_LFA1.

  GS_LFA1-LIFNR = GV_LIFNR.

  GS_LFA1-NAME1 = GV_NAME1.

  GS_LFA1-LAND1 = GV_LAND1.

  GS_LFA1-KTOKK = GV_KTOKK.

  GS_LFA1-STCD1 = GV_STCD1.

  GS_LFA1-STCD2 = GV_STCD2.

  GS_LFA1-STRAS = GV_STRAS.

  APPEND GS_LFA1 TO GT_LFA1.

  MODIFY ZEDT20_LFA1 FROM TABLE GT_LFA1.

  IF SY-SUBRC NE 0.

    MESSAGE '### ######.' TYPE 'I'.

    LEAVE TO SCREEN 100.

  ENDIF.



  CLEAR: GS_LFB1.

  GS_LFB1-LIFNR = GV_LIFNR.

  GS_LFB1-BUKRS = GV_BUKRS.

  GS_LFB1-AKONT = GV_AKONT.

  GS_LFB1-ZTERM = GV_ZTERM.

  APPEND GS_LFB1 TO GT_LFB1.

  MODIFY ZEDT20_LFB1 FROM TABLE GT_LFB1.

  IF SY-SUBRC NE 0.

    MESSAGE '### ######.' TYPE 'I'.

    LEAVE TO SCREEN 100.

  ENDIF.



  CLEAR: GS_LFM1.

  GS_LFM1-LIFNR = GV_LIFNR.

  GS_LFM1-EKORG = GV_EKORG.

  GS_LFM1-EKGRP = GV_EKGRP.

  GS_LFM1-WAERS = GV_WAERS.

  GS_LFM1-MWSKZ = GV_MWSKZ.

  APPEND GS_LFM1 TO GT_LFM1.

  MODIFY ZEDT20_LFM1 FROM TABLE GT_LFM1.

  IF SY-SUBRC NE 0.

    MESSAGE '### ######.' TYPE 'I'.

    LEAVE TO SCREEN 100.

  ELSE.

    MESSAGE '### ######.' TYPE 'I'.

    LEAVE TO SCREEN 0.

    EXIT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_EMPTY_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_EMPTY_FIELD .

  IF GV_LIFNR = '' OR GV_NAME1 = '' OR GV_LAND1 = '' OR GV_KTOKK = '' OR GV_STRAS = '' OR GV_BUKRS = ''

    OR GV_AKONT = '' OR GV_ZTERM = '' OR GV_EKORG = '' OR GV_EKGRP = '' OR GV_WAERS = '' OR GV_MWSKZ = ''.

    MESSAGE '## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN SY-DYNNR.

  ENDIF.

  IF GV_KTOKK = '3000'.

    IF GV_STCD1 = '' OR GV_STCD2 = ''.

      MESSAGE '## ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      LEAVE TO SCREEN SY-DYNNR.

    ENDIF.

  ELSEIF GV_KTOKK NE '2000'.

    IF GV_STCD2 = ''.

      MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      LEAVE TO SCREEN SY-DYNNR.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INITIAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INITIAL .

  IF GT_MASTER IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_AVAILABLE_BUKRS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_AVAILABLE_BUKRS .

  DATA: LV_BUKRS TYPE ZEDT20_T001-BUKRS.

  SELECT

    SINGLE BUKRS

    FROM ZEDT20_T001

    INTO LV_BUKRS

    WHERE BUKRS = P_BUKRS.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_AVAILABLE_KTOKK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_AVAILABLE_KTOKK .

  IF P_KTOKK <> 1000 AND P_KTOKK <> 2000 AND P_KTOKK <> 3000 AND P_KTOKK <> 4000 AND P_KTOKK <> 5000 AND P_KTOKK <> 9000.

    MESSAGE '#### ## ##### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.

FORM CALL_F4_HELP USING P_RETFIELD  TYPE C

                        P_DYNPFIELD TYPE C

                        PT_VALUES   TYPE STANDARD TABLE.



  DATA: LT_RETURN LIKE DDSHRETVAL OCCURS 0 WITH HEADER LINE.



  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'

    EXPORTING

      RETFIELD        = P_RETFIELD    " ## #### ITAB# ###

      DYNPPROG        = SY-REPID      " ## #### ID

      DYNPNR          = SY-DYNNR      " ## ### ##

      DYNPROFIELD     = P_DYNPFIELD   " ## ### ### ###

      WINDOW_TITLE    = '#####'

      VALUE_ORG       = 'S'

    TABLES

      VALUE_TAB       = PT_VALUES     " #### ## ### ###

      RETURN_TAB      = LT_RETURN     " ### ###

    EXCEPTIONS

      PARAMETER_ERROR = 1

      NO_VALUES_FOUND = 2

      OTHERS          = 3.



ENDFORM.