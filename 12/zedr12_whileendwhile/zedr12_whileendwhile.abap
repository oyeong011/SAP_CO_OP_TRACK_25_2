
*&---------------------------------------------------------------------*

*& Report ZEDR12_WHILEENDWHILE

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_WHILEENDWHILE.

DATA: GV_NUM TYPE I.

DATA: GV_CHECK TYPE C.



GV_NUM = 5.



WHILE GV_NUM = 5.

  GV_CHECK = 'X'.

ENDWHILE.



IF GV_CHECK = 'X'.

  WRITE: '###.'.

ENDIF.