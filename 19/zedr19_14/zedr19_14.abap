
*&---------------------------------------------------------------------*

*& Report ZEDR19_14

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_14.

DATA : BEGIN OF GS_ZEDT19,

  ZCODE19 TYPE ZCODE19,

  ZKNAME19 TYPE ZKNAME19,

  ZENAME19 TYPE ZENAME19,

  ZGUBUN19 TYPE ZGUBUN19,

  ZTEL19 TYPE ZTEL19,

  END OF GS_ZEDT19.



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