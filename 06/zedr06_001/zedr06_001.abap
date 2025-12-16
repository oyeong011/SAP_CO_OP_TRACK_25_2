
*&---------------------------------------------------------------------*

*& Report ZEDR06_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_001.



DATA : gv_num1 TYPE p VALUE '1234'.

DATA : gv_num2 TYPE p DECIMALS 2 VALUE '12.34'.



DATA : gv_num3 TYPE i VALUE '1234'.



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



WRITE :/.

WRITE :/.

"---------------------------------------





DATA : gv_text1 VALUE 'A'.

DATA : gv_text2 LENGTH 3 TYPE c VALUE 'ABC'.

DATA : gv_text3(5) TYPE c VALUE 'ABCDE'.

DATA : gv_text4 TYPE string VALUE 'ABCDE'.

DATA : gv_len TYPE i.



DATA : gv_time TYPE T.

DATA : gv_date TYPE D.



gv_time = SY-UZEIT.

gv_date = SY-DATUM.

gv_len = STRLEN( gv_text3 ).



WRITE : gv_text1.

WRITE :/ gv_text2.

WRITE :/ gv_text3.

WRITE :/ gv_text4.

WRITE :/ gv_len.

WRITE :/ gv_time.

WRITE :/ gv_time.

WRITE :/ gv_date.



WRITE :/.

WRITE :/.

"---------------------------------------





DATA : text1 TYPE string,

       text2(4) TYPE C.



text1 = 'ABAP'.

text2 = 'B'.



FIND text2 IN TEXT1.



IF SY-SUBRC = 0.

  WRITE text2.

ENDIF.



WRITE :/.

WRITE :/.

"---------------------------------------







DATA : text3 TYPE string,

       text4(4) TYPE C.



text3 = 'ABAP'.

text4 = 'BBAP'.



REPLACE text3 IN text3 WITH text4.

WRITE  : text3.





WRITE :/.

WRITE :/.

"---------------------------------------





DATA : text5 TYPE string,

       text6(4) TYPE C.



text5 = 'ABAP'.

text6 = 'abap'.



TRANSLATE text5 TO LOWER CASE.

TRANSLATE text6 TO UPPER CASE.

WRITE  : text5.

WRITE  :/ text6.



WRITE :/.

WRITE :/.

"---------------------------------------



DATA : text7 TYPE string,

       text8(5) TYPE C.



text7 = 'ABAP'.

text8 = 'ABAP'.



SHIFT text7.

WRITE : text7.

WRITE :/ text8.



WRITE :/.

WRITE :/.

"---------------------------------------



DATA : text9 TYPE string,

       text10(8) TYPE C,

       text11(8) TYPE C.



text9 = 'AB   AP'.

text10 = 'AB   AP'.

text11 = 'AB   AP'.



CONDENSE text9. "### ## # 1## #### ##

CONDENSE text10 NO-GAPS.



WRITE : text9.

WRITE :/ text10.

WRITE :/ text11.



WRITE :/.

WRITE :/.

"---------------------------------------



DATA : text12 TYPE string,

       text13(8) TYPE C.



text12 = ' B P'.

text13 = 'AAAA'.



OVERLAY text12 WITH text13.



WRITE : text12.

WRITE :/ text13.



WRITE :/.

WRITE :/.

"---------------------------------------



DATA : text14 TYPE string,

       text15(4) TYPE C,

       text16 LENGTH 4 TYPE C.



text14 = 'AB'.

text15 = 'AP'.



CONCATENATE text14 text15 INTO text16.



WRITE : text14.

WRITE :/ text15.

WRITE :/ text16.



WRITE :/.

WRITE :/.

"---------------------------------------



DATA : text17 TYPE string,

       text18(4) TYPE C,

       text19 LENGTH 4 TYPE C.



text17 = 'AB+CD'.

SPLIT text17 AT '+' INTO text18 text19.



WRITE : text17.

WRITE :/ text18.

WRITE :/ text19.



WRITE :/.

WRITE :/.

