
*&---------------------------------------------------------------------*

*& Report ZEDR19_15

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_15.

DATA : GS_ZEDS19 TYPE ZEDS19_001.



GS_ZEDS19-ZCODE = 'SSU-19'.

GS_ZEDS19-ZKNAME = '###'.

GS_ZEDS19-ZENAME = 'MIN'.

GS_ZEDS19-ZGENDER = 'F'.

GS_ZEDS19-ZTEL = '01020562942'.



WRITE :/ GS_ZEDS19-ZCODE.

WRITE :/ GS_ZEDS19-ZKNAME.

WRITE :/ GS_ZEDS19-ZENAME.

WRITE :/ GS_ZEDS19-ZGENDER.

WRITE :/ GS_ZEDS19-ZTEL.