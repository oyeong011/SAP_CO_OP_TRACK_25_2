
*&---------------------------------------------------------------------*

*& Report ZEDR24_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_003.







CONSTANTS : C_RATE TYPE I VALUE '100'.

DATA : GV_SUM1 TYPE I,

       GV_SUM2 TYPE I,

       GV_SUM3 TYPE I.



GV_SUM1 = '10.00'. "1000### ##### #.

GV_SUM2 = '20.00'. "2000### ##### #.

GV_SUM3 = '30.00'. "3000### ##### #.



GV_SUM1 = GV_SUM1 * C_RATE.

GV_SUM2 = GV_SUM2 * C_RATE.

GV_SUM3 = GV_SUM3 * C_RATE.



WRITE : GV_SUM1,

        / GV_SUM2,

        / GV_SUM3.



"---------------------------------

"CONSTANTS : ### ##

SKIP.

SKIP.



CONSTANTS : BEGIN OF C_STUDENT,

  ZCODE(10) VALUE 'SSU-01',

  ZKNAME(10) VALUE '###',

  ZENAME(10) VALUE 'DONG',

  END OF C_STUDENT.



WRITE : C_STUDENT-ZCODE,

        / C_STUDENT-ZKNAME,

        / C_STUDENT-ZENAME.





"---------------------------------

"STATICS : LOCAL### ## ##### ### ## ##

"ex) ## ## ##

SKIP.

SKIP.



FORM practice_statics.

  STATICS lv_cnt TYPE i.

  lv_cnt = lv_cnt + 1.

  WRITE lv_cnt.

ENDFORM.



START-OF-SELECTION.

  WRITE : '### ##'.

  PERFORM practice_statics.

  WRITE : '### ##'.

  PERFORM practice_statics.



"---------------------------------

"TABLES : ## ### ## ####? ## # tables# ### ### ### #### ### #### ##.

SKIP.

SKIP.



TABLES : ZEDT24_001.



SELECT SINGLE * FROM ZEDT24_001.



WRITE :/ ZEDT24_001-ZCODE.

WRITE :/ ZEDT24_001-ZKNAME.

WRITE :/ ZEDT24_001-ZENAME.

WRITE :/ ZEDT24_001-ZGENDER.

WRITE :/ ZEDT24_001-ZTEL.



"---------------------------------

"TABLES :

SKIP.

SKIP.

TABLES : SCARR.



SELECT * FROM SCARR.

  WRITE : / SCARR-CARRID, SCARR-CARRNAME.

ENDSELECT.