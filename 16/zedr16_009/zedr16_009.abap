
*&---------------------------------------------------------------------*

*& Report ZEDR16_009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_009.



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




*

*gs_student-zename = 'KANG'.

*gs_student-zgender = 'M'.

**APPEND gs_student TO gt_student.

*MODIFY TABLE gt_student FROM gs_student TRANSPORTING zgender.





*LOOP AT gt_student INTO gs_student.

*  IF gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  ELSEIF gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  ELSE.

*    gs_student-zgname = '##'.

*  ENDIF.

*

*  MODIFY gt_student FROM gs_student TRANSPORTING zgname

*  WHERE zcode = gs_student-zcode.

*  CLEAR gs_student.

*ENDLOOP.








LOOP AT gt_student INTO gs_student.

  IF gs_student-zgender = 'M'.

    gs_student-zgname = '##'.

  ELSEIF gs_student-zgender = 'F'.

    gs_student-zgname = '##'.

  ELSE.

    gs_student-zgname = '##'.

  ENDIF.



  MODIFY gt_student FROM gs_student INDEX sy-tabix.



  CLEAR gs_student.

ENDLOOP.