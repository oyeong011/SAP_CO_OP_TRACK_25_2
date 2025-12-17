
*&---------------------------------------------------------------------*

*& Report ZEDR19_12

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_13.




* Global Data Type in ABAP Dictionary






DATA : BEGIN OF GS_ZEDT19,

  ZCODE19 TYPE ZEDT19_001-ZCODE19,

  ZKNAME19 TYPE ZEDT19_001-ZKNAME19,

  ZENAME19 TYPE ZEDT19_001-ZENAME19,

  ZGUBUN19 TYPE ZEDT19_001-ZGUBUN19,

  ZTEL19 TYPE ZEDT19_001-ZTEL19,

  END OF GS_ZEDT19.



GS_ZEDT19-ZCODE19 = 'SSU-19'.

GS_ZEDT19-ZKNAME19 = '###'.

GS_ZEDT19-ZENAME19 = 'MIN'.

GS_ZEDT19-ZTEL19 = '01020562942'.



WRITE :/ GS_ZEDT19-ZCODE19.

WRITE :/ GS_ZEDT19-ZKNAME19.

WRITE :/ GS_ZEDT19-ZENAME19.

WRITE :/ GS_ZEDT19-ZGUBUN19.

WRITE :/ GS_ZEDT19-ZTEL19.