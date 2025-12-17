
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  RUN_CREATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RUN_CREATE .



  IF INPUT_BUKRS IS NOT INITIAL AND INPUT_KTOKK IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  RUN_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RUN_DISPLAY .



  IF INPUT_LIFNR IS NOT INITIAL AND INPUT_BUKRS IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DISPLAY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DISPLAY_DATA .






* DATA: BEGIN OF GS_PO_ALV,

*        " ## ##

*        LIFNR LIKE ZEDT16_LFA1-LIFNR,   " #####

*        LOEVM LIKE ZEDT16_LFB1-LOEVM,  " #####

*

*        " ZEDT16_LFA1 : #####

*        NAME1 LIKE ZEDT16_LFA1-NAME1,  " ####

*        LAND1 LIKE ZEDT16_LFA1-LAND1,  " ###

*        KTOKK LIKE ZEDT16_LFA1-KTOKK,  " #####

*        STCD1 LIKE ZEDT16_LFA1-STCD1,  " ####

*        STCD2 LIKE ZEDT16_LFA1-STCD2,  " #####

*        STRAS LIKE ZEDT16_LFA1-STRAS,  " ##

*

*        " ZEDT16_LFB1 : #######

*        BUKRS LIKE ZEDT16_LFB1-BUKRS,  " ####

*        AKONT LIKE ZEDT16_LFB1-AKONT,  " ##

*        ZTERM LIKE ZEDT16_LFB1-ZTERM,  " ####

*

*        " ZEDT16_LFM1 : #######

*        EKORG LIKE ZEDT16_LFM1-EKORG,  " ####

*        EKGRP LIKE ZEDT16_LFM1-EKGRP,  " ####

*        WAERS LIKE ZEDT16_LFM1-WAERS,  " ######

*        MWSKZ LIKE ZEDT16_LFM1-MWSKZ,  " ####

*      END OF GS_PO_ALV.

*DATA: GT_PO_ALV LIKE TABLE OF GS_PO_ALV.






  " 1. #### # ## ### ##

  INPUT_LIFNR = P_LIFNR.

  INPUT_BUKRS = P_BUKRS2.



  " 2. ## ### ## (ZEDT16_LFA1) - #: LIFNR

  SELECT SINGLE NAME1 LAND1 KTOKK STCD1 STCD2 STRAS

    FROM ZEDT16_LFA1

    INTO (INPUT_NAME1, INPUT_LAND1, INPUT_KTOKK, INPUT_STCD1, INPUT_STCD2, INPUT_STRAS)

    WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE '### ###### #### #### #### ####.' TYPE 'E'.

    LEAVE TO SCREEN 1000.

  ENDIF.



  " 3. #### ### ## (ZEDT16_LFB1) - #: LIFNR, BUKRS

  SELECT SINGLE AKONT ZTERM

    FROM ZEDT16_LFB1

    INTO (INPUT_AKONT, INPUT_ZTERM)

    WHERE LIFNR = P_LIFNR

      AND BUKRS = P_BUKRS2.



  IF SY-SUBRC <> 0.

    MESSAGE '### ##### #### #### #### ####.' TYPE 'E'.

    LEAVE TO SCREEN 1000.

  ENDIF.



  " 4. #### ### ## (ZEDT16_LFM1) - #: LIFNR, (EKORG)

  " ##: ##### ####(EKORG)# ####, ## ##### # ## #### ### #####.

  SELECT SINGLE EKORG EKGRP WAERS MWSKZ

    FROM ZEDT16_LFM1

    INTO (INPUT_EKORG, INPUT_EKGRP, INPUT_WAERS, INPUT_MWSKZ)

    WHERE LIFNR = P_LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE '### ###### #### #### #### ####.' TYPE 'E'.

    LEAVE TO SCREEN 1000.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_CREATE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_CREATE_DATA .






* DATA: BEGIN OF GS_PO_ALV,

*        " ## ##

*        LIFNR LIKE ZEDT16_LFA1-LIFNR,   " #####

*        LOEVM LIKE ZEDT16_LFB1-LOEVM,  " #####

*

*        " ZEDT16_LFA1 : #####

*        NAME1 LIKE ZEDT16_LFA1-NAME1,  " ####

*        LAND1 LIKE ZEDT16_LFA1-LAND1,  " ###

*        KTOKK LIKE ZEDT16_LFA1-KTOKK,  " #####

*        STCD1 LIKE ZEDT16_LFA1-STCD1,  " ####

*        STCD2 LIKE ZEDT16_LFA1-STCD2,  " #####

*        STRAS LIKE ZEDT16_LFA1-STRAS,  " ##

*

*        " ZEDT16_LFB1 : #######

*        BUKRS LIKE ZEDT16_LFB1-BUKRS,  " ####

*        AKONT LIKE ZEDT16_LFB1-AKONT,  " ##

*        ZTERM LIKE ZEDT16_LFB1-ZTERM,  " ####

*

*        " ZEDT16_LFM1 : #######

*        EKORG LIKE ZEDT16_LFM1-EKORG,  " ####

*        EKGRP LIKE ZEDT16_LFM1-EKGRP,  " ####

*        WAERS LIKE ZEDT16_LFM1-WAERS,  " ######

*        MWSKZ LIKE ZEDT16_LFM1-MWSKZ,  " ####

*      END OF GS_PO_ALV.

