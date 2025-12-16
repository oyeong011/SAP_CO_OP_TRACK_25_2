
*&---------------------------------------------------------------------*

*& Report ZEDR15_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_PRACTICE009 MESSAGE-ID ZMED15.



include
ZEDR15_PRACTICE009_TOP
.

include
ZEDR15_PRACTICE009_SCR
.

include
ZEDR15_PRACTICE009_F01
.

include
ZEDR15_PRACTICE009_PBO
.

include
ZEDR15_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM DATE_INIT. "#### ##



AT SELECTION-SCREEN.




*#### ### #####




  "#### ## / #### ## #### # # ### ##

  IF S_DATE IS INITIAL.

    MESSAGE E001.

    STOP.

  ENDIF.



  IF S_ZPERNR IS INITIAL AND S_ZDEP IS INITIAL.

    MESSAGE E001.

    STOP.

  ENDIF.



START-OF-SELECTION.

  PERFORM RANGE_CONTROL.

  PERFORM SELECT_DATA.

  PERFORM MODIF_DATA.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######

* T100 --> #######