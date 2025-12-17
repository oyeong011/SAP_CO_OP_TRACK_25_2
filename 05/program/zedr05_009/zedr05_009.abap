
*&---------------------------------------------------------------------*

*& Report ZEDR05_009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_009 MESSAGE-ID ZMED05.



include
ZSPLITTER_CONTAINER05_CLS
.

include
ZSPLITTER_CONTAINER05_TOP
.

include
ZSPLITTER_CONTAINER05_SCR
.

include
ZSPLITTER_CONTAINER05_F01
.

include
ZSPLITTER_CONTAINER05_O01
.

include
ZSPLITTER_CONTAINER05_I01
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

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ZEDR05_009





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########