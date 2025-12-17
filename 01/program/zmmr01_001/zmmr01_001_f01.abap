
*&---------------------------------------------------------------------*

*&  INCLUDE           ZMMR01_003_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      FORM  SELECTION_SCREEN_OUTPUT

*&---------------------------------------------------------------------*




FORM SELECTION_SCREEN_OUTPUT .

  LOOP AT SCREEN.



    IF SCREEN-GROUP1 = 'M1'.  "#####

      IF P_R1 = 'X'.          "##

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'.      "##

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.



    IF SCREEN-GROUP1 = 'M2'.  "#####

      IF P_R1 = 'X'.          "##

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.      "##

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  INITIALIZATION

*&---------------------------------------------------------------------*




FORM INITIALIZATION .



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_MANDATORY.

*&---------------------------------------------------------------------*




FORM CHECK_MANDATORY.

  IF P_R1 = 'X'.



     IF P_BUKRS IS INITIAL.

       MESSAGE S008 WITH TEXT-M01 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_KTOKK IS INITIAL.

       MESSAGE S008 WITH TEXT-M02 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



   ELSEIF P_R2 = 'X'.



     IF P_BUKRS IS INITIAL.

       MESSAGE S008 WITH TEXT-M01 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_LIFNR IS INITIAL.

       MESSAGE S008 WITH TEXT-M03 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



   ELSE.

     MESSAGE S008.

     LEAVE LIST-PROCESSING.

   ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_SELECTION_DATA

*&---------------------------------------------------------------------*




FORM CHECK_SELECTION_DATA .

  IF P_R1 = 'X'.

    GV_MODE = 'CREATE'.

  ELSEIF P_R2 = 'X'.

    GV_MODE = 'DISPLAY'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CALL_SCREEN

*&---------------------------------------------------------------------*




FORM CALL_SCREEN .

  CASE GV_MODE.

    WHEN 'CREATE'.

      CALL SCREEN 100.

    WHEN 'DISPLAY'.

      PERFORM GET_DATA.

      PERFORM MODIFY_DATA.

      CALL SCREEN 100.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  IF GV_MODE = 'CREATE'.

    PERFORM GET_NEW_LIFNR CHANGING GS_DISP_100-LIFNR.

    GS_DISP_100-LIFNR = GS_DISP_100-LIFNR.

    MOVE-CORRESPONDING GS_DISP_100 TO GS_LFA1.

    MOVE-CORRESPONDING GS_DISP_100 TO GS_LFB1.

    MOVE-CORRESPONDING GS_DISP_100 TO GS_LFM1.



    INSERT ZLFA1_01 FROM GS_LFA1.

    INSERT ZLFB1_01 FROM GS_LFB1.

    INSERT ZLFM1_01 FROM GS_LFM1.



    MESSAGE |##### { GS_DISP_100-LIFNR } # #######| TYPE 'S'.

    LEAVE TO SCREEN 0.



  ELSEIF GV_MODE = 'DISPLAY'.

    PERFORM MESSAGE_SAVE.

    SELECT SINGLE *

      INTO GS_LFA1

      FROM ZLFA1_01

      WHERE LIFNR = GS_DISP_100-LIFNR.



    GS_DISP_100-STCD2 = GS_DISP_100-STCD2.



    MODIFY ZLFA1_01 FROM GS_LFA1.

    MESSAGE '#######.' TYPE 'S'.

    LEAVE TO SCREEN 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_MANDATORY_PURCHASE

*&---------------------------------------------------------------------*




