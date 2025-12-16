
*&---------------------------------------------------------------------*

*& Report ZWORK04_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK04_001 MESSAGE-ID ZMED04.



include
ZWORK04_001_CLS
.

include
ZWORK04_001_TOP
.

include
ZWORK04_001_SCR
.

include
ZWORK04_001_F01
.

include
ZWORK04_001_PBO
.

include
ZWORK04_001_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.

  SELECTION-SCREEN FUNCTION KEY 1.  " ##### #### ## ##



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCR_OUTPUT.



AT SELECTION-SCREEN.

  IF SSCRFIELDS-UCOMM = 'FC01'.

    PERFORM EXCEL_TEMPLATE_DOWNLOAD.

  ENDIF.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM SET_SCR_ON_VALUE_REQUEST.



START-OF-SELECTION.

  PERFORM CHECK_MANDATORY.

  PERFORM GET_EXCEL_DATA.



  IF GT_ZTCURR04[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE '##### #### ####.' TYPE 'I'.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ####