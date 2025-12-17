
*&---------------------------------------------------------------------*

*& Report ZDOCKING_CONTAINER16

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZDOCKING_CONTAINER16 MESSAGE-ID ZMED16.



include
ZDOCKING_CONTAINER16_CLS
.

include
ZDOCKING_CONTAINER16_TOP
.

include
ZDOCKING_CONTAINER16_SCR
.

include
ZDOCKING_CONTAINER16_F01
.

include
ZDOCKING_CONTAINER16_O01
.

include
ZDOCKING_CONTAINER16_I01
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