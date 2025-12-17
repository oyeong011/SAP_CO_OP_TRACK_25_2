
*&---------------------------------------------------------------------*

*& Report ZEDR08_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_PRACTICE004.



"-------------------------------------------------

" 1. ### ##

"-------------------------------------------------

DATA : GS_STUDENT TYPE ZEDT08_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : LT_RANGE TYPE RANGE OF ZCODE,

       LS_RANGE LIKE LINE OF LT_RANGE.



" RANGE # ##

LS_RANGE-SIGN = 'I'.    " INCLUDE

LS_RANGE-OPTION = 'BT'. " BETWEEN

LS_RANGE-LOW = 'SSU-01'. " LOW #

LS_RANGE-HIGH = 'SSU-20'. " HIGH #



" ### ### #### ##

APPEND LS_RANGE TO LT_RANGE.



"-------------------------------------------------

" 2. SELECT

"-------------------------------------------------

SELECT * FROM ZEDT08_001

  INTO TABLE GT_STUDENT

  WHERE ZCODE IN LT_RANGE.



IF SY-SUBRC <> 0.

  WRITE :/ '#### #### ####.'.

  EXIT.

ENDIF.



"-------------------------------------------------

" 3. FUNCTION MODULE# ### ZPERNR ### ## # INSERT

"-------------------------------------------------

LOOP AT GT_STUDENT INTO GS_STUDENT.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'

  "CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT         = GS_STUDENT-ZPERNR

    IMPORTING

      OUTPUT        = GS_STUDENT-ZPERNR.

  MODIFY GT_STUDENT FROM GS_STUDENT TRANSPORTING ZPERNR.

  CLEAR GS_STUDENT.

ENDLOOP.

            .

" ### DB# INSERT

MODIFY ZEDT08_001 FROM TABLE GT_STUDENT.

"INSERT ZEDT08_001 FROM TABLE GT_STUDENT ACCEPTING DUPLICATE KEYS.




*UPDATE ZEDT08_001 FROM TABLE GT_STUDENT.






" ## ### ##### ##### ##

IF SY-SUBRC = 0.

  WRITE :/ '##'.

ELSEIF SY-SUBRC = 4.

  WRITE :/ '##'.

ENDIF.