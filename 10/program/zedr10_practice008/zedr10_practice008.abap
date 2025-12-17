
*&---------------------------------------------------------------------*

*& Report ZEDR10_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_PRACTICE008 MESSAGE-ID ZME10.



include
ZEDR10_PRACTICE008_TOP
.

include
ZEDR10_PRACTICE008_SCR
.

include
ZEDR10_PRACTICE008_F01
.

include
ZEDR10_PRACTICE008_O01
.

include
ZEDR10_PRACTICE008_O02
.

include
ZEDR10_PRACTICE008_I01
.

include
ZEDR10_PRACTICE008_I02
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'MJ'.

      IF P_R_DE_F = 'X'.

        SCREEN-ACTIVE = 0.

      ELSE.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'MD'.

      IF P_R_OR_F = 'X'.

        SCREEN-ACTIVE = 0.

      ELSE.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.




*  IF S_ZID IS INITIAL.

*    MESSAGE I000.

*    EXIT.

*  ENDIF.




  PERFORM GET_DATA.

  PERFORM MODIF_DATA.



END-OF-SELECTION.

  IF P_R_OR_F = 'X'.

    CALL SCREEN 100.

  ELSEIF P_R_DE_F = 'X'.

    CALL SCREEN 200.

  ELSE.

    MESSAGE I100.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0100 --> ######

* T200 --> ######

* T0100 --> ######

* T200 --> ######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ALV Display Error: SY-SUBRC =