
*&---------------------------------------------------------------------*

*& Report ZEDR23_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT ZEDR23_001.

" Naming Rule

" GV : ## ##

" GS_ : Structure ## / DATA

" GT :

" T_ : ## ##  / TYPES

DATA : gv_num0.                                 " TYPE C LENGTH 1 NULL #

DATA : gv_num1 TYPE p VALUE '1234'.

DATA : gv_num2 TYPE p DECIMALS 2 VALUE '1234'.  "VALUE : initial #, ### NULL

DATA : gv_num3 TYPE n VALUE 1234,

      gv_num4(2) TYPE n VALUE 1234,

      gv_num5 TYPE n LENGTH 3 VALUE 1234.



DATA : gv_time TYPE t.

gv_time = SY-UZEIT.

DATA : gv_date TYPE d.

gv_date = SY-DATUM.



WRITE : gv_num0,

/ gv_num1,

/ gv_num2,

/ gv_num3,

/ gv_num4,

/ gv_num5,

/ gv_time,

/ gv_date.



DATA : TEXT1 TYPE STRING,

      TEXT2(4) TYPE C,       "TYPE C, N, P # ## ##

      TEXT3(4) TYPE C.



TEXT1 = 'AB'.

TEXT2 = 'AP'.



FIND 'A' IN TEXT2.

IF SY-SUBRC = 0. " ##=0, ######=4

  WRITE : / TEXT2. "AP

  ENDIF.



REPLACE 'P' IN TEXT2 WITH 'B'.

  WRITE : / TEXT2.  "AB



TRANSLATE TEXT2 TO LOWER CASE.  "UPPER CASE : ###

WRITE : / TEXT2.  "ab





SHIFT TEXT2.

SHIFT TEXT2 BY 2 PLACES RIGHT.

WRITE : / TEXT2.  " '  b'



CONDENSE TEXT2. " ## ## ##, ## ## ## ##

CONDENSE TEXT2 NO-GAPS. " ## ## ##

WRITE : / TEXT2.  " 'b'



TEXT1 = '  AP'.

TEXT2 = 'ABOO'.

OVERLAY TEXT1 WITH TEXT2.

WRITE : / TEXT1.  " 'ABAP'



TEXT1 = 'AB+AP'.

SPLIT TEXT1 AT '+' INTO TEXT2 TEXT3.

WRITE : / TEXT1.

CONCATENATE TEXT2 TEXT3 INTO TEXT1. " SEPARATED BY ' ' => ## ##

WRITE : / TEXT1.  "## TEXT1 ### ##



" ### TYPE ## (# DEFINE)

TYPES T_HELLO(20) TYPE C.

DATA GV_DATA TYPE T_HELLO.

GV_DATA = 'HELLO'.

WRITE : / GV_DATA.



" 1. ### ## ## / ## ### ## ## ##

TYPES : BEGIN OF T_ZEDT23,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT23.



" (INCLUDE)

 TYPES : BEGIN OF T_ZED23_2.  " '.' # TYPES : # ##

   INCLUDE TYPE T_ZEDT23.

   TYPES :

   TITLE(10) TYPE C,

   GRADE(1) TYPE C,

   END OF T_ZED23_2.



DATA : GS_ZEDT23 TYPE T_ZED23_2. " ### ## ##



  GS_ZEDT23-ZCODE = 'SSU-01'.

  GS_ZEDT23-ZKNAME = '###'.

  GS_ZEDT23-ZENAME = 'Kang'.

  GS_ZEDT23-TITLE = '#####'.

  GS_ZEDT23-GRADE = 'F'.



  WRITE : /,

  / GS_ZEDT23-ZCODE,

  / GS_ZEDT23-ZKNAME,

  / GS_ZEDT23-ZENAME,

  / GS_ZEDT23-TITLE,

  / GS_ZEDT23-GRADE,

  / '# ##~~!!'.



" 2. TYPE ### ### ### ## ##

DATA : BEGIN OF GS_ZEDT23_3,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT23_3.



DATA : BEGIN OF GS_ZEDT23_4.

  INCLUDE STRUCTURE GS_ZEDT23_3.

  DATA : TITLE TYPE C LENGTH 10,

        GRADE TYPE C LENGTH 1,

        END OF GS_ZEDT23_4.