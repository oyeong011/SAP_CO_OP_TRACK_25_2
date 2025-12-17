
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE004.



"### ####

TABLES : ZEDT00_001, ZEDT02_001.



"RANGE ## ##

RANGES : GR_CODE FOR ZEDT00_001-ZCODE.



"### ### ##

DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT00_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



GR_CODE-SIGN = 'I'. "##

GR_CODE-OPTION = 'BT'. "BETWEEN

GR_CODE-LOW = 'SSU-90'. "90##

GR_CODE-HIGH = 'SSU-99'. "99##

APPEND GR_CODE.



"RANGE ### #### SELECT

SELECT * FROM ZEDT00_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN GR_CODE.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  "0# ## #### FUNCTION

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      INPUT         = GS_STUDENT-ZPERNR

   IMPORTING

     OUTPUT        = GS_STUDENT-ZPERNR

  .



  "### ### # ##

  MODIFY GT_STUDENT FROM GS_STUDENT.

ENDLOOP.



IF SY-SUBRC = 0.

  "INSERT ZEDT02_001 FROM TABLE GT_STUDENT. "ZEDT02_001# ### #### ##

  MODIFY ZEDT02_001 FROM TABLE GT_STUDENT.

ENDIF.