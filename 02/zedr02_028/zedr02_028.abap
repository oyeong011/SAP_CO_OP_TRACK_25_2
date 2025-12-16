
*&---------------------------------------------------------------------*

*& Report ZEDR02_028

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_028 MESSAGE-ID ZMED02.



"20251028 MODULE_POOL, 20251029 CUSTOM CONTAINER ##



include
ZEDR02_028_TOP
. "## ##

include
ZEDR02_028_SCR
. "### ##

include
ZEDR02_028_F01
. "FORM ##

include
ZEDR02_028_PBO
.

include
ZEDR02_028_PAI
.



INITIALIZATION.

  PERFORM SET_INIT. "####



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

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