
*&---------------------------------------------------------------------*

*& Report ZEDR12_PERFORM004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PERFORM004.

DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



  DATA: GV_ZCODE LIKE ZEDT12_001-ZCODE.

  DATA: GV_ZKNAME LIKE ZEDT12_001-ZKNAME.





"1. SUBROUTINE : PERFORM ##

"#### ## ##-3) USING ###

"#### ## ##-1) USING : FORM [FORM_NAME] USING P1 TYPE type

PERFORM GET_DATA USING GS_STUDENT

                       GT_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

 WRITE:/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA USING PS_STUDENT STRUCTURE GS_STUDENT "### ## ### ##

                    PT_STUDENT LIKE GT_STUDENT.

  PS_STUDENT-ZCODE = 'SSU-01'.

  SELECT SINGLE ZKNAME FROM ZEDT12_001

    INTO PS_STUDENT-ZKNAME

    WHERE ZCODE = PS_STUDENT-ZCODE.

    APPEND PS_STUDENT TO PT_STUDENT.



  PS_STUDENT-ZCODE = 'SSU-02'.

  SELECT SINGLE ZKNAME FROM ZEDT12_001

    INTO PS_STUDENT-ZKNAME

    WHERE ZCODE = PS_STUDENT-ZCODE.

    APPEND PS_STUDENT TO PT_STUDENT.



ENDFORM.