
*&---------------------------------------------------------------------*

*& Report ZMMR01_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR01_010 MESSAGE-ID ZMM01.

include
ZMMR01_010_CLS
.

include
ZMMR01_010_TOP
.

include
ZMMR01_010_SCR
.

include
ZMMR01_010_F01
.

include
ZMMR01_010_PBO
.

include
ZMMR01_010_PAI
.



"=============================================================="

" INITIALIZATION"

"=============================================================="

INITIALIZATION.

  PERFORM INITIALIZATION.

"=============================================================="

" AT SELECTION-SCREEN OUTPUT"

"=============================================================="

AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.



"=============================================================="

" AT SELECTION-SCREEN"

" (### ##, ### ##, ### ## ## #)"

"=============================================================="

AT SELECTION-SCREEN.

"=============================================================="

" START-OF-SELECTION (## ## ##)"

"=============================================================="

START-OF-SELECTION.

 PERFORM CHECK_MANDATORY.

 PERFORM CHECK_SELECTION_DATA.

 PERFORM CHECK_VENDER_DATA.

 PERFORM SET_MODE_DATA.

 PERFORM CALL_SCREEN.






*GUI Texts

*----------------------------------------------------------

* T001 --> #### ## # ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####