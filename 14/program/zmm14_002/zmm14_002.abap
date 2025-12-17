
*&---------------------------------------------------------------------*

*& Report ZMM14_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM14_002.



include
ZMM14_002_CLS
.

include
ZMM14_002_TOP
.

include
ZMM14_002_SCR
.

include
ZMM14_002_F01
.

include
ZMM14_002_F02
.

include
ZMM14_002_PBO
.

include
ZMM14_002_PAI
.





AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_OUTPUT.



START-OF-SELECTION.

  IF P_R1 = 'X'.

    PERFORM GET_HEADER_DATA.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #### ##

* T200 --> #### ##





*Messages

*----------------------------------------------------------

*

* Message class: 00

*001   &1&2&3&4&5&6&7&8

*

* Message class: Hard coded

*   ## #### ####.