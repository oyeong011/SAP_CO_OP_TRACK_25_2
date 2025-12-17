
*&---------------------------------------------------------------------*

*& Report ZWORK12_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK12_002 MESSAGE-ID ZMED12.



include
ZWORK12_002_TOP
.

include
ZWORK12_002_SCR
.

include
ZWORK12_002_F01
.

include
ZWORK12_002_F01_PDF
.

include
ZWORK12_002_PBO
.

include
ZWORK12_002_PAI
.



INITIALIZATION.

PERFORM SCREEN_INIT. "####.



AT SELECTION-SCREEN.



AT SELECTION-SCREEN OUTPUT.



START-OF-SELECTION.

  PERFORM GET_DATA. "ZTCURR12## DATA ####.



  IF GT_ZTCURR[] IS NOT INITIAL.

    "ALV ## ###.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ##2





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ##!