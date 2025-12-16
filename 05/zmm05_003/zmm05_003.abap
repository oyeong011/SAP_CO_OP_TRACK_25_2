
*&---------------------------------------------------------------------*

*& Report ZMM05_003

*&---------------------------------------------------------------------*




REPORT ZMM05_003 MESSAGE-ID ZMED05.



include
ZMM05_003_CLS
.

include
ZMM05_003_TOP
.

include
ZMM05_003_SCR
.

include
ZMM05_003_F01
.

include
ZMM05_003_F02
.

include
ZMM05_003_PBO
.

include
ZMM05_003_PAI
.

INITIALIZATION.

  PERFORM SCREEN_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_MODIFY.



START-OF-SELECTION.



  IF RB_CR = 'X'.

    PERFORM VALID_PO_INPUT.

    PERFORM GET_PO_ITEMS.

    PERFORM MODIFY_PO_ITEMS.

    PERFORM FILL_HEADER. "

    CALL SCREEN 100.



  ELSE.



    PERFORM VALID_GR_INPUT.

     PERFORM GET_GR_DATA.

     PERFORM MODIFY_GR_DATA.

     CALL SCREEN 200.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* 0100 --> 0100

* T100 --> T100

* T200 --> T200





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ######