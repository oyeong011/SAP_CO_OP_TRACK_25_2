
*&---------------------------------------------------------------------*

*& Report ZEDR04_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_012.



" 1. ## ## -> ## ##

TYPES T_HELLO(20) TYPE C.   "### ####



DATA gv_text1 TYPE T_HELLO.   "1) ### ## ### ## ##

DATA gv_text2 LIKE gv_text1.  "2) ## ### ## ##



gv_text1 = '#####'.

gv_text2 = '#####'.



WRITE gv_text1.   "#####

WRITE / gv_text2. "#####

WRITE / '-----------------------------------------------'.



" 2. ### ## ## -> ## ##

TYPES : BEGIN OF T_ZEDT04,    " ### ## ##

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT04.



DATA GS_ZEDT04 TYPE T_ZEDT04.  " ### ## ##



" 3. ## ### ## ##




*DATA : BEGIN OF GS_ZEDT04,    " ## ### ## ##

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 20,

*  ZENAME TYPE C LENGTH 20,

*  END OF GS_ZEDT04.






GS_ZEDT04-ZCODE = 'SSU-04'.

GS_ZEDT04-ZKNAME = '###'.

GS_ZEDT04-ZENAME = 'KOO'.



WRITE / GS_ZEDT04-ZCODE.

WRITE / GS_ZEDT04-ZKNAME.

WRITE / GS_ZEDT04-ZENAME.