
*&---------------------------------------------------------------------*

*& Report ZMM22_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM22_003.

"0.#######, PO## ### ## ##(## #### ###### ######## ##-(O)

"1.#### ### : ## #### ### ## select

" - ##### ## # #### ### ## #### #### ## ## ### # ### ##(#)

"2.####

"##(L_CHECK)# #### # ### ####(###### ##)

"##### ######(######)# ## ####-(#)

"3.####

"### ### ###, ##### ### #### ## #### ## ##

"#### ####### #######

"## ### ## # ### #####.

"######## ### ##### ### ######?

"####: WE ## ##, WA : ####

include
ZMM22_003_CLS
.

include
ZMM22_003_TOP
.

include
ZMM22_003_SCR
.

include
ZMM22_003_F01
.

include
ZMM22_003_PBO
.

include
ZMM22_003_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN.

  PERFORM VALID_INPUT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  IF GR_RAD = 'X'. "####

    PERFORM GET_PO_DATA.

    CALL SCREEN 100.

  ELSEIF GS_RAD = 'X'."## ##

    PERFORM SELECT_DATA_GS.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####

* T200 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ## #####.