
*&---------------------------------------------------------------------*

*& Report ZEDMM03_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDMM03_003 MESSAGE-ID ZME03.



include
ZMM03_003_CLS
.

include
ZMM03_003_TOP
.

include
ZMM03_003_SCR
.

include
ZMM03_003_F01
.

include
ZMM03_003_PBO
.

include
ZMM03_003_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.



AT SELECTION-SCREEN.

  PERFORM SELECTION_SCREEN.



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