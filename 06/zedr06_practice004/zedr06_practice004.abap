
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE004.



DATA : GS_STUDENT TYPE ZEDT06_001.            " ## STRUCTURE

DATA : GT_STUDENT TYPE TABLE OF ZEDT06_001.   " ## INTERNAL TABLE



" ### ## ##

RANGES GR_ZCODE FOR ZEDT06_001-ZCODE.



CLEAR GR_ZCODE.

GR_ZCODE-SIGN = 'I'.        " INCLUDE

GR_ZCODE-OPTION = 'BT'.     " BETWENN

GR_ZCODE-LOW = 'SSU-01'.    " ## ##

GR_ZCODE-HIGH = 'SSU-10'.   " ## #

APPEND GR_ZCODE.



" ### #### GT_STUDENT# ##

CLEAR GT_STUDENT.

SELECT * FROM ZEDT06_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN GR_ZCODE.



" CONVERSION_EXIT_ALPHA_INPUT# ### ZPERNR## ALPHA###### 000####

CLEAR GS_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

  EXPORTING

    INPUT         = GS_STUDENT-ZPERNR

  IMPORTING

    OUTPUT        = GS_STUDENT-ZPERNR.



  " INTERNAL TABLE## ####

  MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

  CLEAR GS_STUDENT.

ENDLOOP.



" ## #### # ##

MODIFY ZEDT06_001 FROM TABLE GT_STUDENT.



IF SY-SUBRC = 0.

  WRITE :/ '### ## ##'.

ENDIF.