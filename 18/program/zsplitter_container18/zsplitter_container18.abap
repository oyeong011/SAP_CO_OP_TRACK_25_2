
*&---------------------------------------------------------------------*

*& Report ZSPLITTER_CONTAINER18

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZSPLITTER_CONTAINER18 MESSAGE-ID ZMED18.



include
ZSPLITTER_CONTAINER18_TOP
.

include
ZSPLITTER_CONTAINER18_SCR
.

include
ZSPLITTER_CONTAINER18_F01
.

include
ZSPLITTER_CONTAINER18_O01
.

include
ZSPLITTER_CONTAINER18_I01
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