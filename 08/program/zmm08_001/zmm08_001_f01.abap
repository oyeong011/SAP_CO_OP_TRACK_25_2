
*&---------------------------------------------------------------------*

*&  Include           ZMM08_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULTS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULTS . " #### ### # #### ### ##

  GV_BUKRS_C = '1100'.

  GV_BUKRS_Q = '1100'.



  TEXT_B1 = '### ## ## # ##'.

  TEXT_B2 = '## ##'.



  text_c01 = '##'.

  text_c02 = '##'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  START_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM START_SCREEN . " F8 ## ## # #### ##



  " ## ### ## ### ##

  PERFORM CHECK_SELECTION_DATA.



  " ## ## ## ### ##

  GV_BUKRS_C = P_BUKRS.

  GV_KTOKK_C = P_KTOKK.

  GV_LIFNR_Q = P_LIFNR.

  GV_BUKRS_Q = P_BUKRS.



  " ### ## ## ## ##

  IF GV_MODE = 'C'.

    " ## ##

    PERFORM SET_MODE_CREATE.

    CALL SCREEN 200.

  ELSEIF GV_MODE = 'Q'.

    " ## ##

    PERFORM SET_MODE_QUERY.

    CALL SCREEN 100.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLEAR_DETAIL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLEAR_DETAIL . " ## ## ## #### ### ###



  CLEAR: GS_LFA1, GS_LFB1, GS_LFM1, GV_CURR_KTOKK.

  GV_SHOW_DETAIL = ABAP_FALSE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_MODE_CREATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_MODE_CREATE . " ## ### #### #, #### ##



  GV_MODE = 'C'.



  PERFORM CLEAR_DETAIL.



  " ####/##### ## ### ##

  GV_CURR_KTOKK = GV_KTOKK_C.

  GV_SHOW_DETAIL = ABAP_TRUE.



  " ### ##

  GS_LFA1-KTOKK = GV_KTOKK_C.

  GS_LFA1-LAND1 = 'KR'.

  GS_LFB1-BUKRS = GV_BUKRS_C.

  GS_LFM1-EKORG = GC_EKORG.

  GS_LFM1-EKGRP = GC_EKGRP.

  GS_LFM1-WAERS = GC_WAERS.

  GS_LFM1-MWSKZ = GC_MWSKZ.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_MODE_QUERY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_MODE_QUERY . " ## ### #### #, DB## #### ####



  GV_MODE = 'Q'.

  PERFORM CLEAR_DETAIL.



  " ## ##

  IF GV_LIFNR_Q IS INITIAL OR GV_BUKRS_Q IS INITIAL.

    MESSAGE '###### ##### ## #####.' TYPE 'E'.

  ENDIF.



  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT = GV_LIFNR_Q

    IMPORTING

      OUTPUT = GV_LIFNR_Q.



  " ## ### ##

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_LFA1

    FROM ZEDT08_LFA1 WHERE LIFNR = GV_LIFNR_Q.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### #### ####.' TYPE 'E'.

  ENDIF.



  " ## ### ##

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_LFB1

    FROM ZEDT08_LFB1 WHERE LIFNR = GV_LIFNR_Q AND BUKRS = GV_BUKRS_Q.



  IF SY-SUBRC <> 0.

    MESSAGE '#### #### #### ####.' TYPE 'E'.

  ENDIF.



  " ## ### ##

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_LFM1

    FROM ZEDT08_LFM1 WHERE LIFNR = GV_LIFNR_Q AND EKORG = GC_EKORG.



  " IF SY-SUBRC <> 0.

    " CLEAR GS_LFM1.

    " GS_LFM1-LIFNR = GV_LIFNR_Q.

    " GS_LFM1-EKORG = GC_EKORG.

    " GS_LFM1-EKGRP = GC_EKGRP.

    " GS_LFM1-WAERS = GC_WAERS.

    " GS_LFM1-MWSKZ = GC_MWSKZ.

  " ENDIF.



  GV_CURR_KTOKK = GS_LFA1-KTOKK.

  GV_SHOW_DETAIL = ABAP_TRUE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_VENDOR_ID

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPDATE_VENDOR_ID . " ### #### DB# ####



  DATA: LS_SAVE TYPE ZEDT08_LFA1.



  IF GV_MODE <> 'Q'.

    MESSAGE '## ##### ## ### #####.' TYPE 'E'.

  ENDIF.



  IF GV_LIFNR_Q IS INITIAL.

    MESSAGE '## ### #####.' TYPE 'E'.

  ENDIF.



  PERFORM CHECK_INPUT_VALID.



  " ## ##

  MOVE-CORRESPONDING GS_LFA1 TO LS_SAVE.

  UPDATE ZEDT08_LFA1 FROM LS_SAVE.



  IF SY-SUBRC <> 0.

    MESSAGE 'LFA1 #### ##' TYPE 'E'.

    ROLLBACK WORK.

  ENDIF.



  " COMMIT WORK.

  COMMIT WORK AND WAIT.



  MESSAGE '#####(#### ##) ##### #######.' TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SCREEN_BY_KTOKK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_SCREEN_BY_KTOKK .






