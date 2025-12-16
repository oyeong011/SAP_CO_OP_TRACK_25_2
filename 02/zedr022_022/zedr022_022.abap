
*&---------------------------------------------------------------------*

*& Report ZEDR022_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_022.

"/se24 - #### ## ### #### ### ## ### # # ##

include
ZDOCKING_CONTAINER022_TOP
.

include
ZDOCKING_CONTAINER022_SCR
.

include
ZDOCKING_CONTAINER022_F01
.

include
ZDOCKING_CONTAINER022_O01
.

include
ZDOCKING_CONTAINER022_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  "IF S_ZCODE IS INITIAL.

    "MESSAGE I000.

    "EXIT.

  "ENDIF.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  "IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  "ELSE.

   " MESSAGE I000.

   " EXIT.

  "ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####