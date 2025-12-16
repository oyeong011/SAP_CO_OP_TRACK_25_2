
*&---------------------------------------------------------------------*

*& Report ZEDR24_010_LOOP

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_010_LOOP.



"--------------------------------------------------

"1. DO ~ ENDDO

DATA : LV_SUM TYPE I VALUE 0,

       LV_NUM TYPE I VALUE 5.



DO LV_NUM TIMES.

  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.

ENDDO.



WRITE :/ 'INDEX ## : ', LV_SUM.



WRITE :/ '----------------------------------'.

WRITE :/.



"--------------------------------------------------

"1-1. DO ~ ENDDO - EXIT (C## BREAK)

DO LV_NUM TIMES.

  IF SY-INDEX = 3.

    EXIT.

  ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.

ENDDO.



WRITE :/ 'INDEX ## : ', LV_SUM.



WRITE :/ '----------------------------------'.

WRITE :/.



"--------------------------------------------------

"1-2. DO ~ ENDDO - STOP (C## EXIT)

DO LV_NUM TIMES.

  IF SY-INDEX = 3.

    "STOP.

  ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.

ENDDO.



WRITE :/ 'INDEX ## : ', LV_SUM.



WRITE :/ '----------------------------------'.

WRITE :/.



"--------------------------------------------------

"1-3. DO ~ ENDDO - CONTINUE

DO LV_NUM TIMES.

  IF SY-INDEX = 3.

    CONTINUE.

  ENDIF.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.

ENDDO.



WRITE :/ 'INDEX ## : ', LV_SUM.



WRITE :/ '----------------------------------'.

WRITE :/.



"--------------------------------------------------

"1-4. DO ~ ENDDO - CHECK - ## #### ### ##

DO LV_NUM TIMES.



  CHECK SY-INDEX = 3.



  ADD SY-INDEX TO LV_SUM.

  WRITE :/ SY-INDEX.

ENDDO.



WRITE :/ 'INDEX ## : ', LV_SUM.



WRITE :/ '----------------------------------'.

WRITE :/.



"--------------------------------------------------

"2. WHILE ~ ENDWHILE



DATA : GV_WHILE_NUM TYPE I,

       GV_CHECK TYPE C.



GV_WHILE_NUM = 5.



WHILE GV_WHILE_NUM = 5.

  GV_CHECK = 'X'.

ENDWHILE.



IF GV_CHECK = 'X'.

  WRITE :/ '#######.'.

ENDIF.