
*&---------------------------------------------------------------------*

*& Report ZMM22_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM22_004.

"1. #### ###

"## #### ## select

"### #### ### ## ### ## #####

"2. ####

"##(L_CHECK)# ##### ### ####(## #### ##)

"## ## # ## ## ### ## ####

"3. ####

"### ### ###, ## ### #### #### ## #### ## ##

"#### ## ##### ### #####

"###### ## # ### #####.

"## ## ### #### ###

include
ZMM22_004_CLS
.

include
ZMM22_004_TOP
.

include
ZMM22_004_SCR
.

include
ZMM22_004_F01
.

include
ZMM22_004_PBO
.

include
ZMM22_004_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN.

  PERFORM VALID_INPUT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  IF P_R1 = 'X'."####

    PERFORM GET_PO_DATA.

  IF GT_ITEM[] IS INITIAL.

       STOP.

    ENDIF.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'."####

  "PERFORM GET_INVOICE_DATA.

  PERFORM SELECT_INVOICE_LIST.

  IF GT_ITEM[] IS INITIAL.

        MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

       STOP.

    ENDIF.

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

*   #### ### #####.