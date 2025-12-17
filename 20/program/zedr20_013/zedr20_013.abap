
*&---------------------------------------------------------------------*

*& Report ZEDR20_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_013.






*DATA: LV_SUM TYPE I,

*      LV_NUM TYPE I.

*LV_NUM = 5.

*

*DO LV_NUM TIMES.

**  IF SY-INDEX = 3.

***    EXIT.

***    STOP.

**    CONTINUE.

**  ENDIF.

*

*  CHECK SY-INDEX = 3.

*

*  ADD SY-INDEX TO LV_SUM.

*  WRITE:/ SY-INDEX.

*ENDDO.

*

*DATA: GV_NUM TYPE I,

*      GV_CHECK.

*GV_NUM = 5.

*

*WHILE GV_NUM = 5.

*  GV_CHECK = 'X'.

*ENDWHILE.

*

*IF GV_CHECK = 'X'.

*  WRITE:/ '#######.'.

*ENDIF.

*

*WRITE:/ 'INDEX ##: ', LV_SUM.