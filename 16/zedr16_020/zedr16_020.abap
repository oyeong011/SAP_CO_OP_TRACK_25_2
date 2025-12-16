
*&---------------------------------------------------------------------*

*& Report ZEDR16_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_020.



TABLES : zedt16_001.



DATA : BEGIN OF gs_student.

    include structure
zedt16_001
.

DATA : END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECT-OPTIONS : s_zcode FOR zedt16_001-zcode.

PARAMETERS : p_zpernr LIKE zedt16_001-zpernr.

PARAMETERS : p_zgen LIKE zedt16_001-zgender DEFAULT 'M' MODIF ID sc1.

SELECTION-SCREEN END OF BLOCK b1.



INITIALIZATION.

  s_zcode-low = 'SSU-02'.

  s_zcode-high = 'SSU-99'.

  APPEND s_zcode.






*AT SELECTION-SCREEN ON s_zcode.

*  IF s_zcode-low NE 'SSU-01'.

*    MESSAGE '##### SSU-01## #####.' TYPE 'E'.

*  ENDIF.





*AT SELECTION-SCREEN ON END OF s_zcode.

*  LOOP AT s_zcode.

*    IF s_zcode-low NE 'SSU-01'.

*      MESSAGE '##### SSU-01## #####' TYPE 'E'.

*    ENDIF.

*  ENDLOOP.








AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'SC1'.

      screen-input = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM get_data.



END-OF-SELECTION.

  PERFORM write_data.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data .

  SELECT * FROM zedt16_001

    INTO CORRESPONDING FIELDS OF TABLE gt_student

    WHERE zcode IN s_zcode.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM write_data .

  LOOP AT gt_student INTO gs_student.

    WRITE :/ gs_student-zcode, gs_student-zkname.

  ENDLOOP.

ENDFORM.