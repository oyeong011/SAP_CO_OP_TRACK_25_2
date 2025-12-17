
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER11

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM_CONTAINER11 MESSAGE-ID ZMED11.



include
ZCUSTUM_CONTAINER11_TOP
.

include
ZCUSTUM_CONTAINER11_SCR
.

include
ZCUSTUM_CONTAINER11_F01
.

include
ZCUSTUM_CONTAINER11_O01
.

include
ZCUSTUM_CONTAINER11_I01
.



INITIALIZATION.

PERFORM SET_INITIAL.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

 PERFORM GET_DATA.



BREAK-POINT.



 IF GT_STUDENT[] IS NOT INITIAL.

   CALL SCREEN 100.

   ELSE.

     MESSAGE I000.

     EXIT.

     ENDIF.