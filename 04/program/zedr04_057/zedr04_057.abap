
*&---------------------------------------------------------------------*

*& Report ZEDR04_057

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_057.



DATA LV_NUM TYPE I.

DATA LV_SUM TYPE I.

DATA LV_CHECK TYPE C.



LV_NUM = 5.



" 1. DO ~ ENDDO ## ##

DO LV_NUM TIMES.

  ADD SY-INDEX TO LV_SUM.

  WRITE / SY-INDEX.

ENDDO.

WRITE : /'INDEX##: ',LV_SUM.



" 2. EXIT, STOP, CONTINUE

LV_SUM = 0.

DO LV_NUM TIMES.

  IF SY-INDEX = '3'.

    EXIT.     " ### ###




*    STOP.     " #### ##

*    CONTINUE. " ENDIF# ## ## ## ##




  ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE / SY-INDEX.

ENDDO.

WRITE : /'INDEX##: ',LV_SUM.



" 3. CHECK

LV_SUM = 0.

DO LV_NUM TIMES.

  CHECK SY-INDEX = '3'. " ### ## ## ## ## ##



  ADD SY-INDEX TO LV_SUM.

  WRITE / SY-INDEX.

ENDDO.

WRITE : /'INDEX##: ',LV_SUM.






*" WHILE ~ ENDWHILE ## ## (## : ####)

*WHILE LV_NUM = 5.

*  LV_CHECK = 'X'.

*ENDWHILE.

*

*IF LV_CHECK = 'X'.

*  WRITE / '#######.'.

*ENDIF.