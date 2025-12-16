
*&---------------------------------------------------------------------*

*& Report ZEDR07_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_001.






*DATA : gv_num1 TYPE p VALUE '1234'.

*DATA : gv_num2 TYPE p DECIMALS 2 VALUE '12.34'.

*

*DATA : gv_num3 TYPE i VALUE '1234'.

*

*DATA : gv_num4 TYPE n VALUE '1234'.

*DATA : gv_num5 TYPE n LENGTH 2 VALUE '1234'.

*DATA : gv_num6 TYPE n LENGTH 3 VALUE '1234'.

*DATA : gv_num7 TYPE n LENGTH 4 VALUE '1234'.

*

*WRITE : gv_num1.

*WRITE :/ gv_num2.

*WRITE :/ gv_num3.

*WRITE :/ gv_num4.

*WRITE :/ gv_num5.

*WRITE :/ gv_num6.

*WRITE :/ gv_num7.



***************************************************************************



*DATA : gv_text1 VALUE 'A'.

*DATA : gv_text2 LENGTH 3 TYPE c VALUE 'ABC'.

*DATA : gv_text3(5) TYPE c value 'ABCDE'.

*DATA : gv_text4 TYPE string VALUE 'ABCDE'.

*DATA : gv_len TYPE i.

*

*DATA : gv_time TYPE t.

*

*DATA : gv_date TYPE d.

*

*gv_time = sy-uzeit.

*gv_date = sy-datum.

*gv_len = strlen( gv_text3 ).

*

*WRITE : gv_text1.

*WRITE :/ gv_text2.

*WRITE :/ gv_text3.

*WRITE :/ gv_text4.

*WRITE :/ gv_len.

*WRITE :/ gv_time.

*WRITE :/ gv_date.



****************************************************************************



*DATA : text1 TYPE string, text2(4) TYPE c.

*

*text1 = 'ABAP'.

*text2 = 'B'.

*

*FIND text2 in text1.

*

*IF sy-subrc = 0.

*  WRITE text2.

*ENDIF.



*****************************************************************************



*DATA : text1 TYPE string, text2(4) TYPE c.

*

*text1 = 'ABAP'.

*text2 = 'BBAP'.

*

*REPLACE text1 IN text1 WITH text2.

*WRITE : text1.



*****************************************************************************



*DATA : text1 TYPE string, text2(4) TYPE c.

*

*text1 = 'ABAP'.

*text2 = 'abap'.

*

*TRANSLATE text1 TO LOWER CASE.

*TRANSLATE text2 to UPPER CASE.

*WRITE : text1.

*WRITE :/ text2.



******************************************************************************



*DATA : text1 TYPE string, text2(5) TYPE c.

*

*text1 = ' ABAP'.

*text2 = ' ABAP'.

*

*SHIFT text1.

*WRITE : text1.

*WRITE :/ text2.



******************************************************************************



*DATA : text1 TYPE string, text2(8) TYPE c, text3(8) TYPE c.

*

*text1 = 'AB   AP'.

*text2 = 'AB   AP'.

*text3 = 'AB   AP'.

*

*CONDENSE text1.

*CONDENSE text2 NO-GAPS.

*

*WRITE : text1.

*WRITE :/ text2.

*WRITE :/ text3.



*******************************************************************************



*DATA : text1 TYPE string, text2(8) TYPE c.

*

*text1 = ' B P'.

*text2 = 'AAAA'.

*

*OVERLAY text1 WITH text2.

*

*WRITE : text1.

*WRITE :/ text2.



********************************************************************************

*

*DATA : text1 TYPE string,

*       text2(4) TYPE c,

*       text3(4) TYPE c.

*

*text1 = 'AB'.

*text2 = 'AP'.

*

*CONCATENATE text1 text2 INTO text3.

*

*WRITE : text1.

*WRITE :/ text2.

*WRITE :/ text3.



********************************************************************************

*

*DATA : text1 TYPE string,

*       text2(4) TYPE c,

