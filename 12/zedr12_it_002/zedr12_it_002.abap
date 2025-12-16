
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_2

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_002.



DATA: BEGIN OF GS_STUDENT, "### ##

  ZPERNR TYPE ZEDT12_001-ZPERNR, "####

  ZCODE TYPE ZEDT12_001-ZCODE, "####

  ZKNAME TYPE ZEDT12_001-ZKNAME, "##

  ZENAME TYPE ZEDT12_001-ZENAME, "####

  ZGENDER TYPE ZEDT12_001-ZGENDER, "##

  ZTEL TYPE ZEDT12_001-ZTEL, "####

  ZMNAME TYPE ZEDT12_002-ZMNAME, "##

  END OF GS_STUDENT.



  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT. "###### ##



GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01011111111'.  "HEADER(###)# ### ##.

GS_STUDENT-ZMNAME = '####'.



APPEND GS_STUDENT TO GT_STUDENT.