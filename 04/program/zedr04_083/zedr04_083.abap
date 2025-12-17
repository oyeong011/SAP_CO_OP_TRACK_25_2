
*&---------------------------------------------------------------------*

*& Report ZEDR04_083

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_083 MESSAGE-ID ZMED04.



include
ZEDR04_083_TOP
.

include
ZEDR04_083_SCR
.

include
ZEDR04_083_F01
.

include
ZEDR04_083_PBO
.

include
ZEDR04_083_PAI
.



INITIALIZATION. " ### ##. START-OF-SELECTION ### ##.

  PERFORM SET_INIT.





START-OF-SELECTION. " ### F8 ### SELECT## #### ##

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####