"---------------------------------------



DATA : gv_num8 TYPE i VALUE 5,

       gv_num9 TYPE i VALUE 3,

       gv_num10 TYPE i.



gv_num10 = gv_num8 + gv_num9.

WRITE : gv_num10.



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



WRITE :/.

WRITE :/.

"---------------------------------------



TYPES T_HELLO(20) TYPE c.



DATA : gv_text5 TYPE T_HELLO.

DATA : gv_text6 LIKE gv_text5. " LIKE# ### ####. ####.



gv_text5 = '#####'.

gv_text6 = '#####'.



WRITE : gv_text5.

WRITE : / gv_text6.



WRITE :/.

WRITE :/.

"---------------------------------------



" ### TYPE ##

TYPES : BEGIN OF T_ZEDT06, " #######

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT06.



  DATA : GS_ZEDT06 TYPE T_ZEDT06.



  GS_ZEDT06-ZCODE = 'SSU-06'.

  GS_ZEDT06-ZKNAME = '###'.

  GS_ZEDT06-ZENAME = 'kwon'.



 WRITE : / GS_ZEDT06-ZCODE.

 WRITE : / GS_ZEDT06-ZKNAME.

 WRITE : / GS_ZEDT06-ZENAME.



WRITE :/.

WRITE :/.

"---------------------------------------



"### TYPE ##

TYPES : BEGIN OF T_ZEDT06_2.

  INCLUDE TYPE T_ZEDT06.

  TYPES : TITLE TYPE C LENGTH 10,

          GRADE TYPE C LENGTH 1,

END OF T_ZEDT06_2.



DATA : GS_ZEDT06_2 TYPE T_ZEDT06_2.



GS_ZEDT06_2-ZCODE = 'SSU-06'.

GS_ZEDT06_2-ZKNAME = '###'.

GS_ZEDT06_2-ZENAME = 'kwon'.

GS_ZEDT06_2-TITLE = '###'.

GS_ZEDT06_2-GRADE = '3'.



 WRITE : / GS_ZEDT06_2-ZCODE.

 WRITE : / GS_ZEDT06_2-ZKNAME.

 WRITE : / GS_ZEDT06_2-ZENAME.

 WRITE : / GS_ZEDT06_2-TITLE.

 WRITE : / GS_ZEDT06_2-GRADE.





WRITE :/.

WRITE :/.

"---------------------------------------



DATA : BEGIN OF GS_ZEDT06_3,

  ZCODE TYPE c LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT06_3.



GS_ZEDT06_3-ZCODE = 'SSU-06'.

GS_ZEDT06_3-ZKNAME = '###'.

GS_ZEDT06_3-ZENAME = 'kwon'.



 WRITE : / GS_ZEDT06_3-ZCODE.

 WRITE : / GS_ZEDT06_3-ZKNAME.

 WRITE : / GS_ZEDT06_3-ZENAME.



WRITE :/.

WRITE :/.

"---------------------------------------



DATA : BEGIN OF GS_ZEDT06_4,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT06_4.



DATA : BEGIN OF GS_ZEDT06_4_2.

  INCLUDE STRUCTURE GS_ZEDT06_4.

  DATA : TITLE TYPE C LENGTH 10,

         GRADE TYPE C LENGTH 1,

  END OF GS_ZEDT06_4_2.



GS_ZEDT06_4_2-ZCODE = 'SSU-06'.

GS_ZEDT06_4_2-ZKNAME = '###'.

GS_ZEDT06_4_2-ZENAME = 'kwon'.

GS_ZEDT06_4_2-TITLE = '###'.

GS_ZEDT06_4_2-GRADE = '3'.



WRITE :/ GS_ZEDT06_4_2-ZCODE.

WRITE :/ GS_ZEDT06_4_2-ZKNAME.

WRITE :/ GS_ZEDT06_4_2-ZENAME.

WRITE :/ GS_ZEDT06_4_2-TITLE.

WRITE :/ GS_ZEDT06_4_2-GRADE.