
*&---------------------------------------------------------------------*

*& Report ZEDR20_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_001.






* ####

*DATA : gv_num1 type p VALUE '1234'.




"DATA : gv_num2 type p DECIMALS 2 VALUE '1234.56'.




*

*DATA : gv_num3 TYPE i VALUE 1234.

*

*DATA : gv_num4 TYPE n VALUE 1234.

*

*DATA : gv_num5 TYPE n LENGTH 1 VALUE 1234.

*DATA : gv_num6 TYPE n LENGTH 2 VALUE 1234.

*DATA : gv_num7 TYPE n LENGTH 3 VALUE 1234.

*DATA : gv_num8 TYPE n LENGTH 4 VALUE 1234.

*

*WRITE: gv_num1.

*WRITE:/ gv_num2.

*WRITE:/ gv_num3.

*WRITE:/ gv_num4.

*WRITE:/ gv_num5.

*WRITE:/ gv_num6.

*WRITE:/ gv_num7.

*WRITE:/ gv_num8.

*

*DATA: GV_TEXT1 VALUE 'A'.

*DATA: GV_TEXT2 LENGTH 3 TYPE c VALUE 'ABC'.

*DATA: GV_TEXT3(5) TYPE c VALUE 'ABCDE'.

*DATA: GV_TEXT4 TYPE string VALUE 'ABCDE'.

*DATA: GV_LEN TYPE i.

*

*DATA: GV_TIME TYPE t.

*

*DATA: GV_DATE TYPE d.

*

*GV_TIME = SY-UZEIT.

*GV_DATE = SY-DATUM.

*GV_LEN = STRLEN(GV_TEXT3).

*

*WRITE: GV_TEXT1.

*WRITE:/ GV_TEXT2.

*WRITE:/ GV_TEXT3.

*WRITE:/ GV_TEXT4.

*WRITE:/ GV_LEN.

*WRITE:/ GV_TIME.

*WRITE:/ GV_DATE.





** char ##

*

** FIND ##

**DATA: TEXT1 TYPE string,

**      TEXT2.

**TEXT1 = 'ABAP'.

**TEXT2 = 'B'.

**FIND TEXT2 IN TEXT1.

**

**IF SY-SUBRC = 0.

**  WRITE TEXT2.

**ENDIF

*

** REPLACE ##

*"DATA: TEXT1 TYPE string,

*"      TEXT2(4).

*"TEXT1 = 'ABAP'.

*"TEXT2 = 'BBAP'.

*"REPLACE TEXT1 IN TEXT1 WITH TEXT2.

*"WRITE TEXT1.

*

** TRANSLATE ##

*"DATA: TEXT1(4),

*"      TEXT2(4).

*"TEXT1 = 'ABAP'.

*"TEXT2 = 'abap'.

*"TRANSLATE TEXT1 TO LOWER CASE.

*"TRANSLATE TEXT2 TO UPPER CASE.

*"WRITE: TEXT1.

*"WRITE:/ TEXT2.

*

** SHIFT ##

*"DATA: TEXT1(5),

*"      TEXT2(5).

*"TEXT1 = ' ABAP'.

*"TEXT2 = ' ABAP'.

*"SHIFT TEXT1.

*"WRITE: TEXT1.

*"WRITE:/ TEXT2.

*

** CONDENSE ##

*"DATA: TEXT1(7) VALUE 'AB   AP',

*"      TEXT2(7) VALUE 'AB   AP',

*"      TEXT3(7) VALUE 'AB   AP'.

*"CONDENSE TEXT1.

*"CONDENSE TEXT2 NO-GAPS.

*"WRITE: TEXT1.

*"WRITE:/ TEXT2.

*"WRITE:/ TEXT3.

*

** OVERLAY ##

*"DATA: TEXT1 TYPE string VALUE ' b p',

*"      TEXT2(4) VALUE 'AAAA'.

*"OVERLAY TEXT1 WITH TEXT2.

*"WRITE: TEXT1.

*"WRITE:/ TEXT2.

*

** CONCATENATE ##

*"DATA: TEXT1 TYPE string VALUE 'AB',

*"      TEXT2(2) VALUE 'AP',

*"      TEXT3 TYPE string.

*"CONCATENATE TEXT1 TEXT2 INTO TEXT3.

*"WRITE: TEXT1.

*"WRITE:/ TEXT2.

*"WRITE:/ TEXT3.

*

** SPLIT ##

*"DATA: TEXT1 TYPE string,

*"      TEXT2(2) TYPE C,

*"      TEXT3(2) TYPE c.

*"TEXT1 = 'AB+AP'.

*"SPLIT TEXT1 AT '+' INTO TEXT2 TEXT3.

*"WRITE: TEXT1.

*"WRITE:/ TEXT2.

*"WRITE:/ TEXT3.



* ####

*DATA: gv_num1 TYPE i VALUE 5,

*      gv_num2 TYPE i VALUE 3,

*      gv_num3 TYPE i.

*gv_num3 = gv_num1 + gv_num2.

*Write: gv_num3.

*gv_num3 = gv_num1 - gv_num2.

*Write:/ gv_num3.

*gv_num3 = gv_num1 * gv_num2.