*       text3(4) TYPE c.

*

*text1 = 'AB+AP'.

*SPLIT text1 AT '+' INTO text2 text3.

*

*WRITE : text1.

*WRITE :/ text2.

*WRITE :/ text3.



********************************************************************************

*

*DATA : gv_num1 TYPE i VALUE 5,

*       gv_num2 TYPE i VALUE 3,

*       gv_num3 TYPE i.

*

*gv_num3 = gv_num1 + gv_num2.

*WRITE : gv_num3.

*

*gv_num3 = gv_num1 - gv_num2.

*WRITE :/ gv_num3.

*

*gv_num3 = gv_num1 * gv_num2.

*WRITE :/ gv_num3.

*

*gv_num3 = gv_num1 / gv_num2.

*WRITE :/ gv_num3.

*

*gv_num3 = gv_num1 DIV gv_num2.

*WRITE :/ gv_num3.

*

*gv_num3 = gv_num1 MOD gv_num2.

*WRITE :/ gv_num3.

*

*gv_num3 = gv_num1 ** gv_num2.

*WRITE :/ gv_num3.



********************************************************************************

*

*TYPES t_hello(20) TYPE c.

*

*DATA gv_text1 TYPE t_hello.

*DATA gv_text2 LIKE gv_text1.

*

*gv_text1 = '#####'.

*gv_text2 = '#####'.

*

*WRITE : gv_text1.

*WRITE :/ gv_text2.



********************************************************************************

*

*TYPES : BEGIN OF t_zedt07,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 20,

*  zename TYPE c LENGTH 20,

*  END OF t_zedt07.

*

*  DATA : gs_zedt07 TYPE t_zedt07.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*

*  WRITE : gs_zedt07-zcode.

*  WRITE :/ gs_zedt07-zkname.

*  WRITE :/ gs_zedt07-zename.



*********************************************************************************

*

*TYPES : BEGIN OF t_zedt07,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 20,

*  zename TYPE c LENGTH 20,

*  END OF t_zedt07.

*

*TYPES : BEGIN OF t_zedt07_2.

*  INCLUDE TYPE t_zedt07.

*

*  TYPES : title TYPE c LENGTH 10,

*          grade TYPE c LENGTH 1,

*  END OF t_zedt07_2.

*

*  DATA : gs_zedt07 TYPE t_zedt07_2.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-title = '####'.

*  gs_zedt07-grade = '3'.

*

*  WRITE : gs_zedt07-zcode.

*  WRITE :/ gs_zedt07-zkname.

*  WRITE :/ gs_zedt07-zename.

*  WRITE :/ gs_zedt07-title.

*  WRITE :/ gs_zedt07-grade.



***********************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 20,

*  zename TYPE c LENGTH 20,

*  END OF gs_zedt07.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*

*  WRITE : gs_zedt07-zcode.

*  WRITE :/ gs_zedt07-zkname.

*  WRITE :/ gs_zedt07-zename.



***********************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE c LENGTH 10,

*  zkname TYPE c LENGTH 20,

*  zename TYPE c LENGTH 20,

*  END OF gs_zedt07.

*

*DATA : BEGIN OF gs_zedt07_2.

*  INCLUDE STRUCTURE gs_zedt07.

*  DATA : title TYPE c LENGTH 10,

*         grade TYPE c LENGTH 1,

*  END OF gs_zedt07_2.

*

*  gs_zedt07_2-zcode = 'SSU-01'.

*  gs_zedt07_2-zkname = '###'.

*  gs_zedt07_2-zename = 'DONG'.

*  gs_zedt07_2-title = '####'.

*  gs_zedt07_2-grade = '3'.

*

*

*  WRITE : gs_zedt07_2-zcode.

*  WRITE :/ gs_zedt07_2-zkname.

*  WRITE :/ gs_zedt07_2-zename.

*  WRITE :/ gs_zedt07_2-title.

*  WRITE :/ gs_zedt07_2-grade.



************************************************************************************