*  DATA: LV_KTOKK TYPE ZEDT08_LFA1-KTOKK.

*  LV_KTOKK = GV_CURR_KTOKK.

*

*  LOOP AT SCREEN.

*

*    IF GV_SHOW_DETAIL = ABAP_FALSE.

*      IF SCREEN-GROUP1 = 'DTL'.

*        SCREEN-ACTIVE = 0.

*        MODIFY SCREEN.

*      ENDIF.

*      CONTINUE.

*    ENDIF.

*

*    IF SCREEN-GROUP1 = 'DTL'.

*      SCREEN-ACTIVE = 1.

*    ENDIF.

*

*    MODIFY SCREEN.

*

*  ENDLOOP.



*  DATA: LV_KTOKK TYPE ZEDT08_LFA1-KTOKK.

*

*  LV_KTOKK = GV_CURR_KTOKK.

*

*  LOOP AT SCREEN.

*

*    " 1. ## ## ## ### ##### ## ##

*    IF GV_SHOW_DETAIL = ABAP_FALSE.

*      IF SCREEN-GROUP1 = 'DTL'.

*        SCREEN-ACTIVE = 0.

*        MODIFY SCREEN.

*      ENDIF.

*      CONTINUE.

*    ENDIF.

*

*    " 2. ## ### #####, ##### DTL ### ###

*    IF SCREEN-GROUP1 = 'DTL'.

*      SCREEN-ACTIVE = 1.

*    ENDIF.

*

*    " 3. ### ## ##

*    CASE SCREEN-NAME.

*      WHEN 'GS_LFB1-BUPLA'.

*        IF LV_KTOKK = '1000' OR LV_KTOKK = '3000'.

*          SCREEN-ACTIVE = 1.

*        ELSE.

*          SCREEN-ACTIVE = 0.

*        ENDIF.

*      WHEN 'GS_LFA1-BRSCH'.

*        IF LV_KTOKK = '1000' OR LV_KTOKK = '2000'.

*          SCREEN-ACTIVE = 1.

*        ELSE.

*          SCREEN-ACTIVE = 0.

*        ENDIF.

*      WHEN 'GS_LFA1-STCD1' OR 'GS_LFA1-STCD2'.

*        IF LV_KTOKK = '1000' OR LV_KTOKK = '3000'.

*          SCREEN-ACTIVE = 1.

*        ELSE.

*          SCREEN-ACTIVE = 0.

*        ENDIF.

*      WHEN 'GS_LFA1-STCD3' OR 'GS_LFA1-STCD4'.

*        IF LV_KTOKK = '3000'.

*          SCREEN-ACTIVE = 1.

*        ELSE.

*          SCREEN-ACTIVE = 0.

*        ENDIF.

*    ENDCASE.

*

*    MODIFY SCREEN.

*

*  ENDLOOP.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_SELECTION_SCREEN . " ## ### ## ### ### ### ## ##



  LOOP AT SCREEN.



    " ## ##

    IF P_CREATE = 'X'.

      " ####, ## ## ##

      IF SCREEN-NAME CS 'P_BUKRS' OR SCREEN-NAME CS 'P_KTOKK'.

        SCREEN-REQUIRED = '1'.

      ENDIF.

      IF SCREEN-NAME CS 'P_LIFNR'.

        SCREEN-ACTIVE = '0'.

        MODIFY SCREEN.

      ENDIF.

    " ## ##

    ELSEIF P_FIND = 'X'.

      " #####, #### ## ##

      IF SCREEN-NAME CS 'P_LIFNR' OR SCREEN-NAME CS 'P_BUKRS'.

        SCREEN-REQUIRED = '1'.

      ENDIF.

      " ## ####

      IF SCREEN-NAME CS 'P_KTOKK'.

        SCREEN-ACTIVE = '0'.

        MODIFY SCREEN.

      ENDIF.

    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SELECTION_SCREEN . " ## F8 # #### ## ##



  CHECK SY-UCOMM = 'ONLI'. " ## ## ### ###



  " 1. ## ### # ### ##

  IF P_CREATE = 'X'.

    IF P_BUKRS IS INITIAL.

      MESSAGE '## # [####]# #####.' TYPE 'E'.

    ENDIF.

    IF P_KTOKK IS INITIAL.

      MESSAGE '## # [#####]# #####.' TYPE 'E'.

    ENDIF.



  " 2. ## ### # ### ##

  ELSEIF P_FIND = 'X'.

    IF P_LIFNR IS INITIAL.

      MESSAGE '## # [#####]# #####.' TYPE 'E'.

    ENDIF.

    IF P_BUKRS IS INITIAL.

      MESSAGE '## # [####]# #####.' TYPE 'E'.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SELECTION_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_SELECTION_DATA . " ## #### ##



  IF P_CREATE = 'X'.

    GV_MODE = 'C'.

  ELSEIF P_FIND = 'X'.

    GV_MODE = 'Q'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_VALID

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_VALID . " ## # ## #### ##



  IF GS_LFA1-NAME1 IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFA1-LAND1 IS INITIAL.

    MESSAGE '### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFA1-KTOKK IS INITIAL.

    MESSAGE '###### ####.' TYPE 'E'.

  ENDIF.



  " ### ## ## ## ##




