
*&---------------------------------------------------------------------*

*& Report ZEDR14_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_004.






*### ## -> ###### ##




DATA : GS_ZEDT14 TYPE ZEDT14_001.   "### ##

DATA : GT_ZEDT14 TYPE TABLE OF ZEDT14_001.      "###### ##



GS_ZEDT14-ZCODE = 'SSU-01'.

GS_ZEDT14-ZPERNR = '0000000001'.

GS_ZEDT14-ZKNAME = '###'.

GS_ZEDT14-ZENAME = 'KANG'.

GS_ZEDT14-ZGENDER = 'M'.

GS_ZEDT14-ZTEL = '01011112222'.



APPEND GS_ZEDT14 TO GT_ZEDT14.



GS_ZEDT14-ZCODE = 'SSU-02'.

GS_ZEDT14-ZPERNR = '0000000002'.

GS_ZEDT14-ZKNAME = '##'.

GS_ZEDT14-ZENAME = 'JENNY'.

GS_ZEDT14-ZGENDER = 'F'.

GS_ZEDT14-ZTEL = '01022223333'.



APPEND GS_ZEDT14 TO GT_ZEDT14.






*&---------------------------------------------------------------------*



*##### ## ###### ##




DATA : BEGIN OF GS_STUDENT,

  ZPERNR TYPE ZEDT14_001-ZPERNR,

  ZCODE TYPE ZEDT14_001-ZCODE,

  ZKNAME TYPE ZEDT14_001-ZKNAME,

  ZENAME TYPE ZEDT14_001-ZENAME,

  ZGENDER TYPE ZEDT14_001-ZGENDER,

  ZTEL TYPE ZEDT14_001-ZTEL,

  END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZPERNR = '0000000002'.

GS_STUDENT-ZKNAME = '##'.

GS_STUDENT-ZENAME = 'JENNY'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01022223333'.



APPEND GS_STUDENT TO GT_STUDENT.



BREAK-POINT.