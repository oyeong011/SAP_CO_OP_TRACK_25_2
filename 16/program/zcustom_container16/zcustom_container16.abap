
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER16

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM_CONTAINER16 MESSAGE-ID ZMED16.



include
ZCUSTOM_CONTAINER16_TOP
.

include
ZCUSTOM_CONTAINER16_SCR
.

include
ZCUSTOM_CONTAINER16_F01
.

include
ZCUSTOM_CONTAINER16_O01
.

include
ZCUSTOM_CONTAINER16_I01
.



INITIALIZATION.

  PERFORM SET_INITIAL.






*AT SELECTION-SCREEN OUTPUT.

*  PERFORM SET_SCREEN.






START-OF-SELECTION.

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