*  IF GS_LFA1-KTOKK = '3000'.

*    IF GS_LFA1-STCD1 IS INITIAL.

*      MESSAGE '### ## [####]# #####.' TYPE 'E'.

*    ENDIF.

*  ELSE.

*    IF GS_LFA1-STCD2 IS INITIAL.

*      MESSAGE '#### ## [#####]# #####.' TYPE 'E'.

*    ENDIF.

*  ENDIF.




  CASE GS_LFA1-KTOKK.

    WHEN '3000'. " ##

      IF GS_LFA1-STCD1 IS INITIAL.

        MESSAGE '### ## [######(STCD1)]# #####.' TYPE 'E'.

      ENDIF.

    WHEN '2000'. " ## (## ##)

      " Pass (###### ## ## ##)

    WHEN OTHERS. " 1000 # ## ###

      IF GS_LFA1-STCD2 IS INITIAL.

        MESSAGE '#### ## [#####(STCD2)]# #####.' TYPE 'E'.

      ENDIF.

  ENDCASE.



  IF GS_LFA1-STRAS IS INITIAL.

    MESSAGE '### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFB1-BUKRS IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFB1-AKONT IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFB1-ZTERM IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFM1-EKORG IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFM1-EKGRP IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFM1-WAERS IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFM1-MWSKZ IS INITIAL.

    MESSAGE '##### #####.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MM_SAVE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MM_SAVE . " #### DB# ##### ##



  DATA: LS_SAVE_LFA1 TYPE ZEDT08_LFA1,

        LS_SAVE_LFB1 TYPE ZEDT08_LFB1,

        LS_SAVE_LFM1 TYPE ZEDT08_LFM1.



  " ### ## # ### ##

  PERFORM MAP_INPUT_TO_STRUCTS.

  PERFORM CHECK_INPUT_VALID.



  IF GV_MODE = 'C'.

    " ## ##

    PERFORM GET_NEW_LIFNR CHANGING GS_LFA1-LIFNR.



    GS_LFB1-LIFNR = GS_LFA1-LIFNR.

    GS_LFM1-LIFNR = GS_LFA1-LIFNR.



    " ## ##

    SELECT SINGLE lifnr FROM zedt08_lfa1

      WHERE lifnr = @gs_lfa1-lifnr

      INTO @DATA(lv_exist).

    IF sy-subrc = 0.

      MESSAGE '## #### ########.' TYPE 'E'.

    ENDIF.



    " ### ### ##

    MOVE-CORRESPONDING GS_LFA1 TO LS_SAVE_LFA1.

    MOVE-CORRESPONDING GS_LFB1 TO LS_SAVE_LFB1.

    MOVE-CORRESPONDING GS_LFM1 TO LS_SAVE_LFM1.



    " DB INSERT

    INSERT ZEDT08_LFA1 FROM LS_SAVE_LFA1.

    INSERT ZEDT08_LFB1 FROM LS_SAVE_LFB1.

    INSERT ZEDT08_LFM1 FROM LS_SAVE_LFM1.



    IF SY-SUBRC = 0.

      MESSAGE '#### #######.' TYPE 'S'.

      COMMIT WORK AND WAIT.

    ELSE.

      MESSAGE '## # ## ##' TYPE 'E'.

      ROLLBACK WORK.

      EXIT.

    ENDIF.

  ELSEIF GV_MODE = 'Q'.

    MOVE-CORRESPONDING GS_LFA1 TO LS_SAVE_LFA1.



    UPDATE ZEDT08_LFA1 FROM LS_SAVE_LFA1.

    IF SY-SUBRC = 0.

      MESSAGE '#######.' TYPE 'S'.

    ELSE.

      MESSAGE '## ##' TYPE 'E'.

      ROLLBACK WORK.

      EXIT.

    ENDIF.



    COMMIT WORK AND WAIT.

    LEAVE TO SCREEN 0.

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




