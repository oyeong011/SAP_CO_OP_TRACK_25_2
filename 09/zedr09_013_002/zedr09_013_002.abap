
*&---------------------------------------------------------------------*

*& Report ZEDR09_013_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_013_002.



DATA: BEGIN OF gs_student,

        zpernr TYPE STRING,

        zcode    TYPE c LENGTH 6,

        zkname   TYPE c LENGTH 10,

        zename   TYPE c LENGTH 10,

        zgender TYPE c LENGTH 1,

        zgname   TYPE string,

        ztel TYPE STRING,

      END OF gs_student.



DATA: gt_student LIKE TABLE OF gs_student.



CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

GS_STUDENT-ZGNAME = '####'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZGENDER = 'F'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZGENDER = 'A'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000002'.

GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'HOON'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01098765432'.

GS_STUDENT-ZGNAME = '####'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01012345678'.

GS_STUDENT-ZGNAME = '####'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZGNAME = '####'.

APPEND GS_STUDENT TO GT_STUDENT.



SORT gt_student BY zcode zkname zename zgname.





LOOP AT gt_student INTO gs_student.



  AT END OF zename.

    gs_student-zgname = '####'.

    MODIFY gt_student FROM gs_student INDEX sy-tabix TRANSPORTING zgname.

  ENDAT.





  CLEAR : gs_student.

ENDLOOP.



LOOP AT gt_student INTO gs_student.

  WRITE: / gs_student-zcode,

           gs_student-zkname,

           gs_student-zename,

           gs_student-zgname.

ENDLOOP.