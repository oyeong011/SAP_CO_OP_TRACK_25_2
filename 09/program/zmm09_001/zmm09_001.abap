
*&---------------------------------------------------------------------*

*& Report ZMM09_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM09_001.



include
ZMM09_001_CLS
.

include
ZMM09_001_TOP
.

include
ZMM09_001_SCR
.

include
ZMM09_001_F01
.

include
ZMM09_001_PBO
.

include
ZMM09_001_PAI
.



INITIALIZATION.



"## ## ##

AT SELECTION-SCREEN OUTPUT.

  PERFORM CONTROL_SCREEN.



"######

START-OF-SELECTION.

  PERFORM VALID_INPUT.



  IF P_R1 = 'X'.  "## ##

    PERFORM INIT_DATA.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'. "## ##

    PERFORM GET_DATA USING P_LIFNR

                           P_BUKR_S.

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

*   ##### ##### ########.