
*&---------------------------------------------------------------------*

*& Report ZMM03_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM03_004 MESSAGE-ID ZME03.



include
ZMM03_004_CLS
.

include
ZMM03_004_TOP
.

include
ZMM03_004_SCR
.

include
ZMM03_004_F01
.

include
ZMM03_004_PBO
.

include
ZMM03_004_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCFREEN_OUTPUT.



AT SELECTION-SCREEN.

  PERFORM CHECK_SELECTION_SCREEN.



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








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### #####.