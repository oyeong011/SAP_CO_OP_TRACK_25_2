
*&---------------------------------------------------------------------*

*& Report ZEDR00_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR00_PRACTICE009 MESSAGE-ID ZMED00.



include
ZEDR00_PRACTICE009_TOP
.

include
ZEDR00_PRACTICE009_SCR
.

include
ZEDR00_PRACTICE009_F01
.

include
ZEDR00_PRACTICE009_PBO
.

include
ZEDR00_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_DATE.



START-OF-SELECTION.

  PERFORM CHECK_DATA.

  PERFORM PROGRESS_DISPLAY USING 'Data ## #...'. "### ### ##



  PERFORM SELECT_DATA.

  PERFORM MODIFY_DATA.



  IF GT_EMP[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######