
*&---------------------------------------------------------------------*

*&  Include           ZMMR25_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  READ_OK_CODE  INPUT

*&---------------------------------------------------------------------*




MODULE READ_OK_CODE INPUT.

  " # ### ### - USER_COMMAND_0100## ##

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  " OK_CODE ## (####!)

  OK_CODE = SY-UCOMM.



  IF P_CRE = C_X

     AND OK_CODE = 'ADD'

     AND GV_NAME1 IS INITIAL

     AND GV_LAND1 IS INITIAL

     AND GV_STRAS IS INITIAL

     AND GV_STCD1 IS INITIAL

     AND GV_STCD2 IS INITIAL

     AND GV_AKONT IS INITIAL

     AND GV_ZTERM IS INITIAL

     AND GV_EKORG IS INITIAL

     AND GV_EKGRP IS INITIAL

     AND GV_WAERS IS INITIAL

     AND GV_MWSKZ IS INITIAL

     AND GT_ALV IS NOT INITIAL.

    OK_CODE = 'STOR'.

  ENDIF.



  " ## #### OK_CODE# ##### (## ##) STOR# ##

  IF P_VIEW = C_X AND OK_CODE IS INITIAL.

    OK_CODE = 'STOR'.

  ENDIF.



  CASE OK_CODE.

    WHEN 'ADD'.

      IF P_CRE = C_X.

        PERFORM ADD_ROW_TO_ALV.

      ENDIF.



    WHEN 'STOR' OR 'SAVE' OR 'STORE' OR 'SICH'.

      IF GO_ALV IS NOT INITIAL.

        CALL METHOD GO_ALV->CHECK_CHANGED_DATA.

      ENDIF.



      IF P_CRE = C_X.

        IF GT_ALV IS INITIAL.

          MESSAGE '### #### ####. [##] #### ## ## ###.' TYPE 'E'.

          EXIT.

        ENDIF.

        PERFORM SAVE_ALL_DATA.

      ELSE.

        PERFORM UPDATE_SINGLE_DATA.

      ENDIF.



    WHEN 'BACK' OR 'CANC'.

      CLEAR GT_ALV.

      LEAVE TO SCREEN 0.



    WHEN 'EXIT'.

      CLEAR GT_ALV.

      LEAVE PROGRAM.



    WHEN OTHERS.

  ENDCASE.



  CLEAR OK_CODE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Form  UPDATE_SINGLE_DATA

*&---------------------------------------------------------------------*

*       ## ## ## - STCD2(#####)# ##

*----------------------------------------------------------------------*




FORM UPDATE_SINGLE_DATA.

  DATA: LV_LIFNR_CHK TYPE ZEDT25_LFA1-LIFNR.



  " ##### ## ##

  IF GV_STCD2 IS INITIAL.

    MESSAGE '###### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " ### ## ## ##

  SELECT SINGLE LIFNR

    INTO LV_LIFNR_CHK

    FROM ZEDT25_LFA1

    WHERE LIFNR = GV_LIFNR.



  IF SY-SUBRC = 0.

    " ### ## - STCD2# UPDATE

    UPDATE ZEDT25_LFA1

      SET STCD2 = GV_STCD2

      WHERE LIFNR = GV_LIFNR.



    IF SY-SUBRC = 0.

      COMMIT WORK.

      MESSAGE '###### #######.' TYPE 'S'.

    ELSE.

      ROLLBACK WORK.

      MESSAGE '## ##.' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.



  ELSE.

    " ### ## - ## ###

    MESSAGE '### #### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.