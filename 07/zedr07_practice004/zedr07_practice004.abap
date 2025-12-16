
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE004.



DATA : gs_student TYPE zedt00_001.

DATA : gt_student LIKE TABLE OF gs_student.



RANGES gr_zcode FOR zedt07_001-zcode.



gr_zcode-sign = 'I'.

gr_zcode-option = 'BT'.

gr_zcode-low = 'SSU-90'. "90##

gr_zcode-high = 'SSU-99'. "99##

APPEND gr_zcode.



SELECT * FROM zedt00_001

  INTO CORRESPONDING FIELDS OF TABLE gt_student "gt_student# 00_001## #### ### ##

  WHERE zcode IN gr_zcode.



LOOP AT gt_student INTO gs_student.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

  EXPORTING

    input = gs_student-zpernr "##

  IMPORTING

    output = gs_student-zpernr. "##



  MODIFY gt_student FROM gs_student INDEX sy-tabix.

  CLEAR gs_student.

ENDLOOP.



MODIFY zedt07_001 FROM TABLE gt_student. "#### ##



IF sy-subrc = 0.

  WRITE :/ '##'.

ENDIF.






*BREAK-POINT.