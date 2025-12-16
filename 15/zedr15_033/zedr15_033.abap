
*&---------------------------------------------------------------------*

*& Report ZEDR15_033

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_033 MESSAGE-ID ZMED15.





include
ZEDR15_033_CLS
.

include
ZEDR15_033_TOP
.

include
ZEDR15_033_SCR
.

include
ZEDR15_033_F01
.

include
ZEDR15_033_O01
.

include
ZEDR15_033_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

   MESSAGE I100.

   EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I100.

    EXIT.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####