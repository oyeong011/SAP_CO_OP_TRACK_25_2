
*&---------------------------------------------------------------------*

*& Report ZEDR14_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_013.



"ITAB ##



"DO ~ ENDDO

DATA : LV_NUM TYPE I,

       LV_SUM TYPE I.



LV_NUM = 5.



DO LV_NUM TIMES.



  IF SY-INDEX = '3'.

    EXIT.




*    STOP.

*    CONTINUE.

*    CHECK SY-INDEX = '3'.




  ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX ##:', LV_SUM.






*&---------------------------------------------------------------------*




"WHILE ~ ENDWHILE

DATA : GV_NUM TYPE I,

       GV_CHECK TYPE C.



GV_NUM = 1.



WHILE GV_NUM < 5.

  GV_CHECK = 'X'.

  GV_NUM = GV_NUM + 1.

ENDWHILE.



IF GV_CHECK = 'X'.

  WRITE :/ '#######'.

ENDIF.