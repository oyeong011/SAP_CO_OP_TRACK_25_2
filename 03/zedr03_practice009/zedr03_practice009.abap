
*&---------------------------------------------------------------------*

*& Report ZEDR03_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_PRACTICE009 MESSAGE-ID ZME03.



include
ZEDR03_PRACTICE9_TOP
.

include
ZEDR03_PRACTICE9_SCR
.

include
ZEDR03_PRACTICE9_F01
.

include
ZEDR03_PRACTICE9_PBO
.

include
ZEDR03_PRACTICE9_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZPERNR  IS INITIAL. "## ## ### ### ####

      MESSAGE E000.

      EXIT.

  ELSE.

    PERFORM GET_DATA.

    PERFORM MODIFY_DATA.

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###