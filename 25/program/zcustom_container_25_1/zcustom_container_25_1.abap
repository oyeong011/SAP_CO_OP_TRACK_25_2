
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER_25_1

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT ZCUSTOM_CONTAINER_25_1 MESSAGE-ID ZMED25.



include
ZCUSTOM_CONTAINER_TOP_25_1
.

include
ZCUSTOM_CONTAINER_SCR_25_1
.

include
ZCUSTOM_CONTAINER_F01_25_1
.

include
ZCUSTOM_CONTAINER_O01_25_1
.

include
ZCUSTOM_CONTAINER_I01_25_1
.



INITIALIZATION.

PERFORM SET_INITIAL.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.