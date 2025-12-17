
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER_25

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM_CONTAINER_25 MESSAGE-ID ZMED25.



include
ZCUSTOM_CONTAINER_TOP_25
.

include
ZCUSTOM_CONTAINER_SCR_25
.

include
ZCUSTOM_CONTAINER_F01_25
.

include
ZCUSTOM_CONTAINER_O01_25
.

include
ZCUSTOM_CONTAINER_I01_25
.



INITIALIZATION.

PERFORM SET_INITIAL.






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