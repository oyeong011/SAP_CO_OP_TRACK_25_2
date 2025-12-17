
*&---------------------------------------------------------------------*

*&  Include           ZMM10_FK01_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  IF PR_SEAR = 'X'.

    " ##### ###.

    CLEAR: GS_LFA1, GS_LFB1, GS_LFM1, GS_VENDER.

    SELECT SINGLE * FROM ZEDT10_LFA1

      INTO CORRESPONDING FIELDS OF GS_LFA1

      WHERE LIFNR = P_LIFNR.

    IF SY-SUBRC <> 0.

      CLEAR GS_LFA1.

      MESSAGE '### ## ####.' TYPE 'E'.

      EXIT.

    ENDIF.

    SELECT SINGLE * FROM ZEDT10_LFB1

      INTO CORRESPONDING FIELDS OF GS_LFB1

      WHERE LIFNR = GS_LFA1-LIFNR AND LOEVM NE 'X'.

    IF SY-SUBRC <> 0.

      CLEAR GS_LFA1.

      CLEAR GS_LFB1.

      MESSAGE '### ## ####.' TYPE 'E'.

      EXIT.

    ENDIF.

    SELECT SINGLE * FROM ZEDT10_LFM1

      INTO CORRESPONDING FIELDS OF GS_LFM1

      WHERE LIFNR = GS_LFA1-LIFNR AND LOEVM NE 'X'.

    IF SY-SUBRC <> 0.

      CLEAR GS_LFA1.

      CLEAR GS_LFB1.

      CLEAR GS_LFM1.

      MESSAGE '### ## ####.' TYPE 'E'.

      EXIT.

    ENDIF.



    " #### ### CLEAR

    IF GS_LFA1 IS INITIAL.

      CLEAR GS_LFB1.

      CLEAR GS_LFM1.

      MESSAGE '### ## ####.' TYPE 'E'.

    ENDIF.



    CLEAR GS_VENDER.

    MOVE-CORRESPONDING GS_LFA1 TO GS_VENDER.

    MOVE-CORRESPONDING GS_LFB1 TO GS_VENDER.

    MOVE-CORRESPONDING GS_LFM1 TO GS_VENDER.

    GV_LIFNR = GS_VENDER-LIFNR.

    GV_NAME1 = GS_VENDER-NAME1.

    GV_LAND1 = GS_VENDER-LAND1.

    GV_KTOKK = GS_VENDER-KTOKK.

    GV_STCD1 = GS_VENDER-STCD1.

    GV_STCD2 = GS_VENDER-STCD2.

    GV_STRAS = GS_VENDER-STRAS.



    GV_BUKRS = GS_VENDER-BUKRS.

    GV_AKONT = GS_VENDER-AKONT.

    GV_ZTERM = GS_VENDER-ZTERM.



    GV_EKORG = GS_VENDER-EKORG.

    GV_EKGRP = GS_VENDER-EKGRP.

    GV_WAERS = GS_VENDER-WAERS.

    GV_MWSKZ = GS_VENDER-MWSKZ.

  ELSE.

    " ### # ##

    DATA: LV_NEXT_KEY TYPE ZEDT10_LFA1-LIFNR.

    SELECT MAX( LIFNR ) INTO LV_NEXT_KEY FROM ZEDT10_LFA1.



    IF SY-SUBRC NE 0.

      LV_NEXT_KEY = 1000000000.

    ELSE.

      LV_NEXT_KEY = LV_NEXT_KEY + 1.

    ENDIF.



    GV_LIFNR = LV_NEXT_KEY.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE .

  " 1##: ### ## (## ## 4#)

  IF GV_LIFNR IS INITIAL.

    MESSAGE E001 WITH 'LIFNR# #####'.

    LEAVE TO SCREEN 0.

  ENDIF.



  IF GV_NAME1 IS INITIAL.

    MESSAGE E001 WITH '##### #####'.

    LEAVE TO SCREEN 0.

  ENDIF.



  IF GV_KTOKK IS INITIAL.

    MESSAGE E001 WITH '##### #####'.

    LEAVE TO SCREEN 0.

  ENDIF.



  " 2##: ##### ## ## ## (## ## - 1#)




*  CASE GV_KTOKK.

*    WHEN '3000'.

*      " 3000: STCD1 ## (##ID)

*      IF GV_STCD1 IS INITIAL.

*        MESSAGE E001 WITH 'KTOKK=3000# ## STCD1(##ID1)# #####'.

*        LEAVE TO SCREEN 0.

*      ENDIF.

*      " STCD2# ### ## ## (##)

*

*    WHEN '2000'.

*      " 2000: STCD1# ##, STCD2 ###

**      IF GV_STCD2 IS NOT INITIAL.

