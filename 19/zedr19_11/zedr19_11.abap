
*&---------------------------------------------------------------------*

*& Report ZEDR19_11

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_11.




* Global Data Type in ABAP Dictionary






DATA : GS_ZEDT19 TYPE ZEDT19_001.



GS_ZEDT19-ZCODE19 = 'SSU-19'.

GS_ZEDT19-ZKNAME19 = '###'.

GS_ZEDT19-ZENAME19 = 'MIN'.

GS_ZEDT19-ZGUBUN19 = 'F'.

GS_ZEDT19-ZTEL19 = '01020562942'.



WRITE :/ GS_ZEDT19-ZCODE19.

WRITE :/ GS_ZEDT19-ZKNAME19.

WRITE :/ GS_ZEDT19-ZENAME19.

WRITE :/ GS_ZEDT19-ZGUBUN19.

WRITE :/ GS_ZEDT19-ZTEL19.