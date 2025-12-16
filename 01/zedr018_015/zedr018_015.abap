
*&---------------------------------------------------------------------*

*& Report ZEDR018_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_015 MESSAGE-ID zme018. "message #### ##### ##.



tables : zedt018_001.



data : BEGIN OF gs_student.

  include structure
zedt018_001
.

  DATA : END OF gs_student.

DATA : gt_student like TABLE OF gs_student.



SELECTION-SCREEN BEGIN OF block b1 with frame.

  SELECT-OPTIONS : s_zcode for zedt018_001-zcode.

  PARAMETERS : p_zpernr like zedt018_001-zpernr.

  PARAMETERS : p_zgen like zedt018_001-zgender.

SELECTION-SCREEN END OF BLOCK b1.



if s_zcode is INITIAL.

  message i000.

endif.



PERFORM get_data.

if gt_student is INITIAL.

  MESSAGE e001.

  exit.

endif.

PERFORM write_data.



form get_data.

  select * from zedt018_001

    into CORRESPONDING FIELDS OF table gt_student

    where zcode in s_zcode and zgender = p_zgen.

ENDFORM.



form write_data.

  loop at gt_student into gs_student.

    WRITE :/ gs_student-zcode.

    WRITE :/ gs_student-zpernr.

    write :/ gs_student-zgender.

  ENDLOOP.

ENDFORM.