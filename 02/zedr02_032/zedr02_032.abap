
*&---------------------------------------------------------------------*

*& Report ZEDR02_032

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_032 MESSAGE-ID ZMED02.



"20251107 DATA CHANGED/DATA CHANGED FINISHED ##



include
ZEDR02_032_CLS
.

include
ZEDR02_032_TOP
.

include
ZEDR02_032_SCR
.

include
ZEDR02_032_F01
.

include
ZEDR02_032_PBO
.

include
ZEDR02_032_PAI
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

*   ####