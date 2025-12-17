
*&---------------------------------------------------------------------*

*& Report ZEDR12_PERFORM003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PERFORM003.

DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



  DATA: GV_ZCODE LIKE ZEDT12_001-ZCODE.

  DATA: GV_ZKNAME LIKE ZEDT12_001-ZKNAME.



  GV_ZCODE = 'SSU-03'.





"1. SUBROUTINE : PERFORM ##

"#### ## ##-3) CHANGING : FORM [FORM_NAME] CHANGING P3 TYPE type

PERFORM GET_DATA USING GV_ZCODE       "USING : ######

                 CHANGING GV_ZKNAME.  "CHANGING : ##########

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




FORM GET_DATA USING P_ZCODE LIKE ZEDT12_001-ZCODE

              CHANGING P_ZKNAME  LIKE ZEDT12_001-ZKNAME. "ACTUAL PARAM# #### TYPE C ##.



  SELECT SINGLE ZKNAME FROM ZEDT12_001

    INTO P_ZKNAME

    WHERE ZCODE = P_ZCODE.



ENDFORM. "ENDFORM## Subroutine## #, # ##