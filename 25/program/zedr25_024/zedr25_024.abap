
*&---------------------------------------------------------------------*

*& Report ZED25_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZED25_024 MESSAGE-ID ZMED25.

include
ZEDR25_024_CLS
.

include
ZEDR25_024_TOP
.

include
ZEDR25_024_SCR
.

include
ZEDR25_024_F01
.

include
ZEDR25_024_PBO
.

include
ZEDR25_024_PAI
.



INITIALIZATION.

PERFORM SET_INIT.





START-OF-SELECTION.



IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

ENDIF.



PERFORM MODIFY_DATA.



IF GT_STUDENT[] IS NOT INITIAL.

  CALL SCREEN 100.

ELSE.

  MESSAGE I000.

  EXIT.

ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########