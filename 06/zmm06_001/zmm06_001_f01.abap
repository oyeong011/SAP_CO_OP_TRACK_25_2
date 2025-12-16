
*&---------------------------------------------------------------------*

*&  Include           ZMM06_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       ## ### ## SCREEN ##.

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CONTROL .

  LOOP AT SCREEN.



    " ## ##

    IF P_CREATE = 'X'.

      IF SCREEN-GROUP1 = 'CR'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'FI'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    " ## ##

    IF P_FIND = 'X'.

      IF SCREEN-GROUP1 = 'FI'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'CR'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_SELECTION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALIDATE_SELECTION .

  IF P_CREATE = 'X'.



    IF P_BUKRS IS INITIAL.

      MESSAGE '## ### #####.' TYPE 'E'.

      EXIT.

    ENDIF.



    IF P_KTOKK IS INITIAL.

      MESSAGE '###### #####.' TYPE 'E'.

      EXIT.

    ENDIF.



  ELSEIF P_FIND = 'X'.



    IF P_LIFNR IS INITIAL.

      MESSAGE '###### #####.' TYPE 'E'.

      EXIT.

    ENDIF.



    IF P_BUKRS IS INITIAL.

      MESSAGE '##### #####.' TYPE 'E'.

      EXIT.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_ADD_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_ADD_BUTTON .

  GV_MODE = 'A'.

  BUKRS = P_BUKRS.

  KTOKK = P_KTOKK.

  LEAVE TO SCREEN 200.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MM_SAVE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MM_SAVE.

  DATA : LV_NEW_LIFNR TYPE ZEDT06_LFA1-LIFNR.



  SELECT MAX( LIFNR ) INTO LV_NEW_LIFNR FROM ZEDT06_LFA1.

  IF LV_NEW_LIFNR IS INITIAL.

    LV_NEW_LIFNR = 1000000000.

  ELSE.

    LV_NEW_LIFNR = LV_NEW_LIFNR + 1.

  ENDIF.



  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT         = LV_NEW_LIFNR

   IMPORTING

      OUTPUT        = LV_NEW_LIFNR.



  LIFNR_A1 = LV_NEW_LIFNR.

  LIFNR_B1 = LV_NEW_LIFNR.

  LIFNR_M1 = LV_NEW_LIFNR.



  CLEAR : GS_LFA1.

  GS_LFA1-LIFNR = LIFNR_A1.

  GS_LFA1-NAME1 = NAME1.

  GS_LFA1-LAND1 = LAND1.

  GS_LFA1-KTOKK = KTOKK.

  GS_LFA1-STCD1 = STCD1.

  GS_LFA1-STCD2 = STCD2.

  GS_LFA1-STRAS = STRAS.



  CLEAR : GS_LFB1.

  GS_LFB1-LIFNR = LIFNR_B1.

  GS_LFB1-BUKRS = BUKRS.

  GS_LFB1-LOEVM = LOEVM_B1.

  GS_LFB1-AKONT = AKONT.

  GS_LFB1-ZTERM = ZTERM.



  CLEAR : GS_LFM1.

  GS_LFM1-LIFNR = LIFNR_M1.

  GS_LFM1-EKORG = EKORG.

  GS_LFM1-EKGRP = EKGRP.

  GS_LFM1-LOEVM = LOEVM_M1.

  GS_LFM1-WAERS = WAERS.

  GS_LFM1-MWSKZ = MWSKZ.



  DATA : LS_LFA1_DB TYPE ZEDT06_LFA1.

  MOVE-CORRESPONDING GS_LFA1 TO LS_LFA1_DB.

  INSERT INTO ZEDT06_LFA1 VALUES LS_LFA1_DB.



  DATA : LS_LFB1_DB TYPE ZEDT06_LFB1.

  MOVE-CORRESPONDING GS_LFB1 TO LS_LFB1_DB.

  INSERT INTO ZEDT06_LFB1 VALUES LS_LFB1_DB.



  DATA : LS_LFM1_DB TYPE ZEDT06_LFM1.

  MOVE-CORRESPONDING GS_LFM1 TO LS_LFM1_DB.

  INSERT INTO ZEDT06_LFM1 VALUES LS_LFM1_DB.



  IF SY-SUBRC = 0.

    MESSAGE '### ## ##.' TYPE 'I'.

  ELSE.

    MESSAGE '## # ## ##.' TYPE 'E'.

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




