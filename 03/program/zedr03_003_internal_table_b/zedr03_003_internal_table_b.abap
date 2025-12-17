
*&---------------------------------------------------------------------*

*& Report ZEDR03_003_INTERNAL_TABLE_B

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_003_INTERNAL_TABLE_B.





DATA : GS_ZEDT03 TYPE ZEDT03_001.

DATA : GT_ZEDT03 TYPE TABLE OF ZEDT03_001.



GS_ZEDT03-ZCODE = 'SSU-03'.

GS_ZEDT03-ZPERNR = '0000000003'.

GS_ZEDT03-ZKNAME = '##'.

GS_ZEDT03-ZENAME = 'JISOO'.

GS_ZEDT03-ZGENDER = 'W'.

GS_ZEDT03-ZTEL = '01088888888'.



APPEND GS_ZEDT03 TO GT_ZEDT03.



GS_ZEDT03-ZCODE = 'SSU-04'.

GS_ZEDT03-ZPERNR = '0000000004'.

GS_ZEDT03-ZKNAME = '##'.

GS_ZEDT03-ZENAME = 'LANA'.

GS_ZEDT03-ZGENDER = 'W'.

GS_ZEDT03-ZTEL = '01078888888'.



APPEND GS_ZEDT03 TO GT_ZEDT03.



BREAK-POINT.