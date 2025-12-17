
*&---------------------------------------------------------------------*

*& REPORT ZWORK11_001

*&---------------------------------------------------------------------*

*& ## ####

*& - ####(P_DATE)# ## ##(P_FILE)# #### ## ### ALV# ##

*& - '### ####' #### EXCEL ### ##

*& - ALV## ##(UKURS) ## ## ## ## (## # ##)

*& - '####(SAVE)' # ## ## # ZTCURR11 #### ## ##

*& - ALV# DOCKING ##### ##

*&---------------------------------------------------------------------*






REPORT ZWORK11_001.



include
ZWORK11_001_CLS
.

include
ZWORK11_001_TOP
.

include
ZWORK11_001_SCR
.

include
ZWORK11_001_F01
.

include
ZWORK11_001_PBO
.

include
ZWORK11_001_PAI
.






*---------------------------------------------------------------------*

* ## ## ###/### ## (SSCRFIELDS)

*---------------------------------------------------------------------*




INITIALIZATION.

  G_FUNCTION_KEY-ICON_ID   = ICON_TOTAL_DOWN.

  G_FUNCTION_KEY-ICON_TEXT = '### ####'.

  G_FUNCTION_KEY-TEXT      = '### ####'.

  SSCRFIELDS-FUNCTXT_01    = G_FUNCTION_KEY.






*---------------------------------------------------------------------*

* ## ## ## # ## ##/###

*---------------------------------------------------------------------*




AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.






*---------------------------------------------------------------------*

* ## F4 ##: ## ## ## ##

*---------------------------------------------------------------------*




AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  CALL FUNCTION 'F4_FILENAME'

    IMPORTING

      FILE_NAME = P_FILE.






*---------------------------------------------------------------------*

* ##(F8) # ### #### ## ##

*---------------------------------------------------------------------*




AT SELECTION-SCREEN.

  CASE SY-UCOMM.

    WHEN 'ONLI'.               "F8 ##

      IF P_DATE IS INITIAL.

        MESSAGE '##### #####.' TYPE 'E'.

      ENDIF.

      IF P_FILE IS INITIAL.

        MESSAGE '#### #####.' TYPE 'E'.

      ENDIF.

  ENDCASE.



  CASE SSCRFIELDS-UCOMM.       "## FUNCTION KEY 1 (###)

    WHEN 'FC01'.

      PERFORM TEMPLETE_DOWN.

  ENDCASE.






*---------------------------------------------------------------------*

* ## ##: ## ## # ### ## # ## 0100 ##

*---------------------------------------------------------------------*




START-OF-SELECTION.

  PERFORM GET_DATA.     "## # ## ### ##

  PERFORM MODI_DATA.    "## ##(##/##/###)

  CALL SCREEN 100.      "ALV ##(##)






*GUI Texts

*----------------------------------------------------------

* T100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## # ####.