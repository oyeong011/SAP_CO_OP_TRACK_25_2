
*&---------------------------------------------------------------------*

*& Report ZEDR19_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_014.



"### TYPE##

TYPES: BEGIN OF T_ZEDT19,          "#### ###

         ZCODE  TYPE C LENGTH 10,

         ZKNAME TYPE C LENGTH 20,

         ZENAME TYPE C LENGTH 20,

       END OF T_ZEDT19.



TYPES : BEGIN OF T_ZEDT19_2. "#### ###+####

  INCLUDE TYPE T_ZEDT19.

  TYPES : TITLE TYPE C LENGTH 10,

                GRADE TYPE C LENGTH 1,

  END OF T_ZEDT19_2.



" ### ####

DATA : GS_ZEDT19 TYPE T_ZEDT19_2.



GS_ZEDT19-ZCODE = 'SSU-19'.

GS_ZEDT19-ZKNAME = '###'.

GS_ZEDT19-ZENAME = 'MIN'.

GS_ZEDT19-TITLE = 'AI'.

GS_ZEDT19-GRADE = '3'.



WRITE :/ GS_ZEDT19-ZCODE.

WRITE :/ GS_ZEDT19-ZKNAME.

WRITE :/ GS_ZEDT19-ZENAME.

WRITE :/ GS_ZEDT19-TITLE.

WRITE :/ GS_ZEDT19-GRADE.