
*&---------------------------------------------------------------------*

*& Report ZPROJECT19_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZPROJECT19_001 MESSAGE-ID ZMED19.



include
ZPROJECT19_001_CLS
.

include
ZPROJECT19_001_TOP
.

include
ZPROJECT19_001_SCR
.

include
ZPROJECT19_001_F01
.

include
ZPROJECT19_001_PBO
.

include
ZPROJECT19_001_PAI
.





AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  IF p_rad1 = C_X. "##

    PERFORM GET_DATA2.

    CALL SCREEN 100.

  ELSEIF p_rad2 = C_X. "##

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ## ##