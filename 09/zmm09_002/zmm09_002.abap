
*&---------------------------------------------------------------------*

*& Report ZMM09_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM09_002.



include
ZMM09_002_CLS
.

include
ZMM09_002_TOP
.

include
ZMM09_002_SCR
.

include
ZMM09_002_F01
.

include
ZMM09_002_PBO
.

include
ZMM09_002_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM CONTROL_SCREEN.



START-OF-SELECTION.

  PERFORM VALUD_INPUT_ALL.



  IF P_R1 = 'X'. "####

    PERFORM VALID_INPUT USING P_LIFN_C P_BUKR_C.

    CALL SCREEN 100.



  ELSEIF P_R2 = 'X'. "####

    PERFORM GET_DATA USING P_LIFN_S P_BUKR_S P_EBELN.

    PERFORM MODIFY_DATA.

    CALL SCREEN 200.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####

* T100 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### #### ####.