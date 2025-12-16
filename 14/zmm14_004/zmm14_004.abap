
*&---------------------------------------------------------------------*

*& Report ZMM14_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM14_004.



include
ZMM14_004_CLS
.

include
ZMM14_004_TOP
.

include
ZMM14_004_SCR
.

include
ZMM14_004_F01
.

include
ZMM14_004_F02
.

include
ZMM14_004_PBO
.

include
ZMM14_004_PAI
.





AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_OUTPUT.



START-OF-SELECTION.

  IF P_R1 = 'X'.

    PERFORM GET_HEADER_DATA.

    PERFORM GET_ITEM_DATA.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_HEADER_DATA_200.

    PERFORM GET_ITEM_DATA_200.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ##

* T200 --> ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### PO #### ####.