
*&---------------------------------------------------------------------*

*& Report ZEDR06_034_CLASS_EVENT

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_034_CLASS_EVENT MESSAGE-ID ZMED06.



include
ZEDR06_034_CLASS_EVENT_CLS
.

include
ZEDR06_034_CLASS_EVENT_TOP
.

include
ZEDR06_034_CLASS_EVENT_F01
.

include
ZEDR06_034_CLASS_EVENT_PBO
.

include
ZEDR06_034_CLASS_EVENT_PAI
.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

  ENDIF.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########