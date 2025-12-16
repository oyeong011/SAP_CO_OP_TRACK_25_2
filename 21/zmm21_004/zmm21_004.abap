
*&---------------------------------------------------------------------*

*& Report ZMM21_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM21_004.



include
ZMM21_004_TOP
.

include
ZMM21_004_SCR
.

include
ZMM21_004_F01
.

include
ZMM21_004_PBO
.

include
ZMM21_004_PAI
.



INITIALIZATION.

PERFORM SET_INIT.



AT SELECTION-SCREEN.

  PERFORM CHECK_EBELN.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.





 START-OF-SELECTION.

  IF P_RAD1 = 'X'.

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ELSE.

    PERFORM GET_SEARCH_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* 100 --> 100

* 200 --> 200





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### #### ####.