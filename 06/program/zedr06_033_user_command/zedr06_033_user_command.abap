
*&---------------------------------------------------------------------*

*& Report ZEDR06_033_USER_COMMAND

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_033_USER_COMMAND MESSAGE-ID ZMED06.







" # #### ## ### ####

" 1. APPEND ## ##

" 2. APPEND ### ## MODULE USER_COMMAND# OK_CODE# APND# ##



include
ZEDR06_033_USER_COMMAND_TOP
.

include
ZEDR06_033_USER_COMMAND_F01
.

include
ZEDR06_033_USER_COMMAND_PBO
.

include
ZEDR06_033_USER_COMMAND_PAI
.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

  ENDIF.