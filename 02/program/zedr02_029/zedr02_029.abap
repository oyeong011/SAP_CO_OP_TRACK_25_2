
*&---------------------------------------------------------------------*

*& Report ZEDR02_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_029 MESSAGE-ID ZMED02.



"20251030 DOCKING CONTAINER, 20251106 USER COMMAND ##



include
ZEDR02_029_TOP
.

include
ZEDR02_029_SCR
.

include
ZEDR02_029_F01
.

include
ZEDR02_029_PBO
.

include
ZEDR02_029_PAI
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