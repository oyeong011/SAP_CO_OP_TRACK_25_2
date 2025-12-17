
*&---------------------------------------------------------------------*

*& Report ZEDR07_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_012.






************************************************************************




"external ##






*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*  DATA : END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*PERFORM get_data(zedr07_011) IF FOUND CHANGING gt_student.

*

*LOOP AT gt_student INTO gs_student.

*  WRITE :/ gs_student-zcode, gs_student-zkname.

*ENDLOOP.



************************************************************************




"dynamic ##



DATA : BEGIN OF gs_student.

  include structure
zedt07_001
.

  DATA : END OF gs_student.



DATA : gt_student LIKE TABLE OF gs_student.



DATA : gv_pname(20) VALUE 'ZEDR07_011'. "## ### ### ## ### ###!

DATA : gv_formname(20) VALUE 'GET_DATA'.



PERFORM (gv_formname) IN PROGRAM (gv_pname) IF FOUND CHANGING gt_student.



LOOP AT gt_student INTO gs_student.

  WRITE :/ gs_student-zcode, gs_student-zkname.

ENDLOOP.