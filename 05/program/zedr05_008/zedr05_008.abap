
*&---------------------------------------------------------------------*

*& Report ZEDR05_008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_008 MESSAGE-ID ZMED05.





include
ZDOCKING_CONTAINER05_TOP
.

include
ZDOCKING_CONTAINER05_SCR
.

include
ZDOCKING_CONTAINER05_F01
.

include
ZDOCKING_CONTAINER05_O01
.

include
ZDOCKING_CONTAINER05_I01
.





INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

 IF S_ZCODE IS INITIAL.

   MESSAGE I000.

   EXIT.

 ENDIF.

 PERFORM GET_DATA.



IF GT_STUDENT[] IS NOT INITIAL.

   CALL SCREEN 100.

ELSE.

   MESSAGE I000.

   EXIT.

ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> T100