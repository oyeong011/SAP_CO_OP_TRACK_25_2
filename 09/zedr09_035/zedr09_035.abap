
*&---------------------------------------------------------------------*

*& Report ZEDR09_035

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_035.



include
ZEDR09_035_TOP
.

include
ZEDR09_035_SCR
.

include
ZEDR09_035_F01
.

include
ZEDR09_035_PBO
. "## ##

include
ZEDR09_035_PAI
. "## ##



INITIALIZATION.

  PERFORM GET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE 'GT_STUDENT## #### #### ####' TYPE 'I'.

    EXIT.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   GT_STUDENT## #### #### ####