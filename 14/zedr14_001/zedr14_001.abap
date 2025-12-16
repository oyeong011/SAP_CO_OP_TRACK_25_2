
"-----------------------------------------------------------------*




*& Report ZEDR14_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_001.



DATA : gv_num1 type p value '1234'.

DATA : gv_num2 type p DECIMALS 2 VALUE '12.34'.



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

write :/ .






*------------------------------------------------------------------






DATA : gv_text1 VALUE 'A'.

DATA : gv_text2 LENGTH 3 TYPE c VALUE 'ABC'.

DATA : gv_text3(5) TYPE c VALUE 'ABCDE'.

DATA : gv_text4 TYPE string VALUE 'ABCDE'.

DATA : gv_len TYPE i.

DATA : gv_time TYPE t.

DATA : gv_date TYPE d.



gv_time = sy-uzeit.

gv_date = sy-datum.

gv_len = strlen( gv_text3 ).



write :/ gv_text1.

write :/ gv_text2.

write :/ gv_text3.

write :/ gv_text4.

write :/ gv_len.

write :/ gv_time.

write :/ gv_date.

write :/ .






*-------------------------------------------------------------------






TYPES t_hello(20) TYPE c.



data gv_text5 type t_hello.

data gv_text6 like gv_text5.



gv_text5 = '#####'.

gv_text6 = '#####'.



write :/ gv_text5.

write :/ gv_text6.

write :/ .






*-------------------------------------------------------------------






DATA : TEXT1 TYPE STRING,

       TEXT2(4) TYPE C.



TEXT1 = 'ABAP'.

TEXT2 = 'B'.



FIND TEXT2 IN TEXT1.



IF SY-SUBRC = 0.

  WRITE : TEXT2.

  WRITE :/ .

ENDIF.






*-------------------------------------------------------------------






TEXT1 = 'ABAP'.

TEXT2 = 'BBAP'.



REPLACE TEXT1 IN TEXT1 WITH TEXT2.

WRITE : TEXT1.

WRITE :/ .






*-------------------------------------------------------------------






TEXT1 = 'ABAP'.

TEXT2 = 'abap'.



TRANSLATE TEXT1 TO LOWER CASE.

TRANSLATE TEXT2 TO UPPER CASE.



WRITE : TEXT1.

WRITE :/ TEXT2.

WRITE :/ .






*-------------------------------------------------------------------






DATA TEXT3(5) TYPE C.



TEXT1 = ' ABAP'.

TEXT3 = ' ABAP'.



SHIFT TEXT1.

WRITE : TEXT1.

WRITE :/ TEXT3.

WRITE :/ .






*-------------------------------------------------------------------






DATA : TEXT4(8) TYPE C,

       TEXT5(8) TYPE C.



TEXT1 = 'AB  AP'.

TEXT4 = 'AB  AP'.

TEXT5 = 'AB  AP'.



CONDENSE TEXT1.

CONDENSE TEXT4 NO-GAPS.



WRITE :/ TEXT1.

WRITE :/ TEXT4.

WRITE :/ TEXT5.

WRITE :/ .






*-------------------------------------------------------------------






DATA: TEXT6(4) TYPE C,

      TEXT7(4) TYPE C.



TEXT1 = 'AB'.

TEXT6 = 'AP'.



CONCATENATE TEXT1 TEXT6 INTO TEXT7.



WRITE :/ TEXT1.

WRITE :/ TEXT6.

WRITE :/ TEXT7.

WRITE :/ .






*-------------------------------------------------------------------






TEXT1 = 'AB+AP'.

SPLIT TEXT1 AT '+' INTO TEXT6 TEXT7.



WRITE :/ TEXT1.

WRITE :/ TEXT6.

WRITE :/ TEXT7.

WRITE :/ .






*-------------------------------------------------------------------






" ### type ##

TYPES : BEGIN OF t_zedt14,  " #### ###

  zcode TYPE c LENGTH 10,   " ####

  zkname TYPE c LENGTH 20,  " ####

  zename TYPE c LENGTH 20,  " ####

  END OF t_zedt14.



DATA : gs_zedt14 type t_zedt14.



gs_zedt14-zcode = 'SSU-01'.

gs_zedt14-zkname = '###'.

gs_zedt14-zename = 'dong'.



write :/ gs_zedt14-zcode.

WRITE :/ gs_zedt14-zkname.

WRITE :/ gs_zedt14-zename.

write :/ .






*-------------------------------------------------------------------






" ### type ##

TYPES : BEGIN OF t_zedt14_2.

  INCLUDE TYPE t_zedt14.

  TYPES : title TYPE c LENGTH 10,   " ####

          grade TYPE c LENGTH 1,    " ##

  END OF t_zedt14_2.



DATA : gs_zedt14_2 type t_zedt14_2.



gs_zedt14_2-zcode = 'SSU-02'.

gs_zedt14_2-zkname = '###'.

gs_zedt14_2-zename = 'dong'.

gs_zedt14_2-title = '####'.

gs_zedt14_2-grade = '3'.



write :/ gs_zedt14_2-zcode.

write :/ gs_zedt14_2-zkname.

write :/ gs_zedt14_2-zename.

write :/ gs_zedt14_2-title.

write :/ gs_zedt14_2-grade.

write :/ .






*-------------------------------------------------------------------






" data ## ##

DATA : BEGIN OF gs_zedt14_3,

  zcode TYPE c LENGTH 10,   " ####

  zkname TYPE c LENGTH 20,  " ####

  zename TYPE c LENGTH 20,  " ####

  END OF gs_zedt14_3.



DATA : BEGIN OF gs_zedt14_4.

  INCLUDE STRUCTURE gs_zedt14_3.

  DATA : title TYPE c LENGTH 10,

         grade TYPE c LENGTH 1,

  END OF gs_zedt14_4.



gs_zedt14_4-zcode = 'SSU-03'.

gs_zedt14_4-zkname = '###'.

gs_zedt14_4-zename = 'dong'.

gs_zedt14_4-title = '####'.

gs_zedt14_4-grade = '3'.



write :/ gs_zedt14_4-zcode.

write :/ gs_zedt14_4-zkname.

write :/ gs_zedt14_4-zename.

write :/ gs_zedt14_4-title.

write :/ gs_zedt14_4-grade.