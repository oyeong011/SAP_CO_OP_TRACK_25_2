
*&---------------------------------------------------------------------*

*& Report ZEDR12_15

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_017.

DATA: GS_ZEDS12 TYPE ZEDS12_001.



GS_ZEDS12-ZCODE = 'SSU-01'.

GS_ZEDS12-ZKNAME = '###'.

GS_ZEDS12-ZENAME = 'KANG'.

GS_ZEDS12-ZGENDER = 'M'.

GS_ZEDS12-ZTEL = '01012345678'.



WRITE:/ GS_ZEDS12-ZCODE.

  WRITE:/ GS_ZEDS12-ZKNAME.

  WRITE:/ GS_ZEDS12-ZENAME.

  WRITE:/ GS_ZEDS12-ZGENDER.

  WRITE:/ GS_ZEDS12-ZTEL.