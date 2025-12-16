
*&---------------------------------------------------------------------*

*& Report ZEDR018_009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_009.

data : BEGIN OF gs_student.

  include structure
zedt018_001
.

  data : END OF gs_student.

data : gt_student like TABLE OF gs_student.



SELECT * FROM ZEDT00_001

INTO CORRESPONDING FIELDS OF TABLE gt_student.



insert zedt018_001 from table gt_student.







if sy-subrc = 0.

  write :/ '##'.

endif.