
*&---------------------------------------------------------------------*

*& Report ZEDR022_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_023 MESSAGE-ID ZMED22_1.



"/se24 - #### ## ### #### ### ## ### # # ##

include
ZSPLITTER_CONTAINER022_TOP
.

include
ZSPLITTER_CONTAINER022_SCR
.

include
ZSPLITTER_CONTAINER022_F01
.

include
ZSPLITTER_CONTAINER022_O01
.

include
ZSPLITTER_CONTAINER022_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####