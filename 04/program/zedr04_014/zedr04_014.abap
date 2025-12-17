
*&---------------------------------------------------------------------*

*& Report ZEDR04_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_014.



" 1. NESTED ## ## -> ### ## ##

TYPES : BEGIN OF T_ZEDT04,          " ### ## ##

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT04.



TYPES : BEGIN OF T_ZEDT04_2.        " NESTED ## ##

  INCLUDE TYPE T_ZEDT04.              " #######

  TYPES : TITLE TYPE C LENGTH 10,     " + ####

          GRADE TYPE C LENGTH 1,

  END OF T_ZEDT04_2.



DATA GS_ZEDT04_2 TYPE T_ZEDT04_2.     " ### ## ##



" 2. ## ### ## ##




*DATA : BEGIN OF GS_ZEDT04,          " ### ## ##

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 20,

*  ZENAME TYPE C LENGTH 20,

*  END OF GS_ZEDT04.

*

*DATA : BEGIN OF GS_ZEDT04_2.        " NESTED ### ### ## ##

*  INCLUDE STRUCTURE GS_ZEDT04.

*  DATA : TITLE TYPE C LENGTH 10,

*          GRADE TYPE C LENGTH 1,

*  END OF GS_ZEDT04_2.






GS_ZEDT04_2-ZCODE = 'SSU-04'.

GS_ZEDT04_2-ZKNAME = '###'.

GS_ZEDT04_2-ZENAME = 'KOO'.

GS_ZEDT04_2-TITLE = '#####'.

GS_ZEDT04_2-GRADE = '3'.



WRITE / GS_ZEDT04_2-ZCODE.

WRITE / GS_ZEDT04_2-ZKNAME.

WRITE / GS_ZEDT04_2-ZENAME.

WRITE / GS_ZEDT04_2-TITLE.

WRITE / GS_ZEDT04_2-GRADE.