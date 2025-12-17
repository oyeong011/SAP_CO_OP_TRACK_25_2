
*&---------------------------------------------------------------------*

*& Report ZEDR12_PERFORM001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PERFORM001.

DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



  DATA: GV_ZCODE LIKE ZEDT12_001-ZCODE.

  DATA: GV_ZKNAME LIKE ZEDT12_001-ZKNAME.



  GV_ZCODE = 'SSU-01'.



"1. SUBROUTINE : PERFORM ##

"#### ## ##-1) USING : FORM [FORM_NAME] USING P1 TYPE type

PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME. "ACTUAL PARAM(#### ##). Subroutine## #, # ##

 WRITE:/ GV_ZCODE.

 WRITE:/ GV_ZKNAME.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA USING P_ZCODE P_ZKNAME. "FORMAL PARAM(## ##). Subroutine## #, # ##

  SELECT SINGLE ZKNAME FROM ZEDT12_001

  INTO P_ZKNAME

  WHERE ZCODE = P_ZCODE.

ENDFORM. "ENDFORM## Subroutine## #, # ##