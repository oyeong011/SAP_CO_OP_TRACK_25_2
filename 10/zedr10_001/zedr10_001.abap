
*&---------------------------------------------------------------------*

*& Report ZEDR10_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_001.



DATA : gv_num1 type p value '1234',

      gv_num2 type p DECIMALS 2 VALUE '12.34'.



DATA: gv_num3 TYPE i VALUE 1234.



DATA: gv_num4 TYPE N VALUE 1234,

      gv_num5 TYPE N LENGTH 2 VALUE 1234,

      gv_num6 TYPE N LENGTH 3 VALUE 1234,

      gv_num7 TYPE N LENGTH 4 VALUE 1234.



WRITE: gv_num1,/ gv_num2,/ gv_num3,/ gv_num4,/ gv_num5,/ gv_num6,/ gv_num7.



ULINE /.

" text ## ##



DATA: gv_text1 VALUE 'A',

      gv_text2 LENGTH 3 type C VALUE 'ABC',

      gv_text3(5) TYPE C VALUE 'ABCDE',

      gv_text4 TYPE STRING VALUE 'ABCDE',

      gv_len TYPE i.



DATA: gv_time TYPE T.



DATA: gv_date TYPE D.



gv_time = SY-UZEIT.

gv_date = SY-DATUM.

gv_len = STRLEN( gv_text3 ).



WRITE:/ gv_text1.

WRITE:/ gv_text2.

WRITE:/ gv_text3.

WRITE:/ gv_text4.

WRITE:/ gv_len.

WRITE:/ gv_time.

WRITE:/ gv_date.



ULINE /.

" replace ##



DATA: text1 TYPE STRING,

      text2(4) TYPE C,

      text3(4) TYPE C VALUE 'A'.



text1 = 'A B A P'.

text2 = 'BBAP'.



" REPLACE "text" in "replaced text" with "replacing text"

" replaced text### ### text# replacing text# ## # replaced text# ##

" REPLACE OF text3 IN text1 WITH text2. " BBAP B A P ##

REPLACE ALL OCCURRENCES OF text3 IN text1 WITH text2. " BBAP B BBAP P ##

" all occurrences ### ## ##

WRITE : text1.



ULINE /.

" translate : #### ## ##



DATA: text4 TYPE STRING,

      text5(4) TYPE C.



text4 = 'ABAP'.

text5 = 'abap'.



TRANSLATE text4 TO LOWER CASE.

TRANSLATE text5 TO UPPER CASE.



WRITE:/ text4.

WRITE:/ text5.



ULINE /.

" shift : #### ## ## ##



text1 = ' ABAP'.

text2 = ' ABAP'. " 4### ### ### ### ###



SHIFT text1.

SHIFT text2.

WRITE:/ text1.

WRITE:/ text2. " ABA ##



ULINE /.

" concatenate ##, ###



text1 = 'AB'.

text2 = 'AP'.



CONCATENATE text1 text2 INTO text3. " text3 = text1 + text2

WRITE:/ text1. " AB

WRITE:/ text2. " AP

WRITE:/ text3. " ABAP



ULINE /.

" split ##



text1 = 'A+BA+P'.

" text1# #### ## ## ### +# #### ## #### text2# ### #### text3# ##

SPLIT text1 AT '+' INTO text2 text3.

WRITE: text1,/ text2,/ text3.



ULINE /.

" type ##

TYPES T_HELLO(20) TYPE C.   " ### ## ##

DATA gv_text11 TYPE T_HELLO.

DATA gv_text12 LIKE gv_text11. " data object## ## ####



gv_text11 = '#####'.

gv_text12 = '#####'.



WRITE: gv_text11.

WRITE:/ gv_text12.



ULINE /.

" ### ##



TYPES: BEGIN OF T_ZEDT00, " #### ###

 zcode TYPE C LENGTH 10,

 zkname TYPE C LENGTH 20,

 zename TYPE C LENGTH 20,

 END OF T_ZEDT00.



"### ##

DATA: gs_zedt00 TYPE T_ZEDT00.



gs_zedt00-zcode = 'SSU-01'.

gs_zedt00-zkname = '###'.

gs_zedt00-ZENAME = 'DONG'. " ### member # #### ####.



WRITE: gs_zedt00-zcode.

WRITE:/ gs_zedt00-zkname.

WRITE:/ gs_zedt00-zename.



ULINE /.

" nest struct ##

TYPES: BEGIN OF T_ZEDT00_2.

  INCLUDE TYPE T_ZEDT00. " include ## ## ###.

  TYPES: title TYPE C LENGTH 10,

         grade TYPE C LENGTH 1,

  END OF T_ZEDT00_2.



" ### ####

DATA: gs_zedt01 TYPE T_ZEDT00_2.



gs_zedt01-zcode = 'ssu-01'.

gs_zedt01-zkname = '###'.

gs_zedt01-zename = 'DONG'.

gs_zedt01-title = '####'.

gs_zedt01-grade = '3'.



WRITE: gs_zedt01-zcode.

WRITE:/ gs_zedt01-zkname.

WRITE:/ gs_zedt01-zename.

WRITE:/ gs_zedt01-title.

WRITE:/ gs_zedt01-grade.