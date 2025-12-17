
*&---------------------------------------------------------------------*

*& Report ZEDR19_22

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_22.



DATA : GV_DATA1 VALUE 'ABCDEFGH',

      GV_DATA2(8).

DATA : GV_START TYPE I VALUE 2,

      GV_LENGTH TYPE I VALUE 4.



MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA2.

WRITE :/ GV_DATA2.