
*&---------------------------------------------------------------------*

*& Report ZEDR24_022_CLASSALV

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_022_CLASSALV MESSAGE-ID ZEDM24.



include
ZCUSTOM_CONTAINER24_TOP
.

include
ZCUSTOM_CONTAINER24_SCR
.

include
ZCUSTOM_CONTAINER24_F01
.

include
ZCUSTOM_CONTAINER24_PBO
.

include
ZCUSTOM_CONTAINER24_PAI
.



INITIALIZATION.

  PERFORM SET_INITIAL.



AT SELECTION-SCREEN OUTPUT.

  "PERFORM SET_SCREEN.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I100.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.