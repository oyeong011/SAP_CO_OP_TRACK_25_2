
*&---------------------------------------------------------------------*

*& Report ZWORK21_001

*&---------------------------------------------------------------------*




REPORT ZWORK21_001.



include
ZWORK21_001_CLS
.

include
ZWORK21_001_TOP
.

include
ZWORK21_001_SCR
.

include
ZWORK21_001_F01
.

include
ZWORK21_001_PBO
.

include
ZWORK21_001_PAI
.





"SELECTION-SCREEN ###

INITIALIZATION.

"## DOWNLOAD ## ### ## FORM ##

  PERFORM SET_FUNCTION_KEY.



AT SELECTION-SCREEN OUTPUT.

  "##### ## ## ##

  PERFORM SET_SCREEN.

"## ## #

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  "F4#### ## ## ## ##

  CALL FUNCTION 'F4_FILENAME'

  "### ### P_FILE# ##

    IMPORTING

      FILE_NAME = P_FILE.





"SELECTION SCREEN## ACTION##

AT SELECTION-SCREEN.

  "FC01 #, ### #### ## ## #

  IF SSCRFIELDS-UCOMM = 'FC01'.



    "## ## ### ## GV_DOWNLOAD_REQUEST# # # # #

    IF GV_DOWNLOAD_REQUEST = ABAP_FALSE.

       GV_DOWNLOAD_REQUEST = ABAP_TRUE.

      "DOWNLOAD_REQUEST# ### ## ####

      PERFORM DOWNLOAD_TEMPLATE.

      "CLEAR## ## ### ##

      CLEAR SSCRFIELDS-UCOMM.

      CLEAR GV_DOWNLOAD_REQUEST.

      LEAVE SCREEN.

    ENDIF.



  ENDIF.



  "#### ##### #

  IF SY-UCOMM = 'ONLI'.

    "P_DATE ### ##### ## # # ## ##

    IF P_DATE IS INITIAL.

      MESSAGE '##### #####.' TYPE 'E'.

    ENDIF.

    "P_FILE# ##### ##

    IF P_FILE IS INITIAL.

      MESSAGE '#### #####.' TYPE 'E'.

    ENDIF.

  ENDIF.



START-OF-SELECTION.

  "EXCEL ### ## GT_TCURR# ##

  PERFORM GET_DATA.

  "## # ## #### ####, ## ## # ##.

  PERFORM MODIFY_DATA.

  "## 100 #### ALV ## ##

  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   NO TEMPLATE.