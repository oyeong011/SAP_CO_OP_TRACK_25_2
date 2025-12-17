
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_practice004.



DATA : gs_student TYPE zedt16_001.

DATA : gt_student LIKE TABLE OF gs_student.



RANGES gr_range FOR zedt16_001-zcode.



gr_range-sign = 'I'.

gr_range-option = 'BT'.

gr_range-low = 'SSU-90'.

gr_range-high = 'SSU-99'.

APPEND gr_range.



SELECT * FROM zedt00_001

  INTO CORRESPONDING FIELDS OF TABLE gt_student

  WHERE zcode IN gr_range.



LOOP AT gt_student INTO gs_student.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING

      input  = gs_student-zpernr

    IMPORTING

      output = gs_student-zpernr.



  MODIFY gt_student FROM gs_student.

  CLEAR gs_student.

ENDLOOP.



MODIFY zedt16_001 FROM TABLE gt_student.



IF sy-subrc = 0.

  WRITE :/ '##'.

ENDIF.