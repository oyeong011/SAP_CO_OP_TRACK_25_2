
*&---------------------------------------------------------------------*

*& Report ZEDR19_16

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_16.

DATA : GS_ZEDG19 TYPE ZTG19_ZED19.

DATA : GS_ZTITLE TYPE ZTG19_ZTITLE.



GS_ZEDG19-ZCODE = 'SSU-01'.

GS_ZEDG19-ZKNAME = '###'.

GS_ZEDG19-ZENAME = 'MIN'.

GS_ZEDG19-ZTEL = '01020562942'.

GS_ZTITLE = 'AI'.



WRITE :/ GS_ZEDG19-ZCODE.

WRITE :/ GS_ZEDG19-ZKNAME.

WRITE :/ GS_ZEDG19-ZENAME.

WRITE :/ GS_ZEDG19-ZGENDER.

WRITE :/ GS_ZEDG19-ZTEL.

WRITE :/ GS_ZTITLE.