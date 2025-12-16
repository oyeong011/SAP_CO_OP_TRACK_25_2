
*&---------------------------------------------------------------------*

*& Report ZEDR16_008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_008.



" p.5



DATA : BEGIN OF gs_student,

         zpernr  TYPE c LENGTH 10,

         zcode   TYPE c LENGTH 10,

         zkname  TYPE c LENGTH 10,

         zename  TYPE c LENGTH 10,

         zgender TYPE c LENGTH 1,

         ztel    TYPE c LENGTH 10,

         zgname  TYPE c LENGTH 10,

       END OF gs_student.



DATA : gt_student LIKE TABLE OF gs_student.



CLEAR : gs_student, gt_student.



gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

APPEND gs_student TO gt_student.



CLEAR : gs_student.



gs_student-zpernr = '0000000002'.

gs_student-zcode = 'SSU-02'.

gs_student-zkname = '###'.

gs_student-zename = 'HOON'.

gs_student-zgender = 'M'.

gs_student-ztel = '01022223333'.

APPEND gs_student TO gt_student.



CLEAR : gs_student.



gs_student-zpernr = '0000000003'.

gs_student-zcode = 'SSU-03'.

gs_student-zkname = '###'.

gs_student-zename = 'SON'.

gs_student-zgender = 'F'.

gs_student-ztel = '01033334444'.

APPEND gs_student TO gt_student.



" p.6



CLEAR : gs_student.






*LOOP AT gt_student INTO gs_student.

*  IF gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  ELSEIF gs_student-zgender = 'F'.

*    gs_student-zgname = '##.'.

*  ELSE.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*  MODIFY gt_student FROM gs_student INDEX sy-tabix.

*

*  CLEAR : gs_student.

*

*ENDLOOP.

*

*BREAK-POINT.




BREAK-POINT.



LOOP AT gt_student INTO gs_student WHERE zgender = 'F'.

  IF gs_student-zgender = 'M'.

    gs_student-zgname = '##'.

  ELSEIF gs_student-zgender = 'F'.

    gs_student-zgname = '##'.

  ELSE.

    gs_student-zgname = '##'.

  ENDIF.



  MODIFY gt_student FROM gs_student INDEX sy-tabix.



  CLEAR : gs_student.

BREAK-POINT.

ENDLOOP.






*BREAK-POINT.