
*&---------------------------------------------------------------------*

*& Report ZEDR12_DO_4

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DO_4.

DATA: GV_DATA1(8) VALUE 'ABCDEFGH',

      GV_DATA2(8),

      GV_DATA3(8).



DATA: GV_START TYPE I VALUE 2,

      GV_LENGTH TYPE I VALUE 4.



MOVE GV_DATA1+2(3) TO GV_DATA2.  "CDE

MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA3.   "CDEF



WRITE:/ GV_DATA2.

WRITE:/ GV_DATA3.