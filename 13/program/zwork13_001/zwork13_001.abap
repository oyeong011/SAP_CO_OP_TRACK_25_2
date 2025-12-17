
*&---------------------------------------------------------------------*

*& Report ZWORK13_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK13_001 MESSAGE-ID ZMED13.



include
ZWORK13_001_CLS
.

include
ZWORK13_001_TOP
.

include
ZWORK13_001_SCR
.

include
ZWORK13_001_F01
.

include
ZWORK13_001_O01
.

include
ZWORK13_001_I01
.



INITIALIZATION.

  PERFORM MAKE_BUTTON.

AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_HADLING.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FNAME.

  PERFORM XLSX_HANDLING.

AT SELECTION-SCREEN.

  PERFORM BUTTON_COMMAND.

START-OF-SELECTION.

  IF GT_FINAL IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T001 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### #########.