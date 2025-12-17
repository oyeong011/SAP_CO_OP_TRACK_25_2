
*&---------------------------------------------------------------------*

*& Report ZCUSTOM14_CONTAINER01

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM14_CONTAINER01 MESSAGE-ID ZMED14.



include
ZCUSTOM14_CONTAINER01_TOP
.

include
ZCUSTOM14_CONTAINER01_SCR
.

include
ZCUSTOM14_CONTAINER01_F01
.

include
ZCUSTOM14_CONTAINER01_O01
.

include
ZCUSTOM14_CONTAINER01_I01
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

    MESSAGE I001.

    EXIT.

  ENDIF.