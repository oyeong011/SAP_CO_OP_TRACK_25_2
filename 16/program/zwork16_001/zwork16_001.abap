
*&---------------------------------------------------------------------*

*& Report ZWORK16_001

*&---------------------------------------------------------------------*




REPORT ZWORK16_001 MESSAGE-ID ZMED16.



include
ZWORK16_001_CLS
.

include
ZWORK16_001_TOP
.

include
ZWORK16_001_SCR
.

include
ZWORK16_001_F01
.

include
ZWORK16_001_PBO
.

include
ZWORK16_001_PAI
.



INITIALIZATION.

  " #### ## ## ##

  PERFORM SET_TEMPLATE_DOWNLOAD_BTN.



AT SELECTION-SCREEN.

  CASE SSCRFIELDS-UCOMM.

    WHEN 'FC01'.

      " ### #### ## ## ##

      PERFORM DOWNLOAD_EXCEL_TEMPLATE.

    WHEN OTHERS.

      " #### ### ##

      PERFORM INIT_SELECTION.

  ENDCASE.



AT SELECTION-SCREEN OUTPUT.

  " KURST ## ##/##

  PERFORM FIX_KURST.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  " ## ## F4 ###

  PERFORM F4_FILE_PATH.



START-OF-SELECTION.

  " ## ## ##

  PERFORM READ_EXCEL_FILE USING P_FILE.



  " ALV ### ##

  PERFORM SET_EXCHANGE_RATE_ALV.



  " #### ### ## 100 ##

  IF GT_EXCHANGE_RATE_ALV[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    " ### ### ### ## # ##

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ###

* T100 --> ## ###





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### #####.