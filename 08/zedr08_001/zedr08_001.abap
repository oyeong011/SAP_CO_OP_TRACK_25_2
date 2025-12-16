
*&---------------------------------------------------------------------*

*& Report ZEDR08_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_001.



DATA : gv_num1 TYPE p VALUE '1234'.

DATA : gv_num2 TYPE p DECIMALS 2 VALUE '12.34'.



DATA : gv_num3 TYPE i VALUE 1234.



DATA : gv_num4 TYPE n VALUE 1234.

DATA : gv_num5 TYPE n LENGTH 2 VALUE 1234.

DATA : gv_num6 TYPE n LENGTH 3 VALUE 1234.

DATA : gv_num7 TYPE n LENGTH 4 VALUE 1234.



WRITE : gv_num1.

WRITE :/ gv_num2.

WRITE :/ gv_num3.

WRITE :/ gv_num4.

WRITE :/ gv_num5.

WRITE :/ gv_num6.

WRITE :/ gv_num7.



"---------------------------------



DATA : GV_TEXT1 VALUE 'A'.

DATA : GV_TEXT2 LENGTH 3 TYPE C VALUE 'ABC'.

DATA : GV_TEXT3(5) TYPE C VALUE 'ABCDE'.

DATA : GV_TEXT4 TYPE STRING VALUE 'ABCDE'.

DATA : GV_LEN TYPE i.



DATA : GV_TIME TYPE T.



DATA : GV_DATE TYPE D.



GV_TIME = SY-UZEIT.

GV_DATE = SY-DATUM.

GV_LEN = STRLEN( GV_TEXT3 ).



WRITE : GV_TEXT1.

WRITE :/ GV_TEXT2.

WRITE :/ GV_TEXT3.

WRITE :/ GV_TEXT4.

WRITE :/ GV_LEN.

WRITE :/ GV_TIME.

WRITE :/ GV_DATE.



"------------------------------------



DATA : TEXT1 TYPE STRING,

       TEXT2(4) TYPE C.



TEXT1 = 'ABAP'.

TEXT2 = 'B'.



FIND TEXT2 IN TEXT1.



IF SY-SUBRC = 0.

  WRITE :/ TEXT2.

ENDIF.



"-------------------------------------



DATA : TEXT3 TYPE STRING,

       TEXT4(4) TYPE C.



TEXT3 = 'ABAP'.

TEXT4 = 'BBAP'.



REPLACE TEXT3 IN TEXT3 WITH TEXT4.

WRITE :/ TEXT3.



"-------------------------------------



DATA : TEXT5 TYPE STRING,

       TEXT6(4) TYPE C.



TEXT5 = 'ABAP'.

TEXT6 = 'abap'.



TRANSLATE TEXT5 TO LOWER CASE.

TRANSLATE TEXT6 TO UPPER CASE.

WRITE :/ TEXT5.

WRITE :/ TEXT6.



"--------------------------------------



DATA : TEXT7 TYPE STRING,

       TEXT8(5) TYPE C.



TEXT7 = ' ABAP'.

TEXT8 = ' ABAP'.



SHIFT TEXT7.

WRITE :/ TEXT7.

WRITE :/ TEXT8.



"-------------------------------------



DATA : TEXT9 TYPE STRING,

       TEXT10(8) TYPE C,

       TEXT11(8) TYPE C.



TEXT9 = 'AB   AP'.

TEXT10 = 'AB   AP'.

TEXT11 = 'AB   AP'.



CONDENSE TEXT9.

CONDENSE TEXT10 NO-GAPS.



"-----------------------------------



DATA : TEXT12 TYPE STRING,

       TEXT13(8) TYPE C.



TEXT12 = ' B P'.

TEXT13 = 'AAAA'.



OVERLAY TEXT12 WITH TEXT13.



WRITE :/ TEXT12.

WRITE :/ TEXT13.



"-----------------------------------



DATA : TEXT14 TYPE STRING,

       TEXT15(4) TYPE C,

       TEXT16(4) TYPE C.



TEXT14 = 'AB'.

TEXT15 = 'AP'.



CONCATENATE TEXT14 TEXT15 INTO TEXT16.



WRITE :/ TEXT14.

WRITE :/ TEXT15.

WRITE :/ TEXT16.



"-----------------------------------



DATA : TEXT17 TYPE STRING,

       TEXT18(4) TYPE C,

       TEXT19(4) TYPE C.



TEXT17 = 'AB+AP'.

SPLIT TEXT17 AT '+' INTO TEXT18 TEXT19.



WRITE :/ TEXT17.

WRITE :/ TEXT18.

WRITE :/ TEXT19.



"----------------------------------------------



DATA : gv_num8 TYPE i VALUE 5,

       gv_num9 TYPE i VALUE 3,

       gv_num10 TYPE i.



gv_num10 = gv_num8 + gv_num9.

WRITE :/ gv_num10.



gv_num10 = gv_num8 - gv_num9.

WRITE :/ gv_num10.



gv_num10 = gv_num8 * gv_num9.

WRITE :/ gv_num10.



gv_num10 = gv_num8 / gv_num9.

WRITE :/ gv_num10.



gv_num10 = gv_num8 DIV gv_num9.

WRITE :/ gv_num10.



gv_num10 = gv_num8 MOD gv_num9.

WRITE :/ gv_num10.



gv_num10 = gv_num8 ** gv_num9.

WRITE :/ gv_num10.



"----------------------------------------------



TYPES T_HELLO(20) TYPE C.



DATA GV_TEXT5 TYPE T_HELLO.

DATA GV_TEXT6 LIKE GV_TEXT5.



GV_TEXT5 = '#####'.

GV_TEXT6 = '#####'.



WRITE :/ GV_TEXT5.

WRITE :/ GV_TEXT6.



"---------------------------------------------



TYPES : BEGIN OF T_ZEDT08,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT08.



DATA : GS_ZEDT08 TYPE T_ZEDT08.



GS_ZEDT08-ZCODE = 'SSU-08'.

GS_ZEDT08-ZKNAME = '###'.

GS_ZEDT08-ZENAME = 'KIM'.



WRITE :/ GS_ZEDT08-ZCODE.

WRITE :/ GS_ZEDT08-ZKNAME.

WRITE :/ GS_ZEDT08-ZENAME.



"-----------------------------------------------



TYPES : BEGIN OF T_ZEDT08_1,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT08_1.



TYPES : BEGIN OF T_ZEDT08_2.

  INCLUDE TYPE T_ZEDT08_1.

  TYPES : TITLE TYPE C LENGTH 10,

          GRADE TYPE C LENGTH 1,

  END OF T_ZEDT08_2.



DATA : GS_ZEDT08_1 TYPE T_ZEDT08_2.



GS_ZEDT08_1-ZCODE = 'SSU-08'.

GS_ZEDT08_1-ZKNAME = '###'.

GS_ZEDT08_1-ZENAME = 'KIM'.

GS_ZEDT08_1-TITLE = '#####'.

GS_ZEDT08_1-GRADE = '3'.



WRITE :/ GS_ZEDT08_1-ZCODE.

WRITE :/ GS_ZEDT08_1-ZKNAME.

WRITE :/ GS_ZEDT08_1-ZENAME.

WRITE :/ GS_ZEDT08_1-TITLE.

WRITE :/ GS_ZEDT08_1-GRADE.



"-------------------------------------



DATA : BEGIN OF GS_ZEDT08_2,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT08_2.



GS_ZEDT08_2-ZCODE = 'SSU-08'.

GS_ZEDT08_2-ZKNAME = '###'.

GS_ZEDT08_2-ZENAME = 'KIM'.



WRITE :/ GS_ZEDT08_2-ZCODE.

WRITE :/ GS_ZEDT08_2-ZKNAME.

WRITE :/ GS_ZEDT08_2-ZENAME.



"--------------------------------------



DATA : BEGIN OF GS_ZEDT08_3,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT08_3.



DATA : BEGIN OF GS_ZEDT08_4.

  INCLUDE STRUCTURE GS_ZEDT08_3.

  DATA : TITLE TYPE C LENGTH 10,

          GRADE TYPE C LENGTH 1,

  END OF GS_ZEDT08_4.



GS_ZEDT08_4-ZCODE = 'SSU-8'.

GS_ZEDT08_4-ZKNAME = '###'.

GS_ZEDT08_4-ZENAME = 'KIM'.

GS_ZEDT08_4-TITLE = '#####'.

GS_ZEDT08_4-GRADE = '4'.



WRITE :/ GS_ZEDT08_4-ZCODE.

WRITE :/ GS_ZEDT08_4-ZKNAME.

WRITE :/ GS_ZEDT08_4-ZENAME.

WRITE :/ GS_ZEDT08_4-TITLE.

WRITE :/ GS_ZEDT08_4-GRADE.