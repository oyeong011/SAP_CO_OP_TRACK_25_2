
*&---------------------------------------------------------------------*

*& Report ZMMR01_030

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR01_030 MESSAGE-ID ZMM01.



include
ZMMR01_030_CLS
.

include
ZMMR01_030_TOP
.

include
ZMMR01_030_SCR
.

include
ZMMR01_030_F01
.

include
ZMMR01_030_PBO
.

include
ZMMR01_030_PAI
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

 PERFORM CHECK_INVOCE_DATA.

 PERFORM GET_DATA.

 PERFORM CALL_SCREEN.






*GUI Texts

*----------------------------------------------------------

* DISP --> ## ## # ##

* T0100 --> ####

* T0300 --> ## ## # ##

* T0400 --> ## #####

* T0500 --> ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### #### ###### ####.