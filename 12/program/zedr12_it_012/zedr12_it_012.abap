
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_12

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_012.

DATA: BEGIN OF GS_STUDENT,

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,

  END OF GS_STUDENT.



  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



  CLEAR: GS_STUDENT.

  GS_STUDENT-ZCODE = 'SSU-02'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'LEE'.

  "APPEND GS_STUDENT TO GT_STUDENT. "#### ## ##

  INSERT GS_STUDENT INTO TABLE GT_STUDENT. "## ## ## ##



  CLEAR: GS_STUDENT.

  GS_STUDENT-ZCODE = 'SSU-01'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'KANG'.

  "APPEND GS_STUDENT TO GT_STUDENT.

  INSERT GS_STUDENT INTO TABLE GT_STUDENT. "## ## ## ## INTO TABLE



  CLEAR: GS_STUDENT.

  GS_STUDENT-ZCODE = 'SSU-03'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'SONG'.

  "APPEND GS_STUDENT TO GT_STUDENT.

  INSERT GS_STUDENT INTO  GT_STUDENT INDEX 2. "## ## ## ## INTO ~ INDEX



  BREAK-POINT.