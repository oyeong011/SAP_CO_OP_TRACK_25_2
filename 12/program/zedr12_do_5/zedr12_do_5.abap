
*&---------------------------------------------------------------------*

*& Report ZEDR12_DO_5

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DO_5.

DATA: GV_DATA1(8) VALUE 'ABCDEFGH',

      GV_DATA2(8) VALUE 'IJKLMNOP'.



DATA: GV_START TYPE I VALUE 2,

      GV_LENGTH TYPE I VALUE 4.



MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA2+GV_START(GV_LENGTH).   "IJCDEFOP



WRITE:/ GV_DATA2.