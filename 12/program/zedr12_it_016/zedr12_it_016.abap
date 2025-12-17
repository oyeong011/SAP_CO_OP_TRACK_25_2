
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_16

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_016.



DATA: BEGIN OF GS_STUDENT,

  ZPERNR LIKE ZEDT12_001-ZPERNR,

  ZCODE LIKE ZEDT12_001-ZCODE,

  ZKNAME LIKE ZEDT12_001-ZKNAME,

  ZENAME LIKE ZEDT12_001-ZENAME,

  ZGENDER LIKE ZEDT12_001-ZGENDER,

  ZGNAME TYPE C LENGTH 4,

  ZTEL LIKE ZEDT12_001-ZTEL,

  END OF GS_STUDENT.



  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



  CLEAR: GS_STUDENT, GT_STUDENT.



  GS_STUDENT-ZPERNR ='0000000001'.

  GS_STUDENT-ZCODE ='SSU-01'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'KANG'.

  GS_STUDENT-ZGENDER = 'A'.

  GS_STUDENT-ZTEL = '010123456789'.



  IF ( GS_STUDENT-ZGENDER = 'M') AND ( GS_STUDENT-ZKNAME = '###'). "## #####.

    GS_STUDENT-ZGNAME =  '####'.

  ELSE.

    GS_STUDENT-ZGNAME =  '##'.

  ENDIF.

  "IF ( GS_STUDENT-ZGENDER = 'M') AND ( GS_STUDENT-ZKNAME = '###'). "### #### OK

  "GS_STUDENT-ZGNAME =  '##'.

  "ENDIF.



  APPEND GS_STUDENT TO GT_STUDENT.

  CLEAR: GS_STUDENT.



  BREAK-POINT.