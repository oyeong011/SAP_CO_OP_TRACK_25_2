
*&---------------------------------------------------------------------*

*& Report ZEDR03_004_LINES

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_004_LINES.



DATA : BEGIN OF GS_LINE,

  COL1 TYPE C,

  END OF GS_LINE.



DATA : GT_LINE LIKE TABLE OF GS_LINE.



DATA : GV_LINE TYPE I.



  GS_LINE-COL1 = SY-INDEX.

  APPEND GS_LINE TO GT_LINE.



  GS_LINE-COL1 = SY-INDEX.

  APPEND GS_LINE TO GT_LINE.



  GS_LINE-COL1 = SY-INDEX.

  APPEND GS_LINE TO GT_LINE.



 DESCRIBE TABLE GT_LINE LINES GV_LINE.



BREAK-POINT.



 WRITE GV_LINE.