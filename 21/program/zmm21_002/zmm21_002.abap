
*&---------------------------------------------------------------------*

*& Report ZMM21_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM21_002 MESSAGE-ID ZMED21.



include
ZMM21_002_CLS
.

include
ZMM21_002_TOP
.

include
ZMM21_002_SCR
.

include
ZMM21_002_F01
.

include
ZMM21_002_PBO
.

include
ZMM21_002_PAI
.





AT SELECTION-SCREEN.

    IF P_RAD1 = 'X'.

      PERFORM VERIFY_INPUT.

    ELSEIF P_RAD2 = 'X'.

      PERFORM VERIFY_SEARCH.

      ENDIF.



AT SELECTION-SCREEN OUTPUT.

     PERFORM SET_SCREEN.



   START-OF-SELECTION.

     IF P_RAD1 = 'X'.

       CALL SCREEN 100.

     ELSE.

       PERFORM GET_DATA.

       CALL SCREEN 200.

     ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ## #####.