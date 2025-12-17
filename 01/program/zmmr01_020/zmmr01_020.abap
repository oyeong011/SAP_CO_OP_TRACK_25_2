
*&---------------------------------------------------------------------*

*& Report ZMMR01_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR01_020 MESSAGE-ID ZMM01.



include
ZMMR01_020_CLS
.

include
ZMMR01_020_TOP
.

include
ZMMR01_020_SCR
.

include
ZMMR01_020_F01
.

include
ZMMR01_020_PBO
.

include
ZMMR01_020_PAI
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

 PERFORM CHECK_PURCHASE_ORDER_DATA.

 PERFORM GET_DATA.

 PERFORM GET_HEADER_DATA.

 PERFORM MODIFY_DATA.

 PERFORM CALL_SCREEN.






*GUI Texts

*----------------------------------------------------------

* T001 --> #### ## # ##

* T002 --> ####

* T0500 --> ## ##

* T100 --> ## ## # ##

* T200 --> ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ### #### ## ##### #### ####.