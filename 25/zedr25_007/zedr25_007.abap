
*&---------------------------------------------------------------------*

*& Report ZEDR25_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*








REPORT ZEDR25_007.



" at ##



DATA : BEGIN OF gs_student,

         zpernr  LIKE zedt25_001-zpernr,

         zcode   LIKE zedt25_001-zcode,

         zkname  LIKE zedt25_001-zkname,

         zename  LIKE zedt25_001-zename,

         zgender LIKE zedt25_001-zgender,

         zgname  TYPE c LENGTH 4,

         ztel    LIKE zedt25_001-ztel,

       END OF gs_student.



DATA : gt_student LIKE TABLE OF gs_student.



" #### ##### ###

CLEAR : gs_student, gt_student.



" ## 1

gs_student-zpernr  = '0000000001'.

gs_student-zcode   = 'SSU-01'.

gs_student-zkname  = '###'.

gs_student-zename  = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel    = '01011112222'.

APPEND gs_student TO gt_student.



gs_student-zpernr  = '0000000001'.

gs_student-zcode   = 'SSU-01'.

gs_student-zkname  = '###'.

gs_student-zename  = 'DON'.

gs_student-zgender = 'M'.

gs_student-ztel    = '01011112222'.

APPEND gs_student TO gt_student.



gs_student-zpernr  = '0000000001'.

gs_student-zcode   = 'SSU-01'.

gs_student-zkname  = '###'.

gs_student-zename  = 'KIM'.

gs_student-zgender = 'M'.

gs_student-ztel    = '01011112222'.

APPEND gs_student TO gt_student.



" ## 2

CLEAR gs_student.

gs_student-zpernr  = '0000000002'.

gs_student-zcode   = 'SSU-02'.

gs_student-zkname  = '###'.

gs_student-zename  = 'HOON'.

gs_student-zgender = 'M'.

gs_student-ztel    = '01022223333'.

APPEND gs_student TO gt_student.



" ## 3

CLEAR gs_student.

gs_student-zpernr  = '0000000003'.

gs_student-zcode   = 'SSU-03'.

gs_student-zkname  = '###'.

gs_student-zename  = 'SON'.

gs_student-zgender = 'F'.

gs_student-ztel    = '01033334444'.

APPEND gs_student TO gt_student.



BREAK-POINT.






*LOOP AT gt_student INTO gs_student.

*  gs_student-zgname = '####'.

*

*  " AT FIRST.

*  " AT LAST.

*  AT NEW ZENAME.

*  gs_student-zgname = '####'.

*  ENDAT.

*

*  CLEAR : gs_student.

*ENDLOOP.






CLEAR : gs_student.

SORT gt_student by zcode zkname zename zgender.



LOOP AT gt_student INTO gs_student.

  gs_student-zgname = '####'.



  " AT FIRST.

  " AT LAST.

  " AT NEW ZENAME.



  AT END OF zename.



  gs_student-zgname = '####'.

  ENDAT.

  CLEAR : gs_student.

ENDLOOP.