
*&---------------------------------------------------------------------*

*& Report ZEDR02_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_031 MESSAGE-ID ZMED02.



"20251106 CLASS EVENT, 20251107 EVENT HOTSPOT/EVENT DOUBLECLICK ##



include
ZEDR02_031_CLS
.

include
ZEDR02_031_TOP
.

include
ZEDR02_031_SCR
.

include
ZEDR02_031_F01
.

include
ZEDR02_031_PBO
.

include
ZEDR02_031_PAI
.



INITIALIZATION.

  PERFORM SET_INIT. "####



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########