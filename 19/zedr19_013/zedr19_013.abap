
*&---------------------------------------------------------------------*

*& Report ZEDR19_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_013.



"### TYPE ##



TYPES : BEGIN OF T_ZEDT19, "#### ###

    ZCODE TYPE C LENGTH 10,

    ZKNAME TYPE C LENGTH 20,

    ZENAME TYPE C LENGTH 20,

    END OF T_ZEDT19.



"### ####

DATA : GS_ZEDT19 TYPE T_ZEDT19.



GS_ZEDT19-ZCODE = 'SSU-19'.

GS_ZEDT19-ZKNAME = '###'.

GS_ZEDT19-ZENAME = 'MIN'.



WRITE :/ GS_ZEDT19-ZCODE.

WRITE :/ GS_ZEDT19-ZKNAME.

WRITE :/ GS_ZEDT19-ZENAME.