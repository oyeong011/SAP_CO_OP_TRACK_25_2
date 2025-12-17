
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER18

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZCUSTOM_CONTAINER18 MESSAGE-ID ZMED18.



include
ZCUSTOM_CONTAINER18_TOP
.

include
ZCUSTOM_CONTAINER18_SCR
.

include
ZCUSTOM_CONTAINER18_F01
.

include
ZCUSTOM_CONTAINER18_O01
.

include
ZCUSTOM_CONTAINER18_I01
.

include
ZCUSTOM_CONTAINER18_PBO
.

include
ZCUSTOM_CONTAINER18_PAI
.





INITIALIZATION.

  PERFORM SET_INITIAL.



"AT SELECTION-SCREEN OUTPUT.

"  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM GET_DATA.



 " IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

 " ELSE.

 "   MESSAGE I000.

 "   EXIT.

 " ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####