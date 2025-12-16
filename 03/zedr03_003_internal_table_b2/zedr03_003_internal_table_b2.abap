
*&---------------------------------------------------------------------*

*& Report ZEDR03_003_INTERNAL_TABLE_B2

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_003_INTERNAL_TABLE_B2.



DATA : BEGIN OF GS_STUDENT, "### ##

  ZPERNR TYPE ZEDT03_001-ZPERNR,

  ZCODE TYPE ZEDT03_001-ZCODE,

  ZKNAME TYPE ZEDT03_001-ZKNAME,

  ZENAME TYPE ZEDT03_001-ZENAME,

  ZGENDER TYPE ZEDT03_001-ZGENDER,

  ZTEL TYPE ZEDT03_001-ZTEL,

  ZMNAME TYPE ZEDT03_002-ZMNAME,

  END OF GS_STUDENT.



  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



  GS_STUDENT-ZCODE = 'SSU-03'.

  GS_STUDENT-ZPERNR = '0000000001'.

  GS_STUDENT-ZKNAME = '##'.

  GS_STUDENT-ZENAME = 'JISOO'.

  GS_STUDENT-ZGENDER = 'W'.

  GS_STUDENT-ZTEL = '01088888888'.

  GS_STUDENT-ZMNAME = '#######'.







 APPEND GS_STUDENT TO GT_STUDENT.



   BREAK-POINT.