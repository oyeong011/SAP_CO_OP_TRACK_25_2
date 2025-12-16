
*&---------------------------------------------------------------------*

*& Report ZEDR16_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_001.



" 1. Predefined ABAP TYPE p.6

DATA : gv_num1 TYPE p VALUE '1234'.

DATA : gv_num2 TYPE p DECIMALS 2 VALUE '12.34'.



DATA : gv_num3 TYPE i VALUE 1234.



DATA : gv_num4 TYPE N VALUE 1234.

DATA : gv_num5 TYPE N LENGTH 2 VALUE 1234.

DATA : gv_num6 TYPE N LENGTH 3 VALUE 1234.

DATA : gv_num7 TYPE N LENGTH 4 VALUE 1234.



WRITE : gv_num1.

WRITE :/ gv_num3.

WRITE :/ gv_num4.

WRITE :/ gv_num5.

WRITE :/ gv_num6.

WRITE :/ gv_num7.



" 1. Predefined ABAP TYPE p.8

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





" Predefined ABAP TYPE p.10

DATA : TEXT1 TYPE STRING,

      TEXT2(4) TYPE C.



TEXT1 = 'ABAP'.

TEXT2 = 'B'.



FIND TEXT2 IN TEXT1.



IF SY-SUBRC = 0.

  WRITE TEXT2.

ENDIF.





" Predefined ABAP TPYE p.11

"DATA : TEXT1 TYPE STRING,

 "     TEXT2(4) TYPE C.



TEXT1 = 'ABAP'.

TEXT2 = 'BBAP'.



REPLACE TEXT1 IN TEXT1 WITH TEXT2.

WRITE : TEXT1.





" Predefined ABAP TPYE p.12



 TEXT1 = 'ABAP'.

 TEXT2 = 'abap'.



 TRANSLATE TEXT1 TO LOWER CASE.

 TRANSLATE TEXT2 To UPPER CASE.

 WRITE : TEXT1.

 WRITE :/ TEXT2.



 " Predefined ABAP TPYE p.13

 TEXT1 = ' ABAP'.

 TEXT2 = 'ABAP'.

 SHIFT TEXT1.

 WRITE :/ TEXT1.

 WRITE :/ TEXT2.





 " Predefined ABAP TPYE p.14



DATA : TEXT14 TYPE STRING,

      TEXT24(8) TYPE C,

      TEXT34(8) TYPE C.



 TEXT14 = 'AB   AP'.

 TEXT24 = 'AB   AP'.

 TEXT34 = 'AB   AP'.



 CONDENSE TEXT14.

 CONDENSE TEXT24 NO-GAPS.



 WRITE : TEXT14.

 WRITE :/ TEXT24.

 WRITE :/ TEXT34.







  " Predefined ABAP TPYE p.15



 DATA : TEXT15 TYPE STRING,

       TEXT25(8) TYPE C.



 TEXT15 = ' B P'.

 TEXT25 = 'AAAA'.



 OVERLAY TEXT15 WITH TEXT25.



 WRITE : TEXT15.

 WRITE :/ TEXT25.



   " Predefined ABAP TPYE p.16



 DATA : TEXT16 TYPE STRING,

       TEXT26(4) TYPE C,

       TEXT36(4) TYPE C.



 TEXT16 = 'AB'.

 TEXT26 = 'AP'.



 CONCATENATE TEXT16 TEXT26 INTO TEXT36.



 WRITE : TEXT36.

 WRITE :/ TEXT26.

 WRITE :/ TEXT36.



 " Predefined ABAP TYPE p.17



 DATA : TEXT17 TYPE STRING,

       TEXT27(4) TYPE C,

       TEXT37(4) TYPE C.



 TEXT1 = 'AB+AP'.

 SPLIT TEXT17 AT '+' INTO TEXT27 TEXT37.



 WRITE : TEXT17.

 WRITE :/ TEXT27.

 WRITE :/ TEXT37.



  " Predefined ABAP TYPE p.19



 DATA : gv_num19 TYPE i VALUE 5,

       gv_num29 TYPE i VALUE 3,

       gv_num39 TYPE i.



 gv_num39 = gv_num19 + gv_num29.

 WRITE : gv_num39.



  gv_num39 = gv_num19 - gv_num29.

 WRITE : gv_num39.



  gv_num39 = gv_num19 * gv_num29.

 WRITE : gv_num39.



  gv_num39 = gv_num19 / gv_num29.

 WRITE : gv_num39.



  gv_num39 = gv_num19 DIV gv_num29.

 WRITE : gv_num39.



  gv_num39 = gv_num19 MOD gv_num29.

 WRITE : gv_num39.



  gv_num39 = gv_num19 ** gv_num29.

 WRITE : gv_num39.



 " Local Data Type in program p.22

 TYPES T_HELLO(20) TYPE C.



 DATA GV_TEXT122 TYPE T_HELLO.

 DATA GV_TEXT222 LIKE GV_TEXT122.



 GV_TEXT122 = '#####'.

 GV_TEXT222 = '#####'.



