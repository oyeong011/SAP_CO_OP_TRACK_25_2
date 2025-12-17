
*&---------------------------------------------------------------------*

*& Report ZWORK02_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK02_001 MESSAGE-ID ZMED02.



include
ZWORK02_001_CLS
.

include
ZWORK02_001_TOP
.

include
ZWORK02_001_SCR
.

include
ZWORK02_001_F01
.

include
ZWORK02_001_PBO
.

include
ZWORK02_001_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  CALL FUNCTION 'F4_FILENAME'




*   EXPORTING

*     PROGRAM_NAME        = SYST-CPROG

*     DYNPRO_NUMBER       = SYST-DYNNR

*     FIELD_NAME          = ' '




   IMPORTING

     FILE_NAME           = P_FILE

            .



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI' OR SY-UCOMM = ''. "##(F8)

    PERFORM VALIDATE_INPUT.

  ELSEIF SY-UCOMM = 'XTDL'. "## ### #### ## ##

    PERFORM EXCEL_TEMPLATE_DOWNLOAD.

  ENDIF.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### ###### (ALSM).