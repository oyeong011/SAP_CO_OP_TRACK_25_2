
*&---------------------------------------------------------------------*

*& Report ZMM05_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM05_004 MESSAGE-ID ZMED05.





include
ZMM05_004_CLS
.

include
ZMM05_004_TOP
.

include
ZMM05_004_SCR
.

include
ZMM05_004_F01
.

include
ZMM05_004_PBO
.

include
ZMM05_004_PAI
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

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'."####

  PERFORM GET_INVOICE_DATA.

  CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> T100

* T200 --> T200





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## #### #####.