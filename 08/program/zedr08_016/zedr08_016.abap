
*&---------------------------------------------------------------------*

*& Report ZEDR08_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_016.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT08_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_ZCODE LIKE ZEDT08_001-ZCODE.

DATA : GV_ZKNAME LIKE ZEDT08_001-ZKNAME.



GV_ZCODE = 'SSU-01'.



PERFORM GET_DATA USING GV_ZCODE CHANGING GV_ZKNAME.



GS_STUDENT-ZCODE = 'SSU-08'.



PERFORM GET_DATA01 USING GS_STUDENT GT_STUDENT.



PERFORM GET_DATA02 USING GT_STUDENT.



PERFORM GET_DATA03 TABLES GT_STUDENT.



WRITE :/ GV_ZCODE.

WRITE :/ GV_ZKNAME.



WRITE :/ GS_STUDENT-ZCODE.

WRITE :/ GS_STUDENT-ZKNAME.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




" FORM GET_DATA USING VALUE(P_ZCODE) TYPE C CHANGING P_ZKNAME TYPE C.

FORM GET_DATA USING VALUE(P_ZCODE) LIKE ZEDT08_001-ZCODE CHANGING P_ZKNAME LIKE ZEDT08_001-ZKNAME.



  DATA : LV_ZCODE LIKE ZEDT08_001-ZCODE.

  LV_ZCODE = 'SSU-02'.



  SELECT SINGLE ZKNAME FROM ZEDT08_001 INTO P_ZKNAME WHERE ZCODE = P_ZCODE.



  P_ZCODE = LV_ZCODE.

  P_ZKNAME = 'TEST'.



  WRITE :/ 'PERFORM TEST'.



ENDFORM.



"-----------------------------------------------------------------------




*&---------------------------------------------------------------------*

*&      Form  GET_DATA01

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*----------------------------------------------------------------------*




FORM GET_DATA01  USING    PS_STUDENT STRUCTURE GS_STUDENT PT_STUDENT LIKE GT_STUDENT.



  PS_STUDENT-ZCODE = 'SSU-06'.



  SELECT SINGLE ZKNAME FROM ZEDT08_001

    INTO PS_STUDENT-ZKNAME

    WHERE ZCODE = PS_STUDENT-ZCODE.



  APPEND PS_STUDENT TO PT_STUDENT.



  PS_STUDENT-ZCODE = 'SSU-20'.



  SELECT SINGLE ZKNAME FROM ZEDT08_001

    INTO PS_STUDENT-ZKNAME

    WHERE ZCODE = GS_STUDENT-ZCODE.



  APPEND PS_STUDENT TO PT_STUDENT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA02

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_STUDENT  text

*----------------------------------------------------------------------*




FORM GET_DATA02  USING    PT_STUDENT TYPE STANDARD TABLE.



  DATA : LS_STUDENT LIKE GS_STUDENT.



  LS_STUDENT-ZCODE = 'SSU-11'.



  SELECT SINGLE ZKNAME FROM ZEDT08_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.



  APPEND LS_STUDENT-ZCODE TO PT_STUDENT.



  LS_STUDENT-ZCODE = 'SSU-22'.



  SELECT SINGLE ZKNAME FROM ZEDT08_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.



  APPEND LS_STUDENT TO PT_STUDENT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA03

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_STUDENT  text

*----------------------------------------------------------------------*




FORM GET_DATA03  TABLES   PT_STUDENT LIKE GT_STUDENT.



  DATA : LS_STUDENT LIKE GS_STUDENT.



  LS_STUDENT-ZCODE = 'SSU-15'.



  SELECT SINGLE ZKNAME FROM ZEDT08_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.



  APPEND LS_STUDENT TO PT_STUDENT.



  LS_STUDENT-ZCODE = 'SSU-23'.



  SELECT SINGLE ZKNAME FROM ZEDT08_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.



  APPEND LS_STUDENT TO PT_STUDENT.



ENDFORM.