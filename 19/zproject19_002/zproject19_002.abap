
*&---------------------------------------------------------------------*

*& Report ZPROJECT19_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZPROJECT19_002.



include
ZPROJECT19_002_CLS
.

include
ZPROJECT19_002_TOP
.

include
ZPROJECT19_002_SCR
.

include
ZPROJECT19_002_F01
.

include
ZPROJECT19_002_PBO
.

include
ZPROJECT19_002_PAI
.





AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  IF RB_CR = C_X.

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ELSEIF RB_DSP = C_X.

    PERFORM GET_DATA2.

    CALL SCREEN 100.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ### ### #### ####.