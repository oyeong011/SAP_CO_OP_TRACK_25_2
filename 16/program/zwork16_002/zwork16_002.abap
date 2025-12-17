
*&---------------------------------------------------------------------*

*& Report ZWORK16_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK16_002 MESSAGE-ID ZMED16.



include
ZWORK16_002_TOP
.

include
ZWORK16_002_SCR
.

include
ZWORK16_002_F01
.

include
ZWORK16_002_PBO
.

include
ZWORK16_002_PAI
.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  IF GT_EXCHANGE_RATE_ALV[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ###





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   Temp directory error