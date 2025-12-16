
*&---------------------------------------------------------------------*

*& Report ZEDR06_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_012.



DATA : LV_NUM TYPE I.

DATA : LV_SUM TYPE I.



LV_NUM = 5.



DO LV_NUM TIMES.

  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.

ENDDO.



WRITE :/ 'INDEX ## ', LV_SUM.








*&---------------------------------------------------------------------*




LV_NUM = 5.

LV_SUM = 0.



DO LV_NUM TIMES.



  IF SY-SUBRC = '3'.

    EXIT. " STOP , CONTINUE.

  ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX ## ', LV_SUM.






*&---------------------------------------------------------------------*






LV_NUM = 5.

LV_SUM = 0.



DO LV_NUM TIMES.



  CHECK SY-INDEX = '3'.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX ## ', LV_SUM.






*&---------------------------------------------------------------------*






DATA : GV_NUM TYPE I.

DATA : GV_CHECK TYPE C.



GV_NUM = 5.



WHILE GV_NUM = 5.

  GV_CHECK = 'X'.

  GV_NUM = 3.

ENDWHILE.



IF GV_CHECK = 'X'.

  WRITE :/ '#######.'.

ENDIF.