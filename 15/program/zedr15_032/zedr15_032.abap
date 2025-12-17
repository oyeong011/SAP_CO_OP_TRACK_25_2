
*&---------------------------------------------------------------------*

*& Report ZEDR15_032

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_032 MESSAGE-ID ZMED15.



include
ZEDR15_032_CLS
.

include
ZEDR15_032_TOP
.

include
ZEDR15_032_SCR
.

include
ZEDR15_032_F01
.

include
ZEDR15_032_O01
.

include
ZEDR15_032_I01
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

*   ##########