
*&---------------------------------------------------------------------*

*& Report ZWORK23_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK23_001.



include
ZWORK23_001_CLS
.

include
ZWORK23_001_TOP
.

include
ZWORK23_001_SCR
.

include
ZWORK23_001_F01
.

include
ZWORK23_001_PBO
.

include
ZWORK23_001_PAI
.



INITIALIZATION.

  PERFORM SCREEN_INIT.  "## ##



" ## ### ###

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM FILE_UPLOAD.



AT SELECTION-SCREEN OUTPUT.

  PERFORM ASSO.



" ### ####

AT SELECTION-SCREEN.



  CASE SSCRFIELDS-UCOMM.

    WHEN 'FC01'.

      PERFORM FILE_DOWNLOAD.

  ENDCASE.



START-OF-SELECTION.

  PERFORM EXCEL_TO_ITABLE.





CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ## ##