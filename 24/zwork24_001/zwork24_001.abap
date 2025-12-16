
*&---------------------------------------------------------------------*

*& Report ZWORK24_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK24_001.



include
ZWORK24_001_CLS
.

include
ZWORK24_001_TOP
.

include
ZWORK24_001_SCR
.

include
ZWORK24_001_F01
.

include
ZWORK24_001_F01_EXCEL
.

include
ZWORK24_001_PBO
.

include
ZWORK24_001_PAI
.



INITIALIZATION.

  "#### ### ##

  PERFORM SET_INIT.



  "### #### ## ##

  PERFORM SCREEN_INIT.



AT SELECTION-SCREEN.

  "## ### #### ## ### #### ##

  CASE SY-UCOMM.

    WHEN 'FC01'.

      PERFORM DOWNLOAD_FILE.

  ENDCASE.



AT SELECTION-SCREEN OUTPUT.

  "## ## ##

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'S_KURST-LOW'.

      SCREEN-INPUT = 0. "## ##"

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



"## ### ## ## ### ## # ## ##### ###

AT SELECTION-SCREEN ON VALUE-REQUEST FOR PA_FILE.

  PERFORM GET_FILE.



START-OF-SELECTION.

  "##### ITAB## ###

  PERFORM READ_FILE.

  "### ## # ##

  PERFORM MODIFY_DATA.



  "ALV ## ###

  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######.