*DATA: GT_PO_ALV LIKE TABLE OF GS_PO_ALV.






  DATA: LV_MAX_LIFNR TYPE ZEDT16_LFA1-LIFNR.



  CLEAR : INPUT_LIFNR, INPUT_NAME1, INPUT_LAND1, INPUT_KTOKK, INPUT_STCD1,

  INPUT_STCD2, INPUT_STRAS, INPUT_BUKRS, INPUT_AKONT, INPUT_ZTERM,

  INPUT_EKORG, INPUT_EKGRP, INPUT_WAERS, INPUT_MWSKZ.



  " -------------------------------------------------------------

  " 1. ## ### ##(LIFNR) ## ##

  " -------------------------------------------------------------



  " ##### ## # LIFNR ## ###

  SELECT SINGLE MAX( LIFNR )

    FROM ZEDT16_LFA1

    INTO LV_MAX_LIFNR.



  " #### ### ### MAX## ##### ### ##

  IF LV_MAX_LIFNR IS INITIAL.

    INPUT_LIFNR = '1000000000'.



  ELSE.

    " #### ### ### + 1 (#### ## ###)

    INPUT_LIFNR = LV_MAX_LIFNR + 1.

  ENDIF.



  " -------------------------------------------------------------

  " 2. ### ### ##

  " -------------------------------------------------------------

  INPUT_BUKRS = P_BUKRS1.

  INPUT_KTOKK = P_KTOKK.



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



  " -------------------------------------------------------

  " 1. ## ### ### (## ### ## ##)

  " -------------------------------------------------------

  CLEAR: GS_LFA1, GS_LFB1, GS_LFM1.





  " -------------------------------------------------------

  " 2. ### ###(INPUT_...)# ## ###(GS_...)# ##

  " -------------------------------------------------------



  " [GS_LFA1 : ## ###]

  GS_LFA1-LIFNR = INPUT_LIFNR.  " ##

  GS_LFA1-NAME1 = INPUT_NAME1.

  GS_LFA1-LAND1 = INPUT_LAND1.

  GS_LFA1-KTOKK = INPUT_KTOKK.

  GS_LFA1-STCD1 = INPUT_STCD1.

  GS_LFA1-STCD2 = INPUT_STCD2.

  GS_LFA1-STRAS = INPUT_STRAS.



  " [GS_LFB1 : #### ###]

  GS_LFB1-LIFNR = INPUT_LIFNR.  " ## (LFA1# ##)

  GS_LFB1-BUKRS = INPUT_BUKRS.  " ##

  GS_LFB1-AKONT = INPUT_AKONT.

  GS_LFB1-ZTERM = INPUT_ZTERM.



  " [GS_LFM1 : #### ###]

  GS_LFM1-LIFNR = INPUT_LIFNR.  " ## (LFA1# ##)

  GS_LFM1-EKORG = INPUT_EKORG.  " ##

  GS_LFM1-EKGRP = INPUT_EKGRP.

  GS_LFM1-WAERS = INPUT_WAERS.

  GS_LFM1-MWSKZ = INPUT_MWSKZ.





  " -------------------------------------------------------

  " 3. ### ## DB ## (INSERT vs UPDATE)

  " -------------------------------------------------------



  " === [## ##] P_CRE ===

  IF P_CRE = 'X'.



    " (1) ## ### ##

    INSERT ZEDT16_LFA1 FROM GS_LFA1.

    IF SY-SUBRC = 0.



      " (2) #### ### ##

      INSERT ZEDT16_LFB1 FROM GS_LFB1.

      IF SY-SUBRC = 0.



        " (3) #### ### ##

        INSERT ZEDT16_LFM1 FROM GS_LFM1.

        IF SY-SUBRC = 0.

          " 3# ### ## ## # -> ##

          COMMIT WORK AND WAIT.

          MESSAGE '##### #######.' TYPE 'S'.

          LEAVE TO SCREEN 0.

        ELSE.

          " LFM1 ## -> ## ##

          ROLLBACK WORK.

          MESSAGE '#### ### ## # ### ######.' TYPE 'E'.

        ENDIF.



      ELSE.

        " LFB1 ## -> ## ##

        ROLLBACK WORK.

        MESSAGE '#### ### ## # ### ######.' TYPE 'E'.

      ENDIF.



    ELSE.

      " LFA1 ## (## # #)

      ROLLBACK WORK.

      MESSAGE '## #### ### #####.' TYPE 'E'.

    ENDIF.





    " === [##/## ##] P_DIS ===

  ELSEIF P_DIS = 'X'.



    " (1) ## ### ##

    UPDATE ZEDT16_LFA1 FROM GS_LFA1.

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '## ### ## ##' TYPE 'E'.

    ENDIF.



    " (2) #### ### ##

    UPDATE ZEDT16_LFB1 FROM GS_LFB1.

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '#### ### ## ##' TYPE 'E'.

    ENDIF.



    " (3) #### ### ##

    UPDATE ZEDT16_LFM1 FROM GS_LFM1.

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '#### ### ## ##' TYPE 'E'.

    ENDIF.



    " ## UPDATE# ## ## ##### ##

    COMMIT WORK AND WAIT.

    MESSAGE '##### #######.' TYPE 'S'.

    LEAVE TO SCREEN 0.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .



  P_BUKRS1 = '1000'.

  P_KTOKK = '1000'.



  P_LIFNR = '1000000001'.

  P_BUKRS2 = '1000'.



ENDFORM.