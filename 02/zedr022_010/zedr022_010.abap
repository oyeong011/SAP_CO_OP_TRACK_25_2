
*&---------------------------------------------------------------------*

*& Report ZEDR022_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr022_010.



data : BEGIN OF gs_student.

  include structure
zedt022_001
.

  data : END OF gs_student.

data : gt_student like TABLE OF gs_student.



gs_student-mandt = sy-mandt.

gs_student-zcode = 'SSU-25'.

gs_student-zpernr = '25'.

gs_student-zkname = '###'.

gs_student-zename = 'RI'.

gs_student-zgender = 'F'.

gs_student-ztel = '212-5555-5555'.



insert into zedt022_001 VALUES gs_student.