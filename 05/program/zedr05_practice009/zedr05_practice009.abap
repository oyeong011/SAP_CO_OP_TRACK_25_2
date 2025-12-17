
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_PRACTICE009 MESSAGE-ID ZEDM05.





include
ZEDR05_PRACTICE009_TOP
.

include
ZEDR05_PRACTICE009_SCR
.

include
ZEDR05_PRACTICE009_F01
.

include
ZEDR05_PRACTICE009_PBO
.

include
ZEDR05_PRACTICE009_PAI
.





INITIALIZATION.

  PERFORM SET_DATE.



START-OF-SELECTION.

  PERFORM CHECK_DATA.



  PERFORM GET_DATA.

  PERFORM CONVERT_DATA.



  IF GT_EMP[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######

* T100 --> #######