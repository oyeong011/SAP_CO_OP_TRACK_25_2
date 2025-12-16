
*&---------------------------------------------------------------------*

*& Report ZEDR04_082

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_082.



include
ZEDR04_082_TOP
.

include
ZEDR04_082_SCR
.

include
ZEDR04_082_F01
.

include
ZEDR04_082_PBO
.

include
ZEDR04_082_PAI
.





INITIALIZATION. " ### ##. START-OF-SELECTION ### ##.

  PERFORM SET_INIT.





START-OF-SELECTION. " ### F8 ### SELECT## #### ##

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####