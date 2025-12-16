
*&---------------------------------------------------------------------*

*& Report ZWORK05_001

*&---------------------------------------------------------------------*

*& ## ## ####

*&---------------------------------------------------------------------*




REPORT ZWORK05_001 MESSAGE-ID ZME05.



" Include ##

include
ZWORK05_001_CLS
. " ### ##

include
ZWORK05_001_TOP
. " ## ### ##

include
ZWORK05_001_SCR
. " ## ## ##

include
ZWORK05_001_F01
. " Subroutine ##

include
ZWORK05_001_PBO
. " PBO ##

include
ZWORK05_001_PAI
. " PAI ##



INITIALIZATION.

  " ## ### ##

  SELECTION-SCREEN FUNCTION KEY 1.



  " ## ### # ### ##

  GS_EXCEL-ICON_ID   = ICON_EXPORT.       " ### ##

  GS_EXCEL-ICON_TEXT = '### ####'. " ## ###

  GS_EXCEL-QUICKINFO = '### ####'. " ## ##

  SSCRFIELDS-FUNCTXT_01 = GS_EXCEL.       " 1# ### ##



AT SELECTION-SCREEN OUTPUT.

  " ## ## ## ##

  PERFORM SELECTION_SCREEN.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FNAME.

  " ## ## ## ##

  PERFORM HELP_FUNC.



START-OF-SELECTION.

  PERFORM CHECK_P.           " ### ### ##

  PERFORM GET_EXCEL_DATA.    " ## ## ###

  PERFORM MODIFY_EXCEL_DATA. " ### ## # ### ##



  " ## ## ##

  CALL SCREEN 100.



END-OF-SELECTION.






*GUI Texts

*----------------------------------------------------------

* 0100 --> 0100

* 0100 --> 0100





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### ## ##