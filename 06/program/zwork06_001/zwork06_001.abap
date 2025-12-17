
*&---------------------------------------------------------------------*

*& Report ZWORK06_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK06_001 MESSAGE-ID ZMED06.



include
ZWORK06_001_CLS
.  " ### ### ##

include
ZWORK06_001_TOP
.  " ## ##/## ##

include
ZWORK06_001_SCR
.  " ## ## ##

include
ZWORK06_001_F01
.  " # ##

include
ZWORK06_001_PBO
.  " ## PBO ##

include
ZWORK06_001_PAI
.  " ## PAI ##



" ### ##

INITIALIZATION.



" ## ##

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_KURST'.

      SCREEN-INPUT = 0.         " ##### ##### ####

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



" F4 ## ##

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM F4_FILE_OPEN CHANGING P_FILE.



" ## ## ##

START-OF-SELECTION.

  " ## ### # ## ###

  IF P_FILE IS INITIAL.

   MESSAGE '##### #####' TYPE 'E'.

  ENDIF.



  " ## ### ## # ##### ##

  PERFORM READ_FILE_DATA CHANGING P_FILE.

  PERFORM MODIFY_DATA.



  " ALV ## ## ##

  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### ####.