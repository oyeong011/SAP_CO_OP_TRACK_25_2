
*&---------------------------------------------------------------------*

*& Report ZSPLITTER_CONTAINER10

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZSPLITTER_CONTAINER10 MESSAGE-ID ZME10.



include
ZSPLITTER_CONTAINER10_TOP
.



include
ZSPLITTER_CONTAINER10_SCR
.

include
ZSPLITTER_CONTAINER10_F01
.

include
ZSPLITTER_CONTAINER10_PBO
.

include
ZSPLITTER_CONTAINER10_PAI
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