FORM SAVE_TEST . " #### ## ###



  GS_LFA1-NAME1 = '### ###'.

  GS_LFA1-LAND1 = 'KR'.

  GS_LFA1-STRAS = '### ###'.



  IF GS_LFA1-KTOKK = '3000'.

    GS_LFA1-STCD1 = '8001011234567'.

    CLEAR GS_LFA1-STCD2.

  ELSE.

    GS_LFA1-STCD2 = '123-45-67890'.

    CLEAR GS_LFA1-STCD1.

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




FORM CHECK_ADD_BUTTON . " ### ### ## # ## ### ##



  MESSAGE '### #### #######.' TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_NEW_LIFNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_LFA1_LIFNR  text

*----------------------------------------------------------------------*




FORM GET_NEW_LIFNR  CHANGING P_GS_LFA1_LIFNR TYPE ZEDT08_LFA1-LIFNR. " ## # ### ### ## +1

  DATA: LV_MAX_LIFNR TYPE ZEDT08_LFA1-LIFNR,

        LV_NEXT TYPE ZEDT08_LFA1-LIFNR.



  SELECT MAX( LIFNR ) INTO LV_MAX_LIFNR FROM ZEDT08_LFA1.



  IF LV_MAX_LIFNR IS INITIAL.

    LV_NEXT = '1000000000'. " #### ## ## ###

  ELSE.

    LV_NEXT = LV_MAX_LIFNR + 1.

  ENDIF.



  " ### ### ##

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT = LV_NEXT

      IMPORTING

        OUTPUT = LV_NEXT.



  P_GS_LFA1_LIFNR = LV_NEXT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAP_INPUT_TO_STRUCTS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAP_INPUT_TO_STRUCTS . " ## ## ### ## #### ###



  " LFA1 ##

  GS_LFA1-LIFNR = LIFNR_A1.

  GS_LFA1-NAME1 = NAME1.

  GS_LFA1-LAND1 = LAND1.

  GS_LFA1-KTOKK = KTOKK.

  GS_LFA1-STCD1 = STCD1.

  GS_LFA1-STCD2 = STCD2.

  GS_LFA1-STRAS = STRAS.



  " LFB1 ##

  GS_LFB1-LIFNR = LIFNR_B1.

  GS_LFB1-BUKRS = BUKRS.

  GS_LFB1-LOEVM = LOEVM_B1.

  GS_LFB1-AKONT = AKONT.

  GS_LFB1-ZTERM = ZTERM.



  " LFM1 ##

  GS_LFM1-LIFNR = LIFNR_M1.

  GS_LFM1-EKORG = EKORG.

  GS_LFM1-EKGRP = EKGRP.

  GS_LFM1-WAERS = WAERS.

  GS_LFM1-MWSKZ = MWSKZ.



  " ALPHA ###

  IF GS_LFA1-LIFNR IS NOT INITIAL.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT = GS_LFA1-LIFNR

      IMPORTING

        OUTPUT = GS_LFA1-LIFNR.

  ENDIF.



  IF GS_LFB1-LIFNR IS NOT INITIAL.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT = GS_LFB1-LIFNR

      IMPORTING

        OUTPUT = GS_LFB1-LIFNR.

  ENDIF.



  IF GS_LFM1-LIFNR IS NOT INITIAL.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT = GS_LFM1-LIFNR

      IMPORTING

        OUTPUT = GS_LFM1-LIFNR.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LOCK_FIXED_FIELDS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LOCK_FIXED_FIELDS . " ## ### ## ##### ###



  LOOP AT SCREEN.

    IF SCREEN-NAME = 'BUKRS' OR SCREEN-NAME = 'GS_LFB1-BUKRS'.

      SCREEN-INPUT = 0.

      SCREEN-REQUIRED = 0.

      MODIFY SCREEN.

    ELSEIF SCREEN-NAME = 'KTOKK' OR SCREEN-NAME = 'GS_LFA1-KTOKK'.

      SCREEN-INPUT = 0.

      SCREEN-REQUIRED = 0.

      MODIFY SCREEN.

    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_UPDATE_ID_ONLY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_UPDATE_ID_ONLY . " ## ## #, ## ## ### ### ## ##



  IF GV_CURR_KTOKK = '3000'.

    IF GS_LFA1-STCD1 IS INITIAL.

      MESSAGE '### ## [####]# #####.' TYPE 'E'.

    ENDIF.

  ELSE.

    IF GS_LFA1-STCD2 IS INITIAL.

      MESSAGE '#### ## [#####]# #####.' TYPE 'E'.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LOCK_FIXED_FIELDS_Q

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LOCK_FIXED_FIELDS_Q . " ## ### # ## ### ###



  LOOP AT SCREEN.

    IF SCREEN-NAME = 'GS_LFB1-BUKRS' OR SCREEN-NAME = 'BUKRS'.

      SCREEN-INPUT = 0.

      SCREEN-REQUIRED = 0.

      MODIFY SCREEN.

    ELSEIF SCREEN-NAME = 'GS_LFA1-KTOKK' OR SCREEN-NAME = 'KTOKK'.

      SCREEN-INPUT = 0.

      SCREEN-REQUIRED = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LOCK_ALL_EXCEPT_STCD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LOCK_ALL_EXCEPT_STCD . " ###### ### ## ### ## ### ###



  DATA: LV_IS_PERSONAL TYPE ABAP_BOOL.



  IF GV_CURR_KTOKK = '3000'.

    LV_IS_PERSONAL = ABAP_TRUE.

  ELSE.

    LV_IS_PERSONAL = ABAP_FALSE.

  ENDIF.



  LOOP AT SCREEN.



    SCREEN-INPUT = 0. " # ###



    IF SCREEN-NAME = 'GS_ALV-STCD2'.

      SCREEN-INPUT = 1. " ###### ##

      SCREEN-REQUIRED = 1.

    ENDIF.



    MODIFY SCREEN.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_SCREEN . " ### #### ## ### ##



  GS_ALV-LIFNR_A1   = GS_LFA1-LIFNR.

  GS_ALV-LAND1      = GS_LFA1-LAND1.

  GS_ALV-NAME1      = GS_LFA1-NAME1.

  GS_ALV-KTOKK_NAME = GS_LFA1-KTOKK.

  GS_ALV-STCD1      = GS_LFA1-STCD1.

  GS_ALV-STCD2      = GS_LFA1-STCD2.

  GS_ALV-STRAS      = GS_LFA1-STRAS.



  GS_ALV-BUKRS      = GS_LFB1-BUKRS.

  GS_ALV-AKONT_NAME = GS_LFB1-AKONT.

  GS_ALV-ZTERM_NAME = GS_LFB1-ZTERM.



  GS_ALV-EKORG      = GS_LFM1-EKORG.

  GS_ALV-EKGRP      = GS_LFM1-EKGRP.

  GS_ALV-WAERS      = GS_LFM1-WAERS.

  GS_ALV-MWSKZ_NAME = GS_LFM1-MWSKZ.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_STCD2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPDATE_STCD2 . " ## #### ###### ### #### ##



  DATA: LV_LIFNR TYPE ZEDT08_LFA1-LIFNR.



  IF GV_MODE <> 'Q'.

    MESSAGE '## ##### ###### ### # ####.' TYPE 'E'.

  ENDIF.



  IF GS_ALV-LIFNR_A1 IS INITIAL.

    MESSAGE '###### ## ####.' TYPE 'E'.

  ENDIF.



  GS_LFA1-STCD2 = GS_ALV-STCD2.



  IF GV_CURR_KTOKK = '3000'.

    MESSAGE '##(3000)# ###### ### ##### #####.' TYPE 'E'.

  ENDIF.



  IF GS_LFA1-STCD2 IS INITIAL.

    MESSAGE '###### #####.' TYPE 'E'.

  ENDIF.



  LV_LIFNR = GS_ALV-LIFNR_A1.



  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT = LV_LIFNR

    IMPORTING

      OUTPUT = LV_LIFNR.



  SELECT SINGLE LIFNR FROM ZEDT08_LFA1

    WHERE LIFNR = @LV_LIFNR INTO @DATA(LV_EXIST).



  IF SY-SUBRC <> 0.

    MESSAGE '## #### #### ####.' TYPE 'E'.

  ENDIF.



  UPDATE ZEDT08_LFA1 SET STCD2 = @GS_LFA1-STCD2

    WHERE LIFNR = @LV_LIFNR.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE '###### #######.' TYPE 'S'.



    SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_LFA1

      FROM ZEDT08_LFA1 WHERE LIFNR = LV_LIFNR.



    PERFORM MODIFY_SCREEN.

    PERFORM LOCK_ALL_EXCEPT_STCD.



  ELSE.

    ROLLBACK WORK.

    MESSAGE '### ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.