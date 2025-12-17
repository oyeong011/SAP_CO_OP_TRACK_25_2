
*&---------------------------------------------------------------------*

*& Report ZWORK10_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK10_001 MESSAGE-ID ZME10.



include
ZWORK10_1_TOP
.



include
ZWORK10_1_SCR
.

include
ZWORK10_1_F01
.

include
ZWORK10_1_PBO
.

include
ZWORK10_1_PAI
.



INITIALIZATION.

  SELECTION-SCREEN FUNCTION KEY 1.

  " function key 1 ##

  GS_FUNCTXT-ICON_ID = ICON_EXPORT.

  GS_FUNCTXT-ICON_TEXT = '### ####'.

  SSCRFIELDS-FUNCTXT_01 = GS_FUNCTXT.



AT SELECTION-SCREEN.

  " FUNCTION KEY ### ##

  PERFORM FUNCTION_KEY.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM INIT_DATA.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    "KURST ## ### ### ##

    IF SCREEN-GROUP1 = 'M1'.

      SCREEN-INPUT = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.






* #### ## ##




START-OF-SELECTION.

  IF P_FILE IS INITIAL OR P_DATE IS INITIAL.

    MESSAGE '### ### ## #####.' TYPE 'E'.

    EXIT.

  ENDIF.



  " ### ##

  PERFORM PARSE_DATA.



  IF GT_EXCEL_DATA[] IS NOT INITIAL.

    " ALV ##

    CALL SCREEN 100.



  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####

* T100 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ## ##