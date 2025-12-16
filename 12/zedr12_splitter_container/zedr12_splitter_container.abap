
*&---------------------------------------------------------------------*

*& Report ZEDR12_SPLITTER_CONTAINER

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_SPLITTER_CONTAINER MESSAGE-ID ZMED12.





include
ZEDR12_SPLITTER_CONTAINER_TOP
.

include
ZEDR12_SPLITTER_CONTAINER_SCR
.

include
ZEDR12_SPLITTER_CONTAINER_F01
.

include
ZEDR12_SPLITTER_CONTAINER_PBO
.

include
ZEDR12_SPLITTER_CONTAINER_PAI
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

* T100 --> SPLITTER CONTAINER