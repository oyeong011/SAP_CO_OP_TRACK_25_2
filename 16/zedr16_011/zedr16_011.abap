
*&---------------------------------------------------------------------*

*& Report ZEDR16_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_011.



DATA : BEGIN OF gs_student,

         zpernr  LIKE zedt16_001-zpernr,

         zcode   LIKE zedt16_001-zcode,

         zkname  LIKE zedt16_001-zkname,

         zename  LIKE zedt16_001-zename,

         zgender LIKE zedt16_001-zgender,

         zgname  TYPE c LENGTH 4,

         ztel    LIKE zedt16_001-ztel,

       END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student WITH NON-UNIQUE KEY zcode.



CLEAR : gs_student, gt_student.



gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'F'.

gs_student-ztel = '01011112222'.

APPEND gs_student TO gt_student.



CLEAR : gs_student.

gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'F'.

gs_student-ztel = '01011112222'.

APPEND gs_student TO gt_student.



CLEAR : gs_student.

gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'F'.

gs_student-ztel = '01011112222'.

APPEND gs_student TO gt_student.



CLEAR : gs_student.



SORT gt_student BY zcode zkname zename zgender.





" p.4






*BREAK-POINT.

*

*LOOP AT gt_student INTO gs_student.

*  gs_student-zgname = '####'.

*

*  AT LAST.

*    gs_student-zgname = '####'.

*  ENDAT.

*

*  CLEAR : gs_student.

*

*ENDLOOP.

*

*BREAK-POINT.






" p. 19

BREAK-POINT.



LOOP AT gt_student INTO gs_student.

  gs_student-zgname = '####'.



  AT END OF zename.

    gs_student-zgname = '####'.

  ENDAT.



  CLEAR : gs_student.



ENDLOOP.



BREAK-POINT.