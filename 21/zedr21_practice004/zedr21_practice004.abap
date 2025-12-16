
*&---------------------------------------------------------------------*

*& Report ZEDR21_PRACTICE004

*&---------------------------------------------------------------------*

*& Function Module ## - CONVERSION_EXIT_ALPHA_INPUT ##

*&---------------------------------------------------------------------*




REPORT ZEDR21_PRACTICE004.



"---------------------------------------------------------------------

" Function Module ## ##

"---------------------------------------------------------------------

" 1) Subroutine(Form)# Local ### (## #### #### ##)

" 2) Function Module# Global ### (## ###### ### ##)

" 3) Function Group# ### Function## ## #### ####



" ## Function Module ##

"   # Regular Function Module   : ## ##

"   # Remote-Enabled Module      : ## ## ## (RFC)

"   # Update Module              : DB ## ###



" Parameter ## ##

"   IMPORTING  : ### ##

"   EXPORTING  : ### ##

"   CHANGING   : ### ## (## # ##)

"   TABLES     : ## ### ## (#### ## CHANGING ##)

"---------------------------------------------------------------------



DATA : GS_STUDENT TYPE ZEDT21_001.        " ### ##

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT. " ## ### ##



RANGES GR_ZCODE FOR ZEDT21_001-ZCODE21.   " ## ## ## ##



"---------------------------------------------------------------------

" RANGES ##

"---------------------------------------------------------------------

CLEAR GR_ZCODE.

GR_ZCODE-SIGN = 'I'.           " Include (##)

GR_ZCODE-OPTION = 'BT'.        " Between (##)

GR_ZCODE-LOW = 'SSU-90'.       " ###

GR_ZCODE-HIGH = 'SSU-100'.     " ###

APPEND GR_ZCODE.



"---------------------------------------------------------------------

" ### SELECT

"---------------------------------------------------------------------

SELECT * FROM ZEDT21_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE21 IN GR_ZCODE.



"---------------------------------------------------------------------

" ##(ZPERNR21) ## ## - ALPHA INPUT

"---------------------------------------------------------------------

LOOP AT GT_STUDENT INTO GS_STUDENT.



  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT  = GS_STUDENT-ZPERNR21

    IMPORTING

      OUTPUT = GS_STUDENT-ZPERNR21.



  MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

  CLEAR GS_STUDENT.



ENDLOOP.



"---------------------------------------------------------------------

" ### ### #### ##

"---------------------------------------------------------------------

MODIFY ZEDT21_001 FROM TABLE GT_STUDENT.



IF SY-SUBRC = 0.

  WRITE :/ '### #######.'.

ELSE.

  WRITE :/ '## # ### #######.'.

ENDIF.