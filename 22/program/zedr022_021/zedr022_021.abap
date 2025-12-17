
*&---------------------------------------------------------------------*

*& Report ZEDR022_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_021.



include
ZEDR022_021_TOP
.

include
ZEDR022_021_SCR
.

include
ZEDR022_021_F01
.

include
ZEDR022_021_PBO
.

include
ZEDR022_021_PAI
.



INITIALIZATION.

PERFORM SET_INIT. "## ##



START-OF-SELECTION.

  PERFORM GET_DATA.








*  IF GT_STUDENT[] IS NOT INITIAL.




    CALL SCREEN 100. "CUSTOM CONTROL# #### ## # ##, call SCREEN ##




*  ELSE.

*    "MESSAGE I000.

*    EXIT.

*  ENDIF.



*GUI Texts

*----------------------------------------------------------

* T100 --> #####