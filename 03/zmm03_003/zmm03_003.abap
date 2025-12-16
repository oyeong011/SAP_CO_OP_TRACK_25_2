
*&---------------------------------------------------------------------*

*& Report ZEDMM03_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM03_003 MESSAGE-ID ZME03.



include
ZMM03_003_CLS1
.

include
ZMM03_003_TOP1
.

include
ZMM03_003_SCR1
.

include
ZMM03_003_F011
.

include
ZMM03_003_PBO1
.

include
ZMM03_003_PAI1
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.



AT SELECTION-SCREEN.

  PERFORM SELECTION_SCREEN. "### ##



START-OF-SELECTION.

  IF P_R1 = 'X'.

    "## ## ### # ### ##

    PERFORM GET_DATA_CRE.

  ELSE.

    "## ## ### # ### ##

    PERFORM GET_DATA_DIS.

  ENDIF.



  IF GT_DATA[] IS INITIAL.

    MESSAGE E001. "### #### ####.

    EXIT.

  ENDIF.



END-OF-SELECTION.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ## [&1]





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### #####.