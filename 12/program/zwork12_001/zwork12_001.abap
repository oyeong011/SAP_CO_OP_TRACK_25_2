
*&---------------------------------------------------------------------*

*& Report ZWORK12_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK12_001 MESSAGE-ID ZMED12.



include
ZWORK12_001_CLS
.

include
ZWORK12_001_TOP
.

include
ZWORK12_001_SCR
.

include
ZWORK12_001_F01
.

include
ZWORK12_001_PBO
.

include
ZWORK12_001_PAI
.



INITIALIZATION.

  PERFORM SCREEN_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN_OUTPUT. "## ## M## ##



AT SELECTION-SCREEN.

  IF SSCRFIELDS-UCOMM = 'FC01'.

    PERFORM EXCEL_TEMPLATE_DOWNLOAD.

  ENDIF.



  "EXCELFILE UPLOAD.

  "## ## ## (## ## ### ##)



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM FILE_UPLOAD.



START-OF-SELECTION.

  IF P_FILE IS INITIAL.

    MESSAGE I000.

  ELSE.

    PERFORM EXCEL_TO_ITAB.

  ENDIF.



  IF GT_ZTCURR[] IS NOT INITIAL.

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ##1





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ###(ZEDR12_EXCEL)# SMW0# #### ## ####.