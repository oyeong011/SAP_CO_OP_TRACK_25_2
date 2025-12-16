
*&---------------------------------------------------------------------*

*& Report ZWORK09_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK09_001 MESSAGE-ID ZMED09. "message #### ##### ##



include
ZWORK09_001_CLS
.

include
ZWORK09_001_TOP
.

include
ZWORK09_001_SCR
.

include
ZWORK09_001_F01
.

include
ZWORK09_001_PBO
.

include
ZWORK09_001_PAI
.





INITIALIZATION.

  PERFORM MAKE_BUTTON. "### #### ## ###



AT SELECTION-SCREEN.

  CASE SY-UCOMM.

    WHEN 'FC01'. "Function Key 1 = FC01 (####### ## ### #)

      PERFORM DOWNLOAD_TEMPLATE.

  ENDCASE.





AT SELECTION-SCREEN OUTPUT.

  PERFORM CONTROL_SCREEN. "## ##



"f4# ### #, ## ## ### #### ### ##

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

   CALL FUNCTION 'F4_FILENAME'

      IMPORTING

        FILE_NAME = P_FILE.



"######

START-OF-SELECTION.

  PERFORM READ_DATA USING P_FILE.

  PERFORM MODIFY_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ## ## ### ## 5####