*Write:/ gv_num3.

*gv_num3 = gv_num1 / gv_num2.

*Write:/ gv_num3.

*gv_num3 = gv_num1 DIV gv_num2.

*Write:/ gv_num3.

*gv_num3 = gv_num1 MOD gv_num2.

*Write:/ gv_num3.

*gv_num3 = gv_num1 ** gv_num2.

*Write:/ gv_num3.



* Local data type



* Type ##

*TYPES T_HELLO(20) TYPE c.     " T_HELLO ## ### ## ##

*

*DATA GV_TEXT1 TYPE T_HELLO.   " TYPE(T_HELLO)# #### ##(object) ##

*DATA GV_TEXT2 LIKE GV_TEXT1.  " DATA Object# #### ##(object) ##

*

*GV_TEXT1 = '#####'.

*GV_TEXT2 = '#####'.

*

*WRITE: GV_TEXT1.

*WRITE:/ GV_TEXT2.



*"Structured TYPE ##: ### #### -> ####

*"### ## ##

*TYPES: BEGIN OF T_ZEDT20,

*  ZCODE TYPE c LENGTH 10,

*  ZKNAME TYPE c LENGTH 20,

*  ZENAME TYPE c LENGTH 20,

*END OF T_ZEDT20.

*"### ## ##

*DATA: GS_ZEDT20 TYPE T_ZEDT20.

*GS_ZEDT20-ZCODE = 'SSU-01'.

*GS_ZEDT20-ZKNAME = '###'.

*GS_ZEDT20-ZENAME = 'DONG'.

*

*WRITE:/ GS_ZEDT20-ZCODE.

*WRITE:/ GS_ZEDT20-ZKNAME.

*WRITE:/ GS_ZEDT20-ZENAME.






"Structured TYPE ##: ### ##, Nested ## ## -> ### ####




*"### ## ##

*TYPES: BEGIN OF T_ZEDT20,  " #### ###

*  ZCODE TYPE c LENGTH 10,

*  ZKNAME TYPE c LENGTH 20,

*  ZENAME TYPE c LENGTH 20,

*END OF T_ZEDT20.

*

*TYPES: BEGIN OF T_ZEDT20_2, " #### ### + ####

*  INCLUDE TYPE T_ZEDT20.

*  TYPES: TITLE TYPE c LENGTH 10,

*         GRADE TYPE C LENGTH 1,

*END OF T_ZEDT20_2.

*"### ####

*DATA: GS_ZEDT20 TYPE T_ZEDT20_2.

*

*GS_ZEDT20-ZCODE = 'SSU-01'.

*GS_ZEDT20-ZKNAME = '###'.

*GS_ZEDT20-ZENAME = 'DONG'.

*GS_ZEDT20-TITLE = '####'.

*GS_ZEDT20-GRADE = '3'.

*

*WRITE:/ GS_ZEDT20-ZCODE.

*WRITE:/ GS_ZEDT20-ZKNAME.

*WRITE:/ GS_ZEDT20-ZENAME.

*WRITE:/ GS_ZEDT20-TITLE.

*WRITE:/ GS_ZEDT20-GRADE.



*"Structured TYPE ##: DATA BEGIN OF ~END OF

*"### ## ##

*DATA: BEGIN OF GS_ZEDT20, "#### ###

*  ZCODE TYPE c LENGTH 10,

*  ZKNAME TYPE c LENGTH 20,

*  ZENAME TYPE c LENGTH 20,

*END OF GS_ZEDT20.

*

*GS_ZEDT20-ZCODE = 'SSU-01'.

*GS_ZEDT20-ZKNAME = '###'.

*GS_ZEDT20-ZENAME = 'DONG'.

*

*WRITE:/ GS_ZEDT20-ZCODE.

*WRITE:/ GS_ZEDT20-ZKNAME.

*WRITE:/ GS_ZEDT20-ZENAME.



*"Structured TYPE ##: BEGIN OF, Nested TYPE ## ~END OF

*"### ## ##

*DATA: BEGIN OF GS_ZEDT20,  " #### ###

*  ZCODE TYPE c LENGTH 10,

*  ZKNAME TYPE c LENGTH 20,

*  ZENAME TYPE c LENGTH 20,

*END OF GS_ZEDT20.

*

*DATA: BEGIN OF GS_ZEDT20_2. " #### ### + ####

*  INCLUDE STRUCTURE GS_ZEDT20.

*  data: TITLE TYPE c LENGTH 10,

*         GRADE TYPE C LENGTH 1,

*END OF GS_ZEDT20_2.

*

*GS_ZEDT20_2-ZCODE = 'SSU-01'.

*GS_ZEDT20_2-ZKNAME = '###'.

*GS_ZEDT20_2-ZENAME = 'DONG'.

*GS_ZEDT20_2-TITLE = '####'.

*GS_ZEDT20_2-GRADE = '3'.

*

*WRITE:/ GS_ZEDT20_2-ZCODE.

*WRITE:/ GS_ZEDT20_2-ZKNAME.

*WRITE:/ GS_ZEDT20_2-ZENAME.

*WRITE:/ GS_ZEDT20_2-TITLE.

*WRITE:/ GS_ZEDT20_2-GRADE.