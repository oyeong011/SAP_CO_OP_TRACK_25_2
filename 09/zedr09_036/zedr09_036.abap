
*&---------------------------------------------------------------------*

*& Report ZEDR09_036

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_036.



include
ZEDR09_036_TOP
.

include
ZEDR09_036_SCR
.

include
ZEDR09_036_F01
.

include
ZEDR09_036_PBO
.

include
ZEDR09_036_PAI
.



INITIALIZATION.




*  IF S_ZCODE IS INITIAL.

*    MESSAGE '##### #### ####' TYPE 'I'.

*    EXIT.

*  ENDIF.






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