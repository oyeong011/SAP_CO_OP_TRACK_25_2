
*&---------------------------------------------------------------------*

*& Report ZWORK24_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK24_002.



include
ZWORK24_002_TOP
.

include
ZWORK24_002_SCR
.

include
ZWORK24_002_F01
.

include
ZWORK24_002_F01_PDF
.

include
ZWORK24_002_PBO
.

include
ZWORK24_002_PAI
.



INITIALIZATION.

  "#### ### ##

  PERFORM SET_INIT.



START-OF-SELECTION.

  "### ####

  PERFORM READ_DATA.



  IF GT_OUTPUT IS INITIAL.

    MESSAGE 'EMPTY DATA' TYPE 'E'.

    EXIT.

  ELSE.

    "ALV ## ###

    CALL SCREEN 100.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### ######