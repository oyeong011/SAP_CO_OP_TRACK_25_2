
*&---------------------------------------------------------------------*

*&  Include           ZMM05_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






FORM SELECTION_SCREEN .

  LOOP AT SCREEN.

    IF P_CRE = C_X.

      IF SCREEN-GROUP1 = 'M2'. " ####(LIFNR) ##

        SCREEN-ACTIVE = 0.

      ENDIF.

    ELSEIF P_VIEW = C_X.

      IF SCREEN-GROUP1 = 'M1'. " ####(KTOKK) ##

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PREPARE_CREATE_MODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form PREPARE_CREATE_MODE .

  CLEAR : GV_LIFNR, GV_NAME1, GV_LAND1, GV_STCD1, GV_STCD2, GV_STRAS,

          GV_AKONT, GV_ZTERM, GV_EKORG, GV_EKGRP, GV_WAERS, GV_MWSKZ.

  DATA : LV_MAX_LIFNR TYPE ZLFA1_05-LIFNR.

  GV_KTOKK = P_KTOKK.

  GV_BUKRS = P_BUKRS.



  SELECT MAX( LIFNR ) INTO LV_MAX_LIFNR

    FROM ZLFA1_05.



  IF LV_MAX_LIFNR IS INITIAL.

    GV_LIFNR = '1000000000'.

  ELSE.

    GV_LIFNR = LV_MAX_LIFNR + 1.

  ENDIF.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*form GET_DATA .

*  SELECT SINGLE NAME1 LAND1 KTOKK STCD1 STCD2 STRAS

*    INTO (GV_NAME1, GV_LAND1, GV_KTOKK, GV_STCD1, GV_STCD2, GV_STRAS)

*    FROM ZLFA1_05

*  WHERE LIFNR = P_LIFNR.

*

*  IF SY-SUBRC = 0.

*    GV_LIFNR = P_LIFNR.

*    SELECT SINGLE AKONT ZTERM

*      INTO (GV_AKONT, GV_ZTERM)

*      FROM ZLFB1_05

*      WHERE LIFNR = P_LIFNR

*      AND BUKRS = P_BUKRS.

*

*    SELECT SINGLE EKORG EKGRP WAERS MWSKZ

*      INTO (GV_EKORG, GV_EKGRP, GV_WAERS, GV_MWSKZ)

*      FROM ZLFM1_05

*     WHERE LIFNR = P_LIFNR.

*

*   ELSE.

*     MESSAGE '## #### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

*   ENDIF.

*endform.



*&---------------------------------------------------------------------*

*&      Form  CALL_F4_HELP

*&---------------------------------------------------------------------*




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

FORM GET_DATA .



  "--- # ## ### ##

  IF p_lifnr IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  IF p_bukrs IS INITIAL.

    MESSAGE '##### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  "--- # ### ### ## ##

  SELECT SINGLE name1 land1 ktokk stcd1 stcd2 stras

    INTO (gv_name1, gv_land1, gv_ktokk, gv_stcd1, gv_stcd2, gv_stras)

    FROM zLFA1_05

   WHERE lifnr = p_lifnr.



  IF sy-subrc <> 0.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.





  "--- # ##### ### ### ##

  SELECT SINGLE akont zterm

    INTO (gv_akont, gv_zterm)

    FROM zLFB1_05

   WHERE lifnr = p_lifnr

     AND bukrs = p_bukrs.



  IF sy-subrc <> 0.

    MESSAGE '## ##### #### #### ## ####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  "--- # #### ### ##

  SELECT SINGLE ekorg ekgrp waers mwskz

    INTO (gv_ekorg, gv_ekgrp, gv_waers, gv_mwskz)

    FROM zLFM1_05

   WHERE lifnr = p_lifnr.



  IF sy-subrc <> 0.

    MESSAGE '#### #### #### ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  GV_LIFNR = P_LIFNR.

  GV_BUKRS = P_BUKRS.







ENDFORM.










*&---------------------------------------------------------------------*

*&      Form  CHECK_PARAM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CHECK_PARAM .

  IF P_BUKRS IS INITIAL.

    MESSAGE I000.

    STOP.

  ELSEIF P_KTOKK IS INITIAL and P_LIFNR IS INITIAL.

    MESSAGE I000.

    STOP.

  ENDIF.

endform.