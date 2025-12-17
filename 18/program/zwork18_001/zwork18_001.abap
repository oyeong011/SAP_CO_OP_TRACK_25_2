
*&---------------------------------------------------------------------*

*& Report ZWORK18_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK18_001 MESSAGE-ID ZMED18.



include
ZWORK18_001_TOP
.

include
ZWORK18_001_SCR
.

include
ZWORK18_001_F01
.

include
ZWORK18_001_PBO
.

include
ZWORK18_001_PAI
.



INITIALIZATION.

  SELECTION-SCREEN FUNCTION KEY 1.

  GS_FUNCTXT-ICON_ID = ICON_EXPORT.

  GS_FUNCTXT-ICON_TEXT = '## ### ####'.

  SSCRFIELDS-FUNCTXT_01 = GS_FUNCTXT.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM F4_FILE.



AT SELECTION-SCREEN.

  PERFORM FUNCTION_KEY.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  IF P_DATE IS INITIAL OR P_FILE IS INITIAL.

    MESSAGE I000.

  ELSE.

    " EXCEL ##

    PERFORM READ_XLSX_USING_ALSM USING P_FILE.

    " ### ### # ##

    IF GT_CURR[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ##