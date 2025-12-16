
*&---------------------------------------------------------------------*

*& Report ZEDR07_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_013 MESSAGE-ID zmed07.



TABLES : ZEDT07_001.



DATA : BEGIN OF gs_student.

  include structure
zedt07_001
.

  DATA : END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zcode FOR zedt07_001-zcode.

  PARAMETERS : p_zpernr LIKE zedt07_001-zpernr.

  PARAMETERS : p_zgen LIKE zedt07_001-zgender DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK b1.



INITIALIZATION.

s_zcode-low = 'SSU-02'.

s_zcode-high = 'SSU-99'.

APPEND s_zcode.






*AT SELECTION-SCREEN ON s_zcode.

*  IF s_zcode-low NE 'SSU-01'.

*    MESSAGE '##### SSU-01## #####.' TYPE 'I'.

*  ENDIF.



*AT SELECTION-SCREEN ON END OF s_zcode.

*  LOOP AT s_zcode.

*    IF s_zcode-low NE 'SSU-01'.

*      MESSAGE '##### SSU-01## #####.' TYPE 'E'.

*    ENDIF.

*  ENDLOOP.



*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF screen-group1 = 'SC1'.

*      screen-input = 0.

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.






IF s_zcode IS INITIAL.

  MESSAGE I000.

ENDIF.



PERFORM get_data.



IF gt_student IS INITIAL.

  MESSAGE I001.

  EXIT.

ENDIF.



PERFORM write_data.



FORM get_data.



  SELECT * FROM ZEDT07_001

    INTO CORRESPONDING FIELDS OF TABLE gt_student

    WHERE zcode IN s_zcode".

    AND zgender = p_zgen.



ENDFORM.



FORM write_data.

  LOOP AT gt_student INTO gs_student.

    WRITE :/ gs_student-zcode, gs_student-zkname.

  ENDLOOP.

ENDFORM.