**        MESSAGE E001 WITH 'KTOKK=2000# ## STCD2# ## #####'.

**        LEAVE TO SCREEN 0.

**      ENDIF.

*

*    WHEN OTHERS.

*      " ## ####: STCD1, STCD2 ## #### (## ##)

*      IF GV_STCD1 IS NOT INITIAL OR GV_STCD2 IS NOT INITIAL.

*        MESSAGE E001 WITH '# ##### ##ID ### #####'.

*        LEAVE TO SCREEN 0.

*      ENDIF.

*  ENDCASE.




  GS_VENDER-LIFNR  = GV_LIFNR.

  GS_VENDER-NAME1  = GV_NAME1.

  GS_VENDER-LAND1  = GV_LAND1.

  GS_VENDER-KTOKK  = GV_KTOKK.

  GS_VENDER-STCD1  = GV_STCD1.

  GS_VENDER-STCD2  = GV_STCD2.

  GS_VENDER-STRAS  = GV_STRAS.



  GS_VENDER-BUKRS  = GV_BUKRS.

  GS_VENDER-AKONT  = GV_AKONT.

  GS_VENDER-ZTERM  = GV_ZTERM.



  GS_VENDER-EKORG  = GV_EKORG.

  GS_VENDER-EKGRP  = GV_EKGRP.

  GS_VENDER-WAERS  = GV_WAERS.

  GS_VENDER-MWSKZ  = GV_MWSKZ.



  MOVE-CORRESPONDING GS_VENDER TO GS_LFA1.

  MOVE-CORRESPONDING GS_VENDER TO GS_LFB1.

  MOVE-CORRESPONDING GS_VENDER TO GS_LFM1.



  IF PR_CREA = 'X'.

    INSERT INTO ZEDT10_LFA1 VALUES GS_LFA1.

    IF SY-SUBRC <> 0.

      MESSAGE E001 WITH 'LFA1 INSERT ##'.

      ROLLBACK WORK.

      LEAVE TO SCREEN 0.

    ENDIF.



    INSERT INTO ZEDT10_LFB1 VALUES GS_LFB1.

    IF SY-SUBRC <> 0.

      MESSAGE E001 WITH 'LFB1 INSERT ##'.

      ROLLBACK WORK.

      LEAVE TO SCREEN 0.

    ENDIF.



    INSERT INTO ZEDT10_LFM1 VALUES GS_LFM1.

    IF SY-SUBRC <> 0.

      MESSAGE E001 WITH 'LFM1 INSERT ##'.

      ROLLBACK WORK.

      LEAVE TO SCREEN 0.

    ENDIF.

  ELSEIF PR_SEAR = 'X'.

    MODIFY ZEDT10_LFA1 FROM GS_LFA1.

    MODIFY ZEDT10_LFB1 FROM GS_LFB1.

    MODIFY ZEDT10_LFM1 FROM GS_LFM1.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_PARAMETERS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_PARAMETERS .

  IF PR_CREA = 'X'.

    IF P_BUKRS1 IS INITIAL OR P_KTOKK IS  INITIAL.

      MESSAGE E001.

      LEAVE TO SCREEN 0.

    ELSE.

      GV_BUKRS = P_BUKRS1.

      GV_KTOKK = P_KTOKK.

    ENDIF.

    " ###.



  ELSE.

    " ###

    IF P_BUKRS2 IS INITIAL OR P_LIFNR IS INITIAL.

      MESSAGE E001.

      LEAVE TO SCREEN 0.

    ELSE.

      GV_LIFNR = P_LIFNR.

      GV_BUKRS = P_BUKRS2.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form CHECK_REQUIRED_FIELD

*&---------------------------------------------------------------------*

*  ## # ##### ## ## # ##

*----------------------------------------------------------------------*




FORM CHECK_REQUIRED_FIELD.



  " ##(0)## ###

  SY-SUBRC = 0.



  CASE GV_KTOKK. " (#### ####)

    WHEN '3000'.

      " 3000: STCD1 ##

      IF GV_STCD1 IS INITIAL.

        MESSAGE '#####(STCD1)# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

        SY-SUBRC = 4. " ## ##

      ENDIF.



    WHEN '2000'.

      " 2000: STCD1, STCD2 ## ##




*      IF GV_STCD1 IS INITIAL OR GV_STCD2 IS INITIAL.

*        MESSAGE '#### 2000# ####1,2# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

*        SY-SUBRC = 4.

*      ENDIF.






    WHEN OTHERS.

      " ##: STCD2 ##

      IF GV_STCD2 IS INITIAL.

        MESSAGE '######(STCD2)# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

        SY-SUBRC = 4.

      ENDIF.

  ENDCASE.



ENDFORM.