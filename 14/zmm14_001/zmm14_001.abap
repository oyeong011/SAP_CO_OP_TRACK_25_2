
*&---------------------------------------------------------------------*

*& Report ZMM14_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM14_001.



include
ZMM14_001_CLS
.

include
ZMM14_001_TOP
.

include
ZMM14_001_SCR
.

include
ZMM14_001_F01
.

include
ZMM14_001_PBO
.

include
ZMM14_001_PAI
.





AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_OUTPUT.



AT SELECTION-SCREEN.

  PERFORM CHECK_INPUT.



START-OF-SELECTION.

  IF P_R1 = 'X'.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ### ##

* T200 --> ### ##





*Messages

*----------------------------------------------------------

*

* Message class: 00

*001   &1&2&3&4&5&6&7&8

*

* Message class: Hard coded

*   ##### #### ###.