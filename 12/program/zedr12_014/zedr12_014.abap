
*&---------------------------------------------------------------------*

*& Report ZEDR12_12

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_014.

DATA: GS_ZEDT12 TYPE ZEDT12_001.



GS_ZEDT12-ZCODE = 'SSU-01'.

GS_ZEDT12-ZKNAME = '###'.

GS_ZEDT12-ZENAME = 'KANG'.

GS_ZEDT12-ZTEL = '01012345678'.



WRITE:/ GS_ZEDT12-ZCODE.

WRITE:/ GS_ZEDT12-ZKNAME.

WRITE:/ GS_ZEDT12-ZENAME.

WRITE:/ GS_ZEDT12-ZTEL.