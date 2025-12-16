
*&---------------------------------------------------------------------*

*& Report ZEDR022_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr022_004.



DATA: BEGIN OF gs_student,

        zcode    TYPE c LENGTH 6,

        zkname   TYPE c LENGTH 10,

        zename   TYPE c LENGTH 10,

        zgender TYPE c LENGTH 10,

        zgname   TYPE string,

        ztel TYPE STRING,

      END OF gs_student.



DATA: gt_student LIKE TABLE OF gs_student.



CLEAR : gs_student, gt_student.



gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgname = '####'.

APPEND gs_student TO gt_student.



gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgname = '####'.

APPEND gs_student TO gt_student.



gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgname = '####'.

APPEND gs_student TO gt_student.



gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgname = '####'.

APPEND gs_student TO gt_student.



gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'KANG'.

APPEND gs_student TO gt_student.



gs_student-zcode = 'SSU-02'.

gs_student-zkname = '###'.

gs_student-zename = 'LEE'.

gs_student-zgname = '####'.

APPEND gs_student TO gt_student.



SORT gt_student BY zcode zkname zename zgname.



LOOP AT gt_student INTO gs_student.



  AT END OF zename.

    gs_student-zgname = '####'.

  MODIFY gt_student FROM gs_student INDEX sy-tabix TRANSPORTING zgname.

  ENDAT.





ENDLOOP.



LOOP AT gt_student INTO gs_student.

  WRITE: / gs_student-zcode,

           gs_student-zkname,

           gs_student-zename,

           gs_student-zgname.

ENDLOOP.