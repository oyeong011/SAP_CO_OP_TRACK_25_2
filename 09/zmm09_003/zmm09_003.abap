
*&---------------------------------------------------------------------*

*& Report ZMM09_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM09_003.



include
ZMM09_003_CLS
.

include
ZMM09_003_TOP
.

include
ZMM09_003_SCR
.

include
ZMM09_003_F01
.

include
ZMM09_003_PBO
.

include
ZMM09_003_PAI
.





INITIALIZATION.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN OUTPUT.

  PERFORM CONTROL_SCREEN.



START-OF-SELECTION.

  PERFORM VALID_INPUT_ALL.



  IF P_R1 = 'X'.

    PERFORM VALID_INPUT.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_DATA.

    PERFORM MODIFY_DATA.

  " PERFORM DISPLAY_GR_SELECT_GUIDE.

    CALL SCREEN 200.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0400 --> ####

* T100 --> ####

* T200 --> ####

* T300 --> #### ###





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ##### #### ## ##### #### ####.