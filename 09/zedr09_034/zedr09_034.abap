
*&---------------------------------------------------------------------*

*& Report ZEDR09_034

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_034.



include
ZEDR09_034_TOP
.

include
ZEDR09_034_SCR
.

include
ZEDR09_034_F01
.

include
ZEDR09_034_PBO
.

include
ZEDR09_034_PAI
.



INITIALIZATION.

  PERFORM GET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE 'GT_STUDENT ##### ####' TYPE 'I'.

    EXIT.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   GT_STUDENT ##### ####