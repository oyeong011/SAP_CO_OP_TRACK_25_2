
*&---------------------------------------------------------------------*

*& Report ZEDR08_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_011.



DATA : LV_NUM TYPE I.

DATA : LV_SUM TYPE I.



LV_NUM = 5.



DO LV_NUM TIMES.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX ##: ', LV_SUM.



"------------------------------------------------------------



DATA : LV_NUM1 TYPE I.

DATA : LV_SUM1 TYPE I.



LV_NUM1 = 5.



DO LV_NUM1 TIMES.



  IF SY-INDEX = '3'.

    EXIT.

  ENDIF.



  ADD SY-INDEX TO LV_SUM1.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX##:', LV_SUM1.



"------------------------------------------------------------



DATA : LV_NUM3 TYPE I.

DATA : LV_SUM3 TYPE I.



LV_NUM = 5.



DO LV_NUM3 TIMES.



  IF SY-INDEX = '3'.

    CONTINUE.

  ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX##: ', LV_SUM.



"------------------------------------------------------------



DATA : LV_NUM4 TYPE I.

DATA : LV_SUM4 TYPE I.



LV_NUM4 = 5.



DO LV_NUM4 TIMES.



  CHECK SY-INDEX = '3'.

  ADD SY-INDEX TO LV_SUM4.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX##: ', LV_SUM4.



"------------------------------------------------------------



" DATA : GV_NUM5 TYPE I.

" DATA : GV_CHECK TYPE C.



" GV_NUM5 = 5.



" WHILE GV_NUM5 = 5.

"  GV_CHECK = 'X'.

" ENDWHILE.



" IF GV_CHECK = 'X'.

"  WRITE :/ '#######.'.

" ENDIF.



"------------------------------------------------------------



DATA : LV_NUM2 TYPE I.

DATA : LV_SUM2 TYPE I.



LV_NUM2 = 5.



DO LV_NUM2 TIMES.



  IF SY-INDEX = '3'.

    STOP.

  ENDIF.



  ADD SY-INDEX TO LV_SUM2.

  WRITE :/ SY-INDEX.



ENDDO.



WRITE :/ 'INDEX##: ', LV_SUM.



"------------------------------------------------------------