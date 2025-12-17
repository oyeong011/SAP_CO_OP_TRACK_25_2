
*&---------------------------------------------------------------------*

*& Report ZEDR03_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_PRACTICE008 MESSAGE-ID ZME03.



include
ZEDR03_PRACTICE8_TOP
.

include
ZEDR03_PRACTICE8_SCR
.

include
ZEDR03_PRACTICE8_F01
.

include
ZEDR03_PRACTICE8_PBO
.

include
ZEDR03_PRACTICE8_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_ORDER = C_X.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

     IF SCREEN-GROUP1 = 'M2'.

      IF P_DEV = C_X.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



START-OF-SELECTION.

  "### #### ## ##

  IF ( S_ZORDO IS INITIAL ) AND ( S_ZDDATE IS INITIAL ).

      MESSAGE E000.

      EXIT.

  ENDIF.



END-OF-SELECTION.

  IF P_ORDER = C_X.

      CALL SCREEN 100.

  ELSEIF P_DEV = C_X.

      CALL SCREEN 200.

  ELSE.

    MESSAGE E000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> #### ##

* T100 --> ######