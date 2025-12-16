
*&---------------------------------------------------------------------*

*& Report ZWORK20_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK20_001.



include
ZWORK20_001_CLS
.

include
ZWORK20_001_TOP
.

include
ZWORK20_001_SCR
.

include
ZWORK20_001_F01
.

include
ZWORK20_001_PBO
.

include
ZWORK20_001_PAI
.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FNAME.

  PERFORM PRESS_F4.



AT SELECTION-SCREEN.

  PERFORM PRESS_FUNCTION_KEY.

  PERFORM CHECK_INPUT.



INITIALIZATION.

  PERFORM SET_DEFAULT.

  SELECTION-SCREEN FUNCTION KEY 1.

  GS_EXCEL-ICON_ID = ICON_EXPORT.

  GS_EXCEL-ICON_TEXT = '### ####'.

  GS_EXCEL-QUICKINFO = '### ####'.

  SSCRFIELDS-FUNCTXT_01 = GS_EXCEL.



START-OF-SELECTION.

  PERFORM GET_EXCEL_DATA.

  PERFORM MODIFY_EXCEL_DATA.



CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ##

* T100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####