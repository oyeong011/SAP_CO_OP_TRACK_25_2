
*&---------------------------------------------------------------------*

*& Report ZEDR12_14

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_016.

DATA: BEGIN OF GS_ZEDT12,

  ZCODE TYPE ZCODE12,

  ZKNAME TYPE ZKNAME12,

  ZENAME TYPE ZENAME12,

  ZGENDER TYPE ZGENDER12,

  ZTEL TYPE ZTEL12,

  END OF GS_ZEDT12.



  GS_ZEDT12-ZCODE = 'SSU-01'.

  GS_ZEDT12-ZKNAME = '###'.

  GS_ZEDT12-ZENAME = 'KANG'.

  GS_ZEDT12-ZGENDER = 'M'.

  GS_ZEDT12-ZTEL = '123456789'.



  WRITE:/ GS_ZEDT12-ZCODE.

  WRITE:/ GS_ZEDT12-ZKNAME.

  WRITE:/ GS_ZEDT12-ZENAME.

  WRITE:/ GS_ZEDT12-ZGENDER.

  WRITE:/ GS_ZEDT12-ZTEL.