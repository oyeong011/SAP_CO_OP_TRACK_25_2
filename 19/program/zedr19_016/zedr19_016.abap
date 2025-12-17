
*&---------------------------------------------------------------------*

*& Report ZEDR19_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_016.



"DATA ####

DATA : BEGIN OF GS_ZEDT19, "#### ###

    ZCODE TYPE C LENGTH 10,

    ZKNAME TYPE C LENGTH 20,

    ZENAME TYPE C LENGTH 20,

    END OF GS_ZEDT19.



DATA : BEGIN OF GS_ZEDT19_2. "#### ###+####

  INCLUDE STRUCTURE GS_ZEDT19.

  DATA : TITLE TYPE C LENGTH 10,

             GRADE TYPE C LENGTH 1,

  END OF GS_ZEDT19_2.



GS_ZEDT19_2-ZCODE = 'SSU-19'.

GS_ZEDT19_2-ZKNAME = '###'.

GS_ZEDT19_2-ZENAME = 'MIN'.

GS_ZEDT19_2-TITLE = 'AI'.

GS_ZEDT19_2-GRADE = '3'.



WRITE :/ GS_ZEDT19_2-ZCODE.

WRITE :/ GS_ZEDT19_2-ZKNAME.

WRITE :/ GS_ZEDT19_2-ZENAME.

WRITE :/ GS_ZEDT19_2-TITLE.

WRITE :/ GS_ZEDT19_2-GRADE.