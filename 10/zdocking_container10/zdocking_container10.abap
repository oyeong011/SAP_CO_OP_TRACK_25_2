
*&---------------------------------------------------------------------*

*& Report ZDOCKING_CONTAINER10

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZDOCKING_CONTAINER10 MESSAGE-ID ZME10.



include
ZDOCKING_CONTAINER10_TOP
.

include
ZDOCKING_CONTAINER10_SCR
.

include
ZDOCKING_CONTAINER10_F01
.

include
ZDOCKING_CONTAINER10_O01
.

include
ZDOCKING_CONTAINER10_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #### ## ####