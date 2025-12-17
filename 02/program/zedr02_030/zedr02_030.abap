
*&---------------------------------------------------------------------*

*& Report ZEDR02_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_030 MESSAGE-ID ZMED02.



"20251030 SPLITTER CONTAINER ##



include
ZEDR02_030_TOP
.

include
ZEDR02_030_SCR
.

include
ZEDR02_030_F01
.

include
ZEDR02_030_PBO
.

include
ZEDR02_030_PAI
.



INITIALIZATION.

  PERFORM SET_INIT. "####



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####