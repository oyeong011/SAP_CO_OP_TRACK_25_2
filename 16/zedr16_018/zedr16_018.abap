
*&---------------------------------------------------------------------*

*& Report ZEDR16_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_018.



DATA : BEGIN OF gs_student.

    include structure
zedt16_001
.

DATA : END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student.



DATA : gv_zcode LIKE zedt16_001-zcode.

DATA : gv_zkname LIKE zedt16_001-zkname.






*gs_student-zcode = 'SSU-01'.






PERFORM get_data CHANGING gt_student.



LOOP AT gt_student INTO gs_student.

  WRITE :/ gs_student-zcode, gs_student-zkname.

ENDLOOP.




*

*WRITE :/ gs_student-zcode.

*WRITE :/ gs_student-zkname.





*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data CHANGING pt_student LIKE gt_student.



  DATA : ls_student LIKE gs_student.



  ls_student-zcode = 'SSU-01'.



  SELECT SINGLE zkname FROM zedt16_001

    INTO ls_student-zkname

    WHERE zcode = ls_student-zcode.

  APPEND ls_student TO pt_student.



  ls_student-zcode = 'SSU-02'.



  SELECT SINGLE zkname FROM zedt16_001

    INTO ls_student-zkname

    WHERE zcode = ls_student-zcode.

  APPEND ls_student TO pt_student.







ENDFORM.