
*&---------------------------------------------------------------------*

*& Report ZEDR02_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_013.



"DO-ENDDO ##




*DATA : LV_NUM TYPE I.

*DATA: LV_SUM TYPE I.

*

*LV_NUM = 5.

*

*DO LV_NUM TIMES.

*

**  IF SY-INDEX = '3'.

**    "EXIT. "### ##

**    "STOP. "#### ##

**    CONTINUE. "## ### #### ###

**  ENDIF.

*

*  CHECK SY-INDEX = '3'. "### ### ### ##

*

*  ADD SY-INDEX TO LV_SUM.

*  WRITE: / SY-INDEX.

*ENDDO.

*

*WRITE: / 'INDEX ##: ', LV_SUM.






"WHILE-ENDWHILE ##

DATA: GV_NUM TYPE I.

DATA : GV_CHECK TYPE C.



GV_NUM = 0.

GV_CHECK = 'Y'.



WHILE GV_NUM < 5.

  GV_CHECK = 'X'.

  GV_NUM = GV_NUM + 1.

ENDWHILE.



IF GV_CHECK = 'X'.

  WRITE: / '#######.', GV_NUM.

ENDIF.