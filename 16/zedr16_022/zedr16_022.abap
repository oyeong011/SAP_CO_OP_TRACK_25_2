
*&---------------------------------------------------------------------*

*& Report ZEDR16_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_022 MESSAGE-ID zmed16.



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

PARAMETERS : p_zgen LIKE zedt16_001-zgender.

SELECTION-SCREEN END OF BLOCK b1.



IF s_zcode IS INITIAL.

  MESSAGE i000.

ENDIF.









PERFORM get_data.



IF gt_student IS INITIAL.

  MESSAGE i001.

  EXIT.

ENDIF.



PERFORM write_data.








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

    WHERE zcode IN s_zcode

    AND zpernr = p_zpernr

    AND zgender = p_zgen.

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

    WRITE :/ gs_student-zcode,

    gs_student-zpernr,

    gs_student-zgender.

  ENDLOOP.

ENDFORM.