
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER21

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM_CONTAINER21 MESSAGE-ID ZMED00.





include
ZCUSTOM_CONTAINER21_TOP
.

include
ZCUSTOM_CONTAINER21_SCR
.

include
ZCUSTOM_CONTAINER21_F01
.

include
ZCUSTOM_CONTAINER21_001
.



include
ZCUSTOM_CONTAINER21_I01
.



INITIALIZATION.

  PERFORM SET_INITIAL.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



  START-OF-SELECTION.

    PERFORM GET_DATA.



 IF GT_STUDENT IS NOT INITIAL.

   CALL SCREEN 100.

   ELSE.

      MESSAGE I000.

      EXIT.

      ENDIF.