FORM CHECK_MANDATORY_PURCHASE .



  "####

  IF GS_DISP_100-NAME1 IS INITIAL.

    MESSAGE '##### ## #####.'  TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "####

  IF GS_DISP_100-KTOKK IS INITIAL.

    MESSAGE '##### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "##

  IF GS_DISP_100-STRAS IS INITIAL.

    MESSAGE '### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "##

  IF GS_DISP_100-LAND1 IS INITIAL.

    MESSAGE '### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "####

  IF GS_DISP_100-BUKRS IS INITIAL.

    MESSAGE '##### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "####(AKONT)

  IF GS_DISP_100-AKONT IS INITIAL.

    MESSAGE '####(AKONT)# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "####(ZTERM)

  IF GS_DISP_100-ZTERM IS INITIAL.

    MESSAGE '####(ZTERM)# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "####

  IF GS_DISP_100-EKORG IS INITIAL.

    MESSAGE '####(EKORG)# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "####

  IF GS_DISP_100-EKGRP IS INITIAL.

    MESSAGE '####(EKGRP)# ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE SCREEN.

  ENDIF.



  "##

  IF GS_DISP_100-WAERS IS INITIAL.

    MESSAGE '######(WAERS)# ## #####.' TYPE 'S'.

    LEAVE SCREEN.

  ENDIF.



  "#### (## GS_LFM1-MWSKZ# ### ##)

  IF GS_DISP_100-MWSKZ IS INITIAL.

    MESSAGE '####(MWSKZ)# ## #####.' TYPE 'S'.

    LEAVE SCREEN.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_NEW_LIFNR

*&---------------------------------------------------------------------*




FORM GET_NEW_LIFNR  CHANGING  P_LIFNR.

  DATA lv_new TYPE n LENGTH 10.



  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'

      OBJECT      = 'ZVENDOR_NR'

    IMPORTING

      NUMBER      = lv_new

    EXCEPTIONS

      OTHERS      = 8.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ## ##' TYPE 'E'.

  ENDIF.



  P_LIFNR = lv_new.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*




FORM INIT_DATA .

  GS_DISP_100-BUKRS = P_BUKRS.

  GS_DISP_100-KTOKK = P_KTOKK.



  "------------------------------

  " # #### ## ### ##

  "------------------------------

    "##### (LFA1)

    GS_DISP_100-NAME1 = '### ###'.

    GS_DISP_100-KTOKK = P_KTOKK.      "####

    GS_DISP_100-LAND1 = 'KR'.        "##

    GS_DISP_100-STRAS = '##### 00# 123'.

    GS_DISP_100-ORT01 = '##'.

    GS_DISP_100-PSTLZ = '12345'.

    GS_DISP_100-STCD1 = '1234567890123'. "####

    GS_DISP_100-STCD2 = '123-45-67890'.  "#####



    "#### ### (LFB1)

    GS_DISP_100-BUKRS = P_BUKRS.      "#### ## ####

    GS_DISP_100-AKONT = '2100001010'. "#### ####

    GS_DISP_100-ZTERM = 'M005'.       "####



    "#### ### (LFM1)

    GS_DISP_100-EKORG = '1000'.       "####

    GS_DISP_100-EKGRP = '101'.        "####

    GS_DISP_100-WAERS = 'KRW'.        "##

    GS_DISP_100-MWSKZ = 'V3'.         "####



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  CLEAR : GS_LFA1 , GS_LFB1 , GS_LFM1.



  SELECT SINGLE *

    FROM ZLFA1_01

    INTO CORRESPONDING FIELDS OF GS_LFA1

    WHERE LIFNR = P_LIFNR.



  SELECT SINGLE *

    FROM ZLFB1_01

    INTO CORRESPONDING FIELDS OF GS_LFB1

    WHERE LIFNR = P_LIFNR

    AND   BUKRS = P_BUKRS.



  SELECT SINGLE *

    FROM ZLFM1_01

    INTO CORRESPONDING FIELDS OF GS_LFM1

    WHERE LIFNR = P_LIFNR.





  IF GS_LFA1 IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  IF GS_LFB1 IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  IF GS_LFM1 IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  MOVE-CORRESPONDING GS_LFA1 TO GS_DISP_100.

  MOVE-CORRESPONDING GS_LFB1 TO GS_DISP_100.

  MOVE-CORRESPONDING GS_LFM1 TO GS_DISP_100.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MESSAGE_SAVE

*&---------------------------------------------------------------------*




