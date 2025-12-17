
* ---------------------------------------------------------------------*

*& Report ZMM09_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM09_004.



include
ZMM09_004_CLS
.

include
ZMM09_004_TOP
.

include
ZMM09_004_SCR
.

include
ZMM09_004_F01
.

include
ZMM09_004_PBO
.

include
ZMM09_004_PAI
.





INITIALIZATION.

  PERFORM SET_SCREEN.





AT SELECTION-SCREEN OUTPUT.

  PERFORM CONTROL_SCREEN.



START-OF-SELECTION.

  PERFORM VALID_INPUT_ALL.

  PERFORM VALID_INPUT.



  IF P_R1 = 'X'.

    PERFORM GET_DATA.

    CALL SCREEN 100.



  ELSEIF P_R2 = 'X'.

    PERFORM GET_DATA_200.

    PERFORM MODIFY_DATA_200.

    CALL SCREEN 200.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####

* T200 --> ####

* T100 --> ####

* T200 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####, ###, ###### ########