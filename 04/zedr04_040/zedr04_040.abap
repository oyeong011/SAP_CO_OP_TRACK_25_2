
*&---------------------------------------------------------------------*

*& Report ZEDR04_040

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_040.



" ###(##) ##

DATA : BEGIN OF GS_STUDENT,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

  END OF GS_STUDENT.



" ### ### ##

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

INSERT GS_STUDENT INTO TABLE GT_STUDENT.



GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

INSERT GS_STUDENT INTO TABLE GT_STUDENT.



GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SONG'.

INSERT GS_STUDENT INTO GT_STUDENT INDEX 2. " ### #### ##.(1-INDEXED)



BREAK-POINT.