FORM MESSAGE_SAVE .

  DATA LV_ANSWER TYPE C.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '##'

      TEXT_QUESTION         = '########?'

      TEXT_BUTTON_1         = 'YES'

      TEXT_BUTTON_2         = 'NO'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER = '1'.

    " YES ### #



  ELSEIF LV_ANSWER = '2'.

    " NO ### #

    MESSAGE '#######.' TYPE 'S'.

    LEAVE SCREEN.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  PERFORM GET_BUKRS_TX USING GS_DISP_100-BUKRS CHANGING GS_DISP_100-BUKRS_TX.

  PERFORM GET_KTOKK_TX USING GS_DISP_100-KTOKK CHANGING GS_DISP_100-KTOKK_TX.

  PERFORM GET_ZTERM_TX USING GS_DISP_100-ZTERM CHANGING GS_DISP_100-ZTERM_TX.

  PERFORM GET_AKONT_TX USING GS_DISP_100-AKONT CHANGING GS_DISP_100-AKONT_TX.

  PERFORM GET_EKORG_TX USING GS_DISP_100-EKORG CHANGING GS_DISP_100-EKORG_TX.

  PERFORM GET_EKGRP_TX USING GS_DISP_100-EKGRP CHANGING GS_DISP_100-EKGRP_TX.

  PERFORM GET_MWSKZ_TX USING GS_DISP_100-MWSKZ CHANGING GS_DISP_100-MWSKZ_TX.

  PERFORM GET_BANKL_TX USING GS_DISP_100-BANKL CHANGING GS_DISP_100-BANKL_TX.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BUKRS_TX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_BUKRS_TX  USING    P_BUKRS

                   CHANGING P_BUKRS_TX.

  SELECT SINGLE TEXT

    FROM ZTBUKRS01

    INTO P_BUKRS_TX

    WHERE BUKRS = P_BUKRS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_KTOKK_TX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_KTOKK_TX  USING    P_KTOKK

                   CHANGING P_KTOKK_TX.

  SELECT SINGLE TEXT

    FROM ZTKTOKK01

    INTO P_KTOKK_TX

    WHERE KTOKK = P_KTOKK.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZTERM_TX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_ZTERM_TX  USING    P_ZTERM

                   CHANGING P_ZTERM_TX.

  SELECT SINGLE TEXT

    FROM ZTERM01_01

    INTO P_ZTERM_TX

    WHERE ZTERM = P_ZTERM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_AKONT_TX

*&---------------------------------------------------------------------*




FORM GET_AKONT_TX  USING    P_AKONT

                   CHANGING P_AKONT_TX.

  SELECT SINGLE TEXT

    FROM ZSKA1_01

    INTO P_AKONT_TX

    WHERE SAKNR = P_AKONT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EKORG_TX

*&---------------------------------------------------------------------*




FORM GET_EKORG_TX  USING    P_EKORG

                   CHANGING P_EKORG_TX.

  SELECT SINGLE TEXT

    FROM ZTEKORG01

    INTO P_EKORG_TX

    WHERE EKORG = P_EKORG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EKGRP_TX

*&---------------------------------------------------------------------*




FORM GET_EKGRP_TX  USING    P_EKGRP

                   CHANGING P_EKGRP_TX.

  SELECT SINGLE TEXT

    FROM ZTEKGRP01

    INTO P_EKGRP_TX

    WHERE EKGRP = P_EKGRP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MWSKZ_TX

*&---------------------------------------------------------------------*




FORM GET_MWSKZ_TX  USING    P_MWSKZ

                   CHANGING P_MWSKZ_TX.

  SELECT SINGLE TEXT

    FROM ZTAXCODE01

    INTO P_MWSKZ_TX

    WHERE MWSKZ = P_MWSKZ.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BANKL_TX

*&---------------------------------------------------------------------*




FORM GET_BANKL_TX  USING    P_BANKL

                   CHANGING P_BANKL_TX.

  SELECT SINGLE TEXT

    FROM ZTBANKCODE01

    INTO P_BANKL_TX

    WHERE BANKL = P_BANKL.



ENDFORM.