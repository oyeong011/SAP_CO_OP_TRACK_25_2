
*&---------------------------------------------------------------------*

*& Report ZEDR03_003_INTERTABLE_ASSIGN2

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_003_INTERTABLE_ASSIGN2.



DATA : BEGIN OF GS_STUDENT,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

  END OF GS_STUDENT.



  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



  GS_STUDENT-ZCODE = 'SSU-03'.

  GS_STUDENT-ZKNAME = '##'.

  GS_STUDENT-ZENAME = 'JISOO'.



  APPEND GS_STUDENT TO GT_STUDENT.



  BREAK-POINT.



  CLEAR : GT_STUDENT.



  BREAK-POINT.