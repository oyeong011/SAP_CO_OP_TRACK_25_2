
*&---------------------------------------------------------------------*

*& Report ZEDR02_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_001.



" 1. predifined ABAP TYPE

"Numeric type ##




*DATA : gv_num1 type p VALUE '1234'. "### ### ## ## ##

*DATA : gv_num2 type p DECIMALS 2 VALUE '12.34'.

*

*DATA : gv_num3 type i VALUE 1234. "##

*

*DATA : gv_num4 TYPE N VALUE 1234. " ##### # ### ###

*DATA : gv_num5 TYPE n LENGTH 2 VALUE 1234. "// # ##

*DATA : gv_num6 TYPE n LENGTH 3 VALUE 1234. "// # ##

*DATA : gv_num7 TYPE n LENGTH 4 VALUE 1234. "// 5##

*  WRITE : gv_num1.

*  WRITE :/ gv_num2.

*  WRITE :/ gv_num3.

*  WRITE :/ gv_num4.

*  WRITE :/ gv_num5.

*  WRITE :/ gv_num6.

*  WRITE :/ gv_num7.






"Charater type ##




*DATA : GV_TEXT1 VALUE 'A'. "## 1# ##

*DATA : GV_TEXT2 LENGTH 3 TYPE C VALUE 'ABC'.

*DATA : GV_TEXT3(5) TYPE C VALUE 'ABCDE'.

*DATA : GV_TEXT4 TYPE STRING VALUE 'ABCDE'. "####

*DATA : GV_LEN TYPE i.

*

*DATA : GV_TIME TYPE T.

*

*DATA : GV_DATE TYPE D.

*

*GV_TIME = SY-UZEIT. "HHMMSS

*GV_DATE = SY-DATUM. "YYYYMMDD

*GV_LEN = STRLEN( GV_TEXT3 ). "#### ##

*

*WRITE : GV_TEXT1, / gv_text2, / gv_text3, / gv_text4, / gv_len, / gv_time, / gv_date.






"String ##

"FIND ## ##




*DATA:TEXT1 TYPE STRING,

*     TEXT2(4) TYPE C.

*TEXT1 = 'ABAP'.

*TEXT2 = 'B'.

*FIND TEXT2 IN TEXT1.

*IF SY-SUBRC = 0. "### 0 ##

*  WRITE TEXT2.

*ENDIF.






"REPLACE ## ##




*DATA: TEXT1 TYPE STRING,

*      TEXT2(4) TYPE C.

*TEXT1 = 'ABAP'.

*TEXT2 = 'BBAP'.

*REPLACE TEXT1 IN TEXT1 WITH TEXT2.

*WRITE: TEXT1.






"TRANSLATE #### ##




*DATA: TEXT1 TYPE STRING,

*      TEXT2(4) TYPE C.

*TEXT1 = 'ABAP'.

*TEXT2 = 'abap'.

*TRANSLATE TEXT1 To LOWER CASE.

*TRANSLATE TEXT2 To UPPER CASE.

*WRITE: TEXT1.

*WRITE: / TEXT2.






"SHIFT ### #### # # # ##




*DATA: TEXT1 TYPE STRING,

*      TEXT2(5) TYPE C.

*TEXT1 = 'ABAP'.

*TEXT2 = 'ABAP'.

*SHIFT TEXT1.

*WRITE: TEXT1.

*WRITE: / TEXT2.






"CONDENSE ### #### #### ##




*DATA: TEXT1 TYPE STRING,

*      TEXT2(8) TYPE C,

*      TEXT3(8) TYPE C.

*TEXT1 = 'AB   AP'.

*TEXT2 = 'AB  AP'.

*TEXT3 = 'AB     AP'.

*CONDENSE TEXT1. "# # ## ##, ## ### ### ##, # # ### ##

*CONDENSE TEXT2 NO-GAPS. "## ## ##

*WRITE: TEXT1.

*WRITE: / TEXT2.

*WRITE: / TEXT3.






"OVERLAY CHAR # ## ### ### ## ## ##### ##




*DATA: TEXT1 TYPE STRING,

*      TEXT2(8) TYPE C.

*TEXT1 = ' B P'.

*TEXT2 = 'AAAA'.

*OVERLAY TEXT1 WITH TEXT2.

*WRITE: TEXT1.

*WRITE: / TEXT2.






"CONCATENATE #### ##(C TYPE# ##)




*DATA: TEXT1 TYPE STRING,

*      TEXT2(4) TYPE C,

*      TEXT3(4) TYPE C.

*TEXT1 = 'AB'.

*TEXT2 = 'AP'.

*CONCATENATE TEXT1 TEXT2 INTO TEXT3.

*WRITE: TEXT1.

*WRITE:/ TEXT2.

*WRITE:/ TEXT3.






"SPLIT ## ### #### ### ##




*DATA: TEXT1 TYPE STRING,

*      TEXT2(4) TYPE C,

*      TEXT3(4) TYPE C.

*TEXT1 = 'AB+AP'.

*SPLIT TEXT1 AT '+' INTO TEXT2 TEXT3.

