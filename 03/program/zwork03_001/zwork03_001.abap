
*&---------------------------------------------------------------------*

*& Report ZWORK03_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK03_001 MESSAGE-ID ZME03.



include
ZWORK03_001_CLS
.

include
ZWORK03_001_TOP
.

include
ZWORK03_001_SCR
.

include
ZWORK03_001_F01
.

include
ZWORK03_001_PBO
.

include
ZWORK03_001_PAI
.



INITIALIZATION. "#### ## ### ##

  TEXT01 = '####'.

  BTN_TMPL = '### ####'.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM F4_FILE_OPEN. "F4 ## ## ##



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'TMPL'. "## ### #### ## ## # ####

    PERFORM DOWNLOAD_TEMPLETE. "### #### FORM

  ENDIF.

  LOOP AT SCREEN.

  IF SCREEN-NAME = 'P_KURST'.

    SCREEN-INPUT = 0.

    MODIFY SCREEN.

  ENDIF.

ENDLOOP.



START-OF-SELECTION.

  IF P_FILE IS INITIAL OR S_ZGDATU IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA USING S_ZGDATU-LOW.



  IF GT_CURR[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## # ####.