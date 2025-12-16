
*&---------------------------------------------------------------------*

*& Report ZEDR24_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_PRACTICE009 MESSAGE-ID ZEDM24.



include
ZEDR24_PRACTICE009_TOP
.

include
ZEDR24_PRACTICE009_SCR
.

include
ZEDR24_PRACTICE009_F01
.

include
ZEDR24_PRACTICE009_PBO
.

include
ZEDR24_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.







START-OF-SELECTION.

  IF S_TERM IS INITIAL.

    MESSAGE E000.

  ENDIF.



  "## ### #### ## # ## # ## ##

  IF S_ZPERNR IS INITIAL AND S_ZDCODE IS INITIAL.

    MESSAGE E000.

  ENDIF.



  PERFORM GET_DATA1. "####, ###### #######



  PERFORM MODIFY_DATA1. "####, #### ## ####

  PERFORM MODIFY_DATA2. "## ## ####

  PERFORM MODIFY_DATA3. "#### ####



  CALL SCREEN 100.