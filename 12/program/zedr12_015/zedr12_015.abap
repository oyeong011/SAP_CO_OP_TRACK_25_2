
*&---------------------------------------------------------------------*

*& Report ZEDR12_13

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_015.

DATA: BEGIN OF GS_ZEDT12,

  ZCODE TYPE ZEDT12_001-ZCODE,

  ZKNAME TYPE ZEDT12_001-ZKNAME,

  ZENAME TYPE ZEDT12_001-ZENAME,

  ZTEL TYPE ZEDT12_001-ZTEL,

  END OF GS_ZEDT12.



  GS_ZEDT12-ZCODE = 'SSU-01'.

  GS_ZEDT12-ZKNAME = '###'.

  GS_ZEDT12-ZENAME = 'KANG'.



  GS_ZEDT12-ZTEL = '123456789'.



  WRITE:/ GS_ZEDT12-ZCODE.

  WRITE:/ GS_ZEDT12-ZKNAME.

  WRITE:/ GS_ZEDT12-ZENAME.



  WRITE:/ GS_ZEDT12-ZTEL.