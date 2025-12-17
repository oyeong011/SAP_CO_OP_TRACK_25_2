
*&---------------------------------------------------------------------*

*& Report ZSPLITTER_CONTAINER16

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZSPLITTER_CONTAINER16 MESSAGE-ID ZMED16.



include
ZSPLITTER_CONTAINER16_TOP
.

include
ZSPLITTER_CONTAINER16_SCR
.

include
ZSPLITTER_CONTAINER16_F01
.

include
ZSPLITTER_CONTAINER16_O01
.

include
ZSPLITTER_CONTAINER16_I01
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

* T100 --> ####