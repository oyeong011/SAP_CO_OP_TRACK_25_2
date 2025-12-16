
*&---------------------------------------------------------------------*

*& Report ZEDR01_013

*&---------------------------------------------------------------------*

*& ### ##

*&---------------------------------------------------------------------*




REPORT ZEDR01_013.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT01_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_ZCODE LIKE ZEDT01_001-ZCODE.

DATA : GV_ZKNAME LIKE ZEDT01_001-ZKNAME.




*&---------------------------------------------------------------------*

*& ### ##

*&---------------------------------------------------------------------*



*GV_ZCODE = 'SSU-02'.

*GS_STUDENT-ZCODE = 'SSU-03'.



*&---------------------------------------------------------------------*

*& FORM ##

*&---------------------------------------------------------------------*



*PERFORM GET_DATA USING GV_ZCODE

*                 CHANGING GV_ZKNAME.



*PERFORM GET_DATA USING GS_STUDENT.



*PERFORM GET_DATA USING GS_STUDENT

*                       GT_STUDENT.






PERFORM GET_DATA USING GT_STUDENT.






*PERFORM GET_DATA TABLES GT_STUDENT.



*&---------------------------------------------------------------------*

*& ##

*&---------------------------------------------------------------------*



*WRITE : / GV_ZCODE , GV_ZKNAME.






LOOP AT GT_STUDENT INTO GS_STUDENT.



  WRITE : / GS_STUDENT-ZCODE , GS_STUDENT-ZKNAME.



ENDLOOP.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*



*FORM GET_DATA USING P_ZCODE

*              CHANGING VALUE(P_ZKNAME).

*

**  DATA : LV_ZCODE TYPE ZEDT01_001-ZCODE.

**  LV_ZCODE = 'SSU-10'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT01_001

*  INTO P_ZKNAME

*  WHERE ZCODE = P_ZCODE.

*

*  WRITE :/ 'PERFORM COMPLETE'.

*ENDFORM.



*FORM GET_DATA USING PS_STUDENT STRUCTURE GS_STUDENT.

*

*  SELECT SINGLE ZKNAME FROM ZEDT01_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = PS_STUDENT-ZCODE.

*

*  WRITE :/ 'PERFORM COMPLETE'.

*ENDFORM.



*FORM GET_DATA USING PS_STUDENT STRUCTURE GS_STUDENT

*                    PT_STUDENT LIKE GT_STUDENT.

*

*  PS_STUDENT-ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT01_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = PS_STUDENT-ZCODE.

*  APPEND PS_STUDENT TO PT_STUDENT.

*

*  PS_STUDENT-ZCODE = 'SSU-02'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT01_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = PS_STUDENT-ZCODE.

*  APPEND PS_STUDENT TO PT_STUDENT.

*

*  WRITE :/ 'PERFORM COMPLETE'.

*ENDFORM.






FORM GET_DATA USING PT_STUDENT TYPE STANDARD TABLE.




*FORM GET_DATA TABLES PT_STUDENT LIKE GT_STUDENT.






  DATA : LT_STUDENT LIKE GS_STUDENT.



  LT_STUDENT-ZCODE = 'SSU-01'.



  SELECT SINGLE ZKNAME FROM ZEDT01_001

    INTO LT_STUDENT-ZKNAME

    WHERE ZCODE = LT_STUDENT-ZCODE.

  APPEND LT_STUDENT TO PT_STUDENT.



  LT_STUDENT-ZCODE = 'SSU-02'.



  SELECT SINGLE ZKNAME FROM ZEDT01_001

    INTO LT_STUDENT-ZKNAME

    WHERE ZCODE = LT_STUDENT-ZCODE.

  APPEND LT_STUDENT TO PT_STUDENT.



  WRITE :/ 'PERFORM COMPLETE'.

ENDFORM.