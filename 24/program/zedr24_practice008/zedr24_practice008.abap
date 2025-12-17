
*&---------------------------------------------------------------------*

*& Report ZEDR24_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_PRACTICE008 MESSAGE-ID ZEDM24.



include
ZEDR24_PRACTICE008_TOP
.

include
ZEDR24_PRACTICE008_SCR
.

include
ZEDR24_PRACTICE008_F01
.

include
ZEDR24_PRACTICE008_PBO
.

include
ZEDR24_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



"3. ####

AT SELECTION-SCREEN OUTPUT.

  "3-1. #### ### #### ##

  IF P_R1 = 'X'.

    LOOP AT SCREEN.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  "3-2. #### ### #### ##

  ELSE.

    LOOP AT SCREEN.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  ENDIF.



  IF P_R1 = 'X' AND S_ZORDNO IS INITIAL AND S_ZJDATE IS INITIAL.

    MESSAGE E000.

  ELSEIF P_R2 = 'X' AND S_ZORDNO IS INITIAL AND S_ZDDATE IS INITIAL.

    MESSAGE E000.

  ENDIF.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  IF P_R1 = 'X'.

    IF GT_T100_RESULT IS INITIAL.

      MESSAGE E001.

    ENDIF.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.




*    IF GT_T101_RESULT IS INITIAL.

*      MESSAGE E001.

*    ENDIF.

*    CALL SCREEN 200.




  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* ZTITLE1 --> ######

* ZTITLE2 --> ######

* T100 --> ######

* T200 --> ######

* ZTITLE1 --> ######

* ZTITLE2 --> ######