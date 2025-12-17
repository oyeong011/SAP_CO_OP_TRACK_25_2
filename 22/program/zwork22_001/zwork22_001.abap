
*&---------------------------------------------------------------------*

*& Report ZWORK22_001

*&---------------------------------------------------------------------*




REPORT ZWORK22_001.






*---------------------------------------------------------------------*

* Include ##

*---------------------------------------------------------------------*




include
ZWORK22_001_CLS
.

include
ZWORK22_001_TOP
.

include
ZWORK22_001_SCR
.

include
ZWORK22_001_F01
.

include
ZWORK22_001_PBO
.

include
ZWORK22_001_PAI
.






*---------------------------------------------------------------------*

* INITIALIZATION

*---------------------------------------------------------------------*




INITIALIZATION.

  PERFORM CLICK_BUTTON.          " ## ### #### ## ##






*---------------------------------------------------------------------*

* AT SELECTION-SCREEN ON VALUE-REQUEST (F4 ###)

*---------------------------------------------------------------------*




AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE."F4###

  CALL FUNCTION 'F4_FILENAME'




*  EXPORTING

*     PROGRAM_NAME        = SYST-CPROG

*     DYNPRO_NUMBER       = SYST-DYNNR

*     FIELD_NAME          = ' '




   IMPORTING

     FILE_NAME           = P_FILE.






*---------------------------------------------------------------------*

* AT SELECTION-SCREEN : Function Key (FC01) ### ##

*---------------------------------------------------------------------*




AT SELECTION-SCREEN.

  CASE SY-UCOMM.

    WHEN 'FC01'.

      PERFORM EXCEL_DOWNLOAD. "## ####

  ENDCASE.






*---------------------------------------------------------------------*

* AT SELECTION-SCREEN OUTPUT

*---------------------------------------------------------------------*




AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN.      " #### ## (#### #### #)






*---------------------------------------------------------------------*

* START-OF-SELECTION : ## # (## ## ## #)

*---------------------------------------------------------------------*




START-OF-SELECTION.



  " 1. CSV ## ### # ###### ##

  PERFORM READ_DATA USING P_FILE.

  " 2. ## ### ## (#### ##, ####, ###/## ##)

  PERFORM MODIFY_DATA.



  " 3. ALV ##

  "IF GT_CURR_ALV IS NOT INITIAL.

    CALL SCREEN 100.             " ALV ## ## ##

  "ELSE.

  "  MESSAGE '### #### ####.' TYPE 'I'.

  "ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ##

* T100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   SMW0# ### ###(ZCURRENCY_TEMPLATE)# ## # ####.