*WRITE: TEXT1.

*WRITE:/ TEXT2.

*WRITE:/ TEXT3.






"### ##




*DATA : gv_num1 TYPE i VALUE 5,

*       gv_num2 type i VALUE 3,

*       gv_num3 type i.

*gv_num3 = gv_num1 + gv_num2. "###

*WRITE: gv_num3.

*

*gv_num3 = gv_num1 - gv_num2. "##

*WRITE: / gv_num3.

*

*gv_num3 = gv_num1 * gv_num2. "###

*WRITE: / gv_num3.

*

*gv_num3 = gv_num1 / gv_num2. "###

*WRITE: / gv_num3.

*

*gv_num3 = gv_num1 div gv_num2. "#

*WRITE: / gv_num3.

*

*gv_num3 = gv_num1 mod gv_num2. "###

*WRITE: / gv_num3.

*

*gv_num3 = gv_num1 ** gv_num2. "##

*WRITE: / gv_num3.






" 2. Local Data Type ##

"Type ##




*TYPES T_HELLO(20) TYPE C. "T_HELLO## ### ## ##

*DATA gv_text1 type T_HELLO. "Type(T_HELLO)# #### ##(object) ##

*DATA GV_text2 LIKE GV_Text1. "DATA Object# #### ##(object) ##

*gv_text1 = '#####'.

*gv_text2 = '#####'.

*

*WRITE : gv_text1, / gv_text2.






"Structeured type ##

"#######-> ####

"#######




*TYPES : BEGIN OF T_ZEDT02, "#### ###

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 20,

*  ZENAME TYPE C LENGTH 20,

*  END OF T_ZEDT02.

*"### ## ##

*DATA: GS_ZEDT02 TYPE T_ZEDT02.

*

*GS_ZEDT02-ZCODE = 'SSU-01'.

*GS_ZEDT02-ZKNAME = '###'.

*GS_ZEDT02-ZENAME = 'DONG'.

*

*WRITE: / GS_ZEDT02-ZCODE, / GS_ZEDT02-ZKNAME, / GS_ZEDT02-ZENAME.






"### TYPE, Nested TYPE## # ### ####




*"### ## ##

*TYPES: BEGIN OF T_ZEDT02, "#### ###

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 20,

*  ZENAME TYPE C LENGTH 20,

*  END OF T_ZEDT02.

*TYPES : BEGIN OF T_ZEDT02_2. "#### ###+####

*  INCLUDE TYPE T_ZEDT02.

*  TYPES: TITLE TYPE C LENGTH 10,

*         GRADE TYPE C LENGTH 1,

*  END OF T_ZEDT02_2.

*"### ## ##

*DATA: GS_ZEDT02 TYPE T_ZEDT02_2. "### ### ## ##

*

*GS_ZEDT02-ZCODE = 'SSU-01'.

*GS_ZEDT02-ZKNAME = '###'.

*GS_ZEDT02-ZENAME = 'DONG'.

*GS_ZEDT02-TITLE = '####'.

*GS_ZEDT02-GRADE = '3'.

*

*WRITE : / GS_ZEDT02-ZCODE, / GS_ZEDT02-ZKNAME, / GS_ZEDT02-ZENAME, / GS_ZEDT02-TITLE, / GS_ZEDT02-GRADE.






"DATA BEGIN OF ~END OF




*"DATA ## ##

*DATA: BEGIN OF GS_ZEDT02, "#### ###

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 20,

*  ZENAME TYPE C LENGTH 20,

*  END OF GS_ZEDT02. "T ## GS ##

*GS_ZEDT02-ZCODE = 'SSU-01'.

*GS_ZEDT02-ZKNAME = '###'.

*GS_ZEDT02-ZENAME = 'DONG'.

*

*WRITE: / GS_ZEDT02-ZCODE, / GS_ZEDT02-ZKNAME, / GS_ZEDT02-ZENAME.






"BEGIN OF, Nested TYPE##~END OF




*"DATA ## ##

*DATA: BEGIN OF GS_ZEDT02, "#### ###

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 20,

*  ZENAME TYPE C LENGTH 20,

*  END OF GS_ZEDT02.

*DATA : BEGIN OF GS_ZEDT02_2. "#### ###+####(## ## ##)

*  INCLUDE STRUCTURE GS_ZEDT02. "STRUCTURE ###

*  DATA: TITLE TYPE C LENGTH 10,

*         GRADE TYPE C LENGTH 1,

*  END OF GS_ZEDT02_2.

*

*GS_ZEDT02_2-ZCODE = 'SSU-01'.

*GS_ZEDT02_2-ZKNAME = '###'.

*GS_ZEDT02_2-ZENAME = 'DONG'.

*GS_ZEDT02_2-TITLE = '####'. "02_2## ## ##

*GS_ZEDT02_2-GRADE = '3'.

*

*WRITE : / GS_ZEDT02_2-ZCODE, / GS_ZEDT02_2-ZKNAME, / GS_ZEDT02_2-ZENAME, / GS_ZEDT02_2-TITLE, / GS_ZEDT02_2-GRADE.