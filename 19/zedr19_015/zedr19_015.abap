
*&---------------------------------------------------------------------*

*& Report ZEDR19_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_015.



"DATA ####

DATA : BEGIN OF GS_ZEDT19, "#### ###

    ZCODE TYPE C LENGTH 10,

    ZKNAME TYPE C LENGTH 20,

    ZENAME TYPE C LENGTH 20,

    END OF GS_ZEDT19.



GS_ZEDT19-ZCODE = 'SSU-19'.

GS_ZEDT19-ZKNAME = '###'.

GS_ZEDT19-ZENAME = 'MIN'.



WRITE :/ GS_ZEDT19-ZCODE.

WRITE :/ GS_ZEDT19-ZKNAME.

WRITE :/ GS_ZEDT19-ZENAME.