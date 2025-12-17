
*&---------------------------------------------------------------------*

*& Report ZEDR14_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_PRACTICE008 MESSAGE-ID ZMED14.



"#######(CLASS ALV#)

include
ZEDR14_PRACTICE008_TOP
.

include
ZEDR14_PRACTICE008_SCR
.

include
ZEDR14_PRACTICE008_F01
.

include
ZEDR14_PRACTICE008_PBO
.

include
ZEDR14_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_INITIAL.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  IF P_R1 = 'X'.

    CALL SCREEN 100.

  ELSE.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######