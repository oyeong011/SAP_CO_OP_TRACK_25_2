
*&---------------------------------------------------------------------*

*& Report ZEDR08_027

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_027.



include
ZCUSTOM_CONTAINER_TOP
.

include
ZCUSTOM_CONTAINER_SCR
.

include
ZCUSTOM_CONTAINER_F01
.

include
ZCUSTOM_CONTAINER_O01
.

include
ZCUSTOM_CONTAINER_I01
.



INITIALIZATION.

  PERFORM SET_INITIAL.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.