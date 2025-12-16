
*&---------------------------------------------------------------------*

*& Report ZEDR022_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_001.



"DATA## ##

DATA : BEGIN OF GS_ZEDT22, "#### ###

   ZCODE TYPE C LENGTH 10,

   ZKNAME TYPE C LENGTH 20,

   ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT22.



DATA : BEGIN OF GS_ZEDT22_2. "#### ###+####

   INCLUDE STRUCTURE GS_ZEDT22.

   DATA : TITLE TYPE C LENGTH 10,

          GRADE TYPE C LENGTH 1,

   END OF GS_ZEDT22_2.



GS_ZEDT22-ZCODE = 'SSU_01'.

GS_ZEDT22-ZKNAME = '###'.

GS_ZEDT22-ZENAME = 'DONG'.

GS_ZEDT22_2-TITLE = '####'.

GS_ZEDT22_2-GRADE = '3'.



WRITE : / GS_ZEDT22-ZCODE.

WRITE : / GS_ZEDT22-ZKNAME.

WRITE : / GS_ZEDT22-ZENAME.

WRITE : / GS_ZEDT22_2-TITLE.

WRITE : / GS_ZEDT22_2-GRADE.