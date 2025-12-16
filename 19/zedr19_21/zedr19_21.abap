
*&---------------------------------------------------------------------*

*& Report ZEDR19_21

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_21.



DATA : GV_DATA1(8) VALUE 'ABCDEFGH',

  GV_DATA2(8).

DATA : GV_START TYPE I VALUE 2,

      GV_LENGTH TYPE I VALUE 4.



MOVE GV_DATA1+2(3) TO GV_DATA2.

WRITE :/ GV_DATA2.