FORM GET_DATA.

  DATA : LV_LIFNR TYPE ZEDT06_LFA1-LIFNR.

  LV_LIFNR = P_LIFNR.



  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

  EXPORTING

    INPUT = LV_LIFNR

  IMPORTING

    OUTPUT = LV_LIFNR.





  SELECT SINGLE * FROM ZEDT06_LFA1

    INTO CORRESPONDING FIELDS OF GS_LFA1

    WHERE LIFNR = LV_LIFNR.



  IF GS_LFA1 IS INITIAL.

    MESSAGE '## ### ### ## ####.' TYPE 'E'.

  ENDIF.



  SELECT SINGLE * FROM ZEDT06_LFB1

    INTO CORRESPONDING FIELDS OF GS_LFB1

    WHERE LIFNR = LV_LIFNR

    AND BUKRS = P_BUKRS.



  IF GS_LFB1 IS INITIAL.

    MESSAGE '####### ### ## ####.' TYPE 'E'.

  ENDIF.



  SELECT SINGLE * FROM ZEDT06_LFM1

    INTO CORRESPONDING FIELDS OF GS_LFM1

    WHERE LIFNR = LV_LIFNR.



  IF GS_LFM1 IS INITIAL.

    MESSAGE '####### ### ## ####.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  CASE : GS_LFA1-KTOKK.

    WHEN '1000'. GS_LFA1-KTOKK_N = '##'.

    WHEN '2000'. GS_LFA1-KTOKK_N = '##'.

    WHEN '3000'. GS_LFA1-KTOKK_N = '##'.

    WHEN '3001'. GS_LFA1-KTOKK_N = '##'.

    WHEN '4000'. GS_LFA1-KTOKK_N = '####'.

    WHEN '5000'. GS_LFA1-KTOKK_N = '####'.

    WHEN '5000'. GS_LFA1-KTOKK_N = '1##'.

  ENDCASE.



  CASE : GS_LFB1-AKONT.

    WHEN '2100001010'. GS_LFB1-AKONT_N = '#####_##'.

    WHEN '2100001020'. GS_LFB1-AKONT_N = '#####_##'.

    WHEN '2100001030'. GS_LFB1-AKONT_N = '#####_##'.

    WHEN '2100001040'. GS_LFB1-AKONT_N = '####'.

    WHEN '2100002010'. GS_LFB1-AKONT_N = '####_##'.

    WHEN '2100002020'. GS_LFB1-AKONT_N = '####_##'.

    WHEN '2100002030'. GS_LFB1-AKONT_N = '####_####'.

    WHEN '2100003010'. GS_LFB1-AKONT_N = '#####_####'.

    WHEN '2100003020'. GS_LFB1-AKONT_N = '#####_##'.

    WHEN '2100003030'. GS_LFB1-AKONT_N = '#####_###'.

    WHEN '2100003040'. GS_LFB1-AKONT_N = '#####_###'.

    WHEN '2100003050'. GS_LFB1-AKONT_N = '#####_##'.

    WHEN '2100004010'. GS_LFB1-AKONT_N = '######'.

    WHEN '2100005010'. GS_LFB1-AKONT_N = '######'.

  ENDCASE.



  CASE : GS_LFB1-ZTERM.

    WHEN 'M001'. GS_LFB1-ZTERM_N = '##10###'.

    WHEN 'M002'. GS_LFB1-ZTERM_N = '##25###'.

    WHEN 'M003'. GS_LFB1-ZTERM_N = '##10###'.

    WHEN 'M004'. GS_LFB1-ZTERM_N = '##25###'.

    WHEN 'M005'. GS_LFB1-ZTERM_N = '###10###'.

    WHEN 'M006'. GS_LFB1-ZTERM_N = '###25###'.

    WHEN 'M010'. GS_LFB1-ZTERM_N = '10#####'.

    WHEN 'M015'. GS_LFB1-ZTERM_N = '15#####'.

    WHEN 'M020'. GS_LFB1-ZTERM_N = '20#####'.

    WHEN 'M030'. GS_LFB1-ZTERM_N = '30#####'.

    WHEN 'M060'. GS_LFB1-ZTERM_N = '60#####'.

    WHEN 'M090'. GS_LFB1-ZTERM_N = '90#####'.

  ENDCASE.



  CASE : GS_LFM1-MWSKZ.

    WHEN 'V1'. GS_LFM1-MWSKZ_N = '####10%'.

    WHEN 'V2'. GS_LFM1-MWSKZ_N = '####0%'.

    WHEN 'V3'. GS_LFM1-MWSKZ_N = '####0%'.

    WHEN 'V4'. GS_LFM1-MWSKZ_N = '#####'.

    WHEN 'V5'. GS_LFM1-MWSKZ_N = '######'.

  ENDCASE.



  MOVE-CORRESPONDING GS_LFA1 TO GS_ALV.

  MOVE-CORRESPONDING GS_LFB1 TO GS_ALV.

  MOVE-CORRESPONDING GS_LFM1 TO GS_ALV.



  GS_ALV-LIFNR_A1 = GS_ALV-LIFNR.

  GS_ALV-LIFNR_B1 = GS_ALV-LIFNR.

  GS_ALV-LIFNR_M1 = GS_ALV-LIFNR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_VALID

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_VALID .

  " #### ### ##### ### #####.

  IF NAME1 IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'E'.

  ENDIF.



  IF LAND1 IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'E'.

  ENDIF.



  IF KTOKK IS INITIAL.

    MESSAGE '##### ### #####.' TYPE 'E'.

  ENDIF.



  IF  KTOKK = 3000.

    IF STCD1 IS INITIAL.

      MESSAGE '#### ### #####.' TYPE 'E'.

    ENDIF.

  ELSEIF KTOKK <> 2000.

    IF STCD2 IS INITIAL.

      MESSAGE '##### ### #####.' TYPE 'E'.

    ENDIF.

  ENDIF.



  IF STRAS IS INITIAL.

    MESSAGE '## ### #####.' TYPE 'E'.

  ENDIF.



  IF BUKRS IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'E'.

  ENDIF.



  IF AKONT IS INITIAL.

    MESSAGE '## ### #####.' TYPE 'E'.

  ENDIF.



  IF ZTERM IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'E'.

  ENDIF.



   IF EKORG IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'E'.

  ENDIF.



   IF EKGRP IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'E'.

  ENDIF.



   IF WAERS IS INITIAL.

    MESSAGE '###### ### #####.' TYPE 'E'.

  ENDIF.



   IF MWSKZ IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'E'.

  ENDIF.



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

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  IF SY-SUBRC <> 0.

    MESSAGE 'DOCKING ## ## ##.' TYPE 'E'.

  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.



  IF SY-SUBRC <> 0.

    MESSAGE 'GRID ## ## ##.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_TEST

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_TEST .

  "===== LFA1 ## ### =====

  NAME1    = '######'.

  LAND1    = 'KR'.

  STRAS    = '##### ###'.



  "===== LFB1 #### ### =====

  LOEVM_B1 = ''.

  AKONT    = '2100001010'.

  ZTERM    = 'M001'.



  "===== LFM1 #### ### =====

  EKORG    = '1000'.

  EKGRP    = '001'.

  LOEVM_M1 = ''.

  WAERS    = 'KRW'.

  MWSKZ    = 'V1'.





  IF KTOKK = '3000'. " ### ## #####

    STCD2 = ''.

  ELSEIF KTOKK = '2000'. " ### ## ## ### ##.

    STCD1 = ''.

    STCD2 = ''.

  ELSE. " ### ## ######

    STCD1 = ''.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_STDC2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHANGE_LFA1_STCD2 .

  " ### ## DB# ######



  IF GS_ALV-STCD2 IS INITIAL.

    MESSAGE '###### ######.' TYPE 'E'.

  ENDIF.



  UPDATE ZEDT06_LFA1

  SET STCD2 = GS_ALV-STCD2

  WHERE LIFNR = GS_ALV-LIFNR.





  IF SY-SUBRC = 0.

    MESSAGE '###### #######.' TYPE 'S'.

  ELSE.

    MESSAGE '### ######. ##### #####.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_VAILDATION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_VAILDATION .



  DATA LV_VALUE TYPE LVC_VALUE.



  LV_VALUE = P_KTOKK.

  PERFORM CHECK_DOMAIN_VALUE USING 'ZKTOKK06' LV_VALUE.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_MATNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CHECK_DOMAIN_VALUE

  USING

    P_DOMNAME TYPE DD07L-DOMNAME

    P_VALUE   TYPE LVC_VALUE.



  DATA LV_DUMMY TYPE DD07L-DOMVALUE_L.



  SELECT SINGLE DOMVALUE_L

    INTO LV_DUMMY

    FROM DD07L

    WHERE DOMNAME    = P_DOMNAME

      AND DOMVALUE_L = P_VALUE.



  IF SY-SUBRC <> 0.

    MESSAGE |### { P_DOMNAME }# #### ## ####.| TYPE 'E'.

  ENDIF.



ENDFORM.