
*&---------------------------------------------------------------------*

*& Report ZEDR03_002_DATA_TYPE

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_002_DATA_TYPE.



DATA : GS_ZEDS03 TYPE ZEDS03_001.



GS_ZEDS03-ZCODE = 'SSU-03'.

GS_ZEDS03-ZKNAME = '###'.

GS_ZEDS03-ZENAME = 'Taylor'.

GS_ZEDS03-ZGENDER = 'W'.

GS_ZEDS03-ZTEL = '01088888888'.



WRITE /  GS_ZEDS03-ZCODE.

WRITE /  GS_ZEDS03-ZKNAME.

WRITE /  GS_ZEDS03-ZENAME.

WRITE /  GS_ZEDS03-ZGENDER.

WRITE /  GS_ZEDS03-ZTEL.