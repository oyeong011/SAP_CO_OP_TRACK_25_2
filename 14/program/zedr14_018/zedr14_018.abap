
*&---------------------------------------------------------------------*

*& Report ZEDR14_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_018.



"subroutine ##



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT00_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_ZCODE LIKE ZEDT00_001-ZCODE.

DATA : GV_ZKNAME LIKE ZEDT00_001-ZKNAME.



GV_ZCODE = 'SSU-02'.






*PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME.

*PERFORM GET_DATA USING GV_ZCODE CHANGING GV_ZKNAME.






WRITE :/ GV_ZCODE.

WRITE :/ GV_ZKNAME.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






"USING / USING VALUE / CHANGING




*FORM GET_DATA USING VALUE(P_ZCODE) P_ZKNAME.

*FORM GET_DATA USING P_ZCODE CHANGING VALUE(P_ZKNAME).

*FORM GET_DATA USING P_ZCODE TYPE C

*              CHANGING P_ZKNAME TYPE C.

*

*  DATA : LV_ZCODE LIKE ZEDT00_001-ZCODE.

*  LV_ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT00_001

*    INTO P_ZKNAME

*    WHERE ZCODE = P_ZCODE.

*

*  P_ZCODE = LV_ZCODE.

*  P_ZKNAME = 'TEST'.

*

*ENDFORM.

*

*PERFORM GET_DATA_2 USING GS_STUDENT GT_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*ENDLOOP.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA_2

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM GET_DATA_2 USING PS_STUDENT LIKE GS_STUDENT

*                      PT_STUDENT LIKE GT_STUDENT.

*

*  PS_STUDENT-ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT00_001

*  INTO PS_STUDENT-ZKNAME

*  WHERE ZCODE = GS_STUDENT-ZCODE.

*  APPEND PS_STUDENT TO PT_STUDENT.

*

*  PS_STUDENT-ZCODE = 'SSU-02'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT00_001

*  INTO PS_STUDENT-ZKNAME

*  WHERE ZCODE = GS_STUDENT-ZCODE.

*  APPEND PS_STUDENT TO PT_STUDENT.

*

*ENDFORM.






PERFORM GET_DATA_3 CHANGING GT_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_3 CHANGING PT_STUDENT LIKE GT_STUDENT.



  DATA : LS_STUDENT LIKE GS_STUDENT.



  LS_STUDENT-ZCODE = 'SSU-01'.



  SELECT SINGLE ZKNAME FROM ZEDT00_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.

  APPEND LS_STUDENT TO PT_STUDENT.



  LS_STUDENT-ZCODE = 'SSU-02'.



  SELECT SINGLE ZKNAME FROM ZEDT00_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.

  APPEND LS_STUDENT TO PT_STUDENT.



ENDFORM.