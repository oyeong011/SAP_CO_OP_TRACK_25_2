
*&---------------------------------------------------------------------*

*& Report ZEDR03_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_001.



" ### ## p, i, n



DATA : gv_num1 TYPE p VALUE '1234'.

DATA : gv_num2 TYPE p DECIMALS 2 VALUE '12.34'.



DATA : gv_num3 TYPE i VALUE 1234.



DATA : gv_num4 TYPE n VALUE 1234.

DATA : gv_num5 TYPE n length 2 VALUE 1234.

DATA : gv_num6 TYPE n length 3 VALUE 1234.

DATA : gv_num7 TYPE n length 4 VALUE 1234.



WRITE : gv_num1.

WRITE :/ gv_num2. " #### 12.34

WRITE :/ gv_num3.

WRITE :/ gv_num4.

WRITE :/ gv_num5.

WRITE :/ gv_num6.

WRITE :/ gv_num7. " ### #### # ### #






*--------------------------------------------------------------------*






" ### ##



"DATA : gv_text1 VALUE 'A'.

"DATA : gv_text2 TYPE c LENGTH 3 VALUE 'ABC'.

"DATA : gv_text3(3) TYPE c VALUE 'ABCDE'.

"DATA : gv_text4 TYPE STRING VALUE '##### #####'.



DATA : gv_len TYPE i.

DATA : gv_time TYPE t. " t : ##

DATA : gv_date TYPE d. " d : ##, ## ## ## X



gv_time = SY-UZEIT. " #### ## ### ####

gv_date = SY-DATUM. " #### ## ### ####

"gv_len = STRLEN( gv_text3 ). " ## ##### ### ### ## ####



"write :/ gv_text1.

"WRITE :/ gv_text2.

"WRITE :/ gv_text3.

"WRITE :/ gv_text4.

WRITE :/ gv_len.

WRITE :/ gv_time.

WRITE :/ gv_date.






*--------------------------------------------------------------------*






" ### ##



DATA : TEXT1 TYPE STRING,

       TEXT2(4) TYPE C,

       TEXT3(4) TYPE C.



TEXT1 = 'AB+AP'.

SPLIT TEXT1 AT '+' INTO TEXT2 TEXT3.



WRITE / TEXT1.

WRITE / TEXT2.

WRITE / TEXT3.






*--------------------------------------------------------------------*






"## #### #####

"## ## -> ## ## ###!



TYPES T_HELLO(20) TYPE C. " T_HELLO## ### ## ##



DATA GV_TEXT1 TYPE T_HELLO.

DATA GV_TEXT2 LIKE GV_TEXT1. "LIKE(##)# ### ## ## ### ## ### # # ##



GV_TEXT1 = 'SAP# ###'.

GV_TEXT2 = 'SAP# ###'.



WRITE / GV_TEXT1.

WRITE / GV_TEXT2.



"### ## ### ####



"TYPES : BEGIN OF T_ZEDT03,

"  ZCODE TYPE C LENGTH 10,

"  ZKNAME(20) TYPE C,

"  ZENAME TYPE C LENGTH 20,

"  END OF T_ZEDT03.



"DATA : GS_ZEDT03 TYPE T_ZEDT03.



"GS_ZEDT03-ZCODE = 'SSU-03'.

"GS_ZEDT03-ZKNAME = '##'.

"GS_ZEDT03-ZENAME = 'Jisoo'.



"WRITE /. " ### #### '\n' # ### ####

"WRITE / GS_ZEDT03-ZCODE.

"WRITE / GS_ZEDT03-ZKNAME.

"WRITE / GS_ZEDT03-ZENAME.'



"### ### ##### ### ###!





"TYPES : BEGIN OF T_ZEDT03,

"  ZCODE TYPE C LENGTH 10,

"  ZKNAME TYPE C LENGTH 20,

"  ZENAME TYPE C LENGTH 20,

"  END OF T_ZEDT03.



"TYPES : BEGIN OF T_ZEDT03_2. " ### ## #### # ##.

"  INCLUDE TYPE T_ZEDT03. " ### ###!

"  TYPES : TITLE TYPE C LENGTH 10,

"          GRADE TYPE C LENGTH 1,

"  END OF T_ZEDT03_2.



"DATA : GS_ZEDT03 TYPE T_ZEDT03_2.



"  GS_ZEDT03-ZCODE = 'SSU-03'.

"  GS_ZEDT03-ZKNAME = '##'.

"  GS_ZEDT03-ZENAME = 'Jisoo'.

"  GS_ZEDT03-TITLE = '####'.

"  GS_ZEDT03-GRADE = '8'.



"  WRITE /.

"  WRITE / GS_ZEDT03-ZCODE.

"  WRITE / GS_ZEDT03-ZKNAME.

"  WRITE / GS_ZEDT03-ZENAME.

"  WRITE / GS_ZEDT03-TITLE.

"  WRITE / GS_ZEDT03-GRADE.



"DATA : BEGIN OF GS_ZEDT03,

"  ZCODE TYPE C LENGTH 10,

"  ZKNAME TYPE C LENGTH 30,

"  ZENAME TYPE C LENGTH 20,

"  END OF GS_ZEDT03.



" GS_ZEDT03-ZCODE = 'SSU-03'.

" GS_ZEDT03-ZKNAME = '######'.

" GS_ZEDT03-ZENAME = 'Jisoo is cool'.



" WRITE / GS_ZEDT03-ZCODE.

" WRITE / GS_ZEDT03-ZKNAME.

" WRITE / GS_ZEDT03-ZENAME.



DATA : BEGIN OF GS_ZEDT03,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT03.



DATA : BEGIN OF GS_ZEDT03_2.

  INCLUDE STRUCTURE GS_ZEDT03.

  DATA : TITLE TYPE C LENGTH 10,

         GRADE TYPE C LENGTH 1,

  END OF GS_ZEDT03_2.



GS_ZEDT03_2-ZCODE = 'SSU-03'.

GS_ZEDT03_2-ZKNAME = '##'.

GS_ZEDT03_2-ZENAME = 'JISOO'.

GS_ZEDT03_2-TITLE = 'BLACKPINK'.

GS_ZEDT03_2-GRADE = '3'.



WRITE / .

WRITE / GS_ZEDT03_2-ZCODE.

WRITE / GS_ZEDT03_2-ZKNAME.

WRITE / GS_ZEDT03_2-ZENAME.

WRITE / GS_ZEDT03_2-TITLE.

WRITE / GS_ZEDT03_2-GRADE.