WRITE : GV_TEXT122.

WRITE :/ GV_TEXT222.





" Local Data Type in program p.24



TYPES : BEGIN OF T_ZEDT16,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT16.



DATA : GS_ZEDT16 TYPE T_ZEDT16.



GS_ZEDT16-ZCODE = 'SSU-01'.

GS_ZEDT16-ZKNAME = '###'.

GS_ZEDT16-ZENAME = 'DONG'.



WRITE : / GS_ZEDT16-ZCODE.

WRITE : / GS_ZEDT16-ZKNAME.

WRITE : / GS_ZEDT16-ZENAME.



" Local Data Type in program p.25



TYPES : BEGIN OF T_ZEDT16_2.

  INCLUDE TYPE T_ZEDT16.

  TYPES : TITLE TYPE C LENGTH 10,

  GRADE TYPE C LENGTH 1,

  END OF T_ZEDT16_2.





DATA : GS_ZEDT1625 TYPE T_ZEDT16_2.



GS_ZEDT1625-ZCODE = 'SSU-01'.

GS_ZEDT1625-ZKNAME = '###'.

GS_ZEDT1625-ZENAME = 'DONG'.

GS_ZEDT1625-TITLE = '####'.

GS_ZEDT1625-GRADE = '3'.



WRITE : / GS_ZEDT1625-ZCODE.

WRITE : / GS_ZEDT1625-ZKNAME.

WRITE : / GS_ZEDT1625-ZENAME.

WRITE : / GS_ZEDT1625-TITLE.

WRITE : / GS_ZEDT1625-GRADE.



" Local Data Type in program p.26



DATA : BEGIN OF T_ZEDT16,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT16.



GS_ZEDT16-ZCODE = 'SSU-01'.

GS_ZEDT16-ZKNAME = '###'.

GS_ZEDT16-ZENAME = 'DONG'.



WRITE : / GS_ZEDT16-ZCODE.

WRITE : / GS_ZEDT16-ZKNAME.

WRITE : / GS_ZEDT16-ZENAME.





" Local Data Type in program p.27



DATA : BEGIN OF GS_ZEDT16_227.

  INCLUDE STRUCTURE GS_ZEDT16.

  DATA : TITLE TYPE C LENGTH 10,

        GRADE TYPE C LENGTH 1,

        END OF GS_ZEDT16_227.



GS_ZEDT16_227-ZCODE = 'SSU-01'.

GS_ZEDT16_227-ZKNAME = '###'.

GS_ZEDT16_227-ZENAME = 'DONG'.

GS_ZEDT16_227-TITLE = '####'.

GS_ZEDT16_227-GRADE = '3'.







WRITE : / GS_ZEDT16_227-ZCODE.

WRITE : / GS_ZEDT16_227-ZKNAME.

WRITE : / GS_ZEDT16_227-ZENAME.

WRITE : / GS_ZEDT16_227-TITLE.

WRITE : / GS_ZEDT16_227-GRADE.