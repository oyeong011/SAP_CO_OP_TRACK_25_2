
*&---------------------------------------------------------------------*

*& Report ZSPLITTER14_CONTAINER01

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZSPLITTER14_CONTAINER01 MESSAGE-ID ZMED14.



include
ZSPLITTER14_CONTAINER01_TOP
.

include
ZSPLITTER14_CONTAINER01_SCR
.

include
ZSPLITTER14_CONTAINER01_F01
.

include
ZSPLITTER14_CONTAINER01_O01
.

include
ZSPLITTER14_CONTAINER01_I01
.



INITIALIZATION.

  PERFORM SET_INITIAL.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I001.

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