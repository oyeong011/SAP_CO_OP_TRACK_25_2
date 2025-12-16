
*&---------------------------------------------------------------------*

*& Report ZEDR15_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_013.



"1. DO ~ ENDDO : ## ### ### #### ##### # # ##




*DATA : LV_NUM TYPE I.

*DATA : LV_SUM TYPE I.

*

*LV_NUM = 5.

*

*DO LV_NUM TIMES.

*

*  CHECK SY-INDEX = '3'. "CHECK## ###### ## #### # #### ##

*

**  IF SY-INDEX = '3'.

**    EXIT. "EXIT## ## #### ##

**    STOP. "STOP## ## #### ##

**    CONTINUE. "CONTINUE## ## # ### #### ####

**  ENDIF.

*

*  ADD SY-INDEX TO LV_SUM.

*  WRITE:/ SY-INDEX.

*ENDDO.

*

*WRITE : / 'INDEX##:', LV_SUM.






"2. WHILE ~ ENDWHILE : LOGICAL EXPRESSION# #### # ## ## ## #### ##



DATA : GV_NUM TYPE I.

DATA : GV_CHECK TYPE C.



GV_NUM = 5.



WHILE GV_NUM = 5.

  GV_CHECK = 'X'.

ENDWHILE.



IF GV_CHECK = 'X'.

  WRITE :/ '#######.'.

ENDIF.