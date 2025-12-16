
*&---------------------------------------------------------------------*

*& Report ZWORK11_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK11_003.



include
ZWORK11_003_TOP
.

include
ZWORK11_003_SCR
.

include
ZWORK11_003_F01
.

include
ZWORK11_003_F01_PDF
.

include
ZWORK11_003_PBO
.

include
ZWORK11_003_PAI
.



INITIALIZATION.

  "#### ### ##

  PERFORM SET_INIT.



AT SELECTION-SCREEN.



AT SELECTION-SCREEN OUTPUT.



START-OF-SELECTION.

  "### ####

  PERFORM READ_DATA.



  IF GT_OUTPUT IS INITIAL.

    MESSAGE 'EMPTY DATA' TYPE 'E'.

  ENDIF.



  "### ####

  "PERFORM MODIFY_DATA.



  "ALV ## ###

  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### ######.