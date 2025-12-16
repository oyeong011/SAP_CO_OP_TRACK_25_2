
*&---------------------------------------------------------------------*

*& Report ZPROJECT19_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZPROJECT19_003.



include
ZPROJECT19_003_TOP
.

include
ZPROJECT19_003_SCR
.

include
ZPROJECT19_003_F01
.

include
ZPROJECT19_003_PBO
.

include
ZPROJECT19_003_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF RB_CR = C_X. "##

    PERFORM GET_DATA2.

    CALL SCREEN 100.

  ELSEIF RB_DSP = C_X. "##

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: 00

*398   & & & &

*

* Message class: Hard coded

*   ## ## ### #######.