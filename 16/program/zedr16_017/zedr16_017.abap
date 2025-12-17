
*&---------------------------------------------------------------------*

*& Report ZEDR16_017

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_017.



" p.4






*TABLES : zedt16_001.

*

*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*SELECT-OPTIONS : s_zcode FOR zedt16_001-zcode.

*PARAMETERS : p_zgen LIKE zedt16_001-zgender.








" p.5




*TABLES : zedt16_001.

*

*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.



*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

*SELECT-OPTIONS : s_zcode FOR zedt16_001-zcode DEFAULT 'SSU-01' VISIBLE LENGTH 3.

*SELECTION-SCREEN END OF BLOCK b1.

*

*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

*PARAMETERS : p_zgen LIKE zedt16_001-zgender.

*SELECTION-SCREEN END OF BLOCK b2.

*

*" p.7

*SELECT * FROM zedt16_001

*  INTO CORRESPONDING FIELDS OF TABLE gt_student

*  WHERE zcode IN s_zcode

*  AND zgender = p_zgen.

*

*IF gt_student[] IS NOT INITIAL.

*  CLEAR : gs_student.

*  LOOP AT gt_student INTO gs_student.

*    WRITE :/ gs_student-zcode, gs_student-zkname.

*  ENDLOOP.

*ELSE.

*  WRITE :/ '### ##'.

*ENDIF.








" P.18




*TABLES : zedt16_001.

*

*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

*SELECT-OPTIONS : s_zcode FOR zedt16_001-zcode.

*PARAMETERS : p_zgen LIKE zedt16_001-zgender.

*SELECTION-SCREEN END OF BLOCK b1.

*

*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

*PARAMETERS : p_ch1 AS CHECKBOX DEFAULT 'X' MODIF ID m1.

*PARAMETERS : p_ch2 AS CHECKBOX MODIF ID m2.

*SELECTION-SCREEN END OF BLOCK b2.

*

*

*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF screen-group1 = 'M2'.

*      screen-active = '0'.

*      MODIFY SCREEN.

*    ENDIF.

*  ENDLOOP.








" P.33

TABLES : zedt16_001.



DATA : BEGIN OF gs_student.

    include structure
zedt16_001
.

DATA : END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECT-OPTIONS : s_zcode FOR zedt16_001-zcode.

PARAMETERS : p_zpernr LIKE zedt16_001-zpernr MODIF ID m1.

PARAMETERS : p_zgen LIKE zedt16_001-zgender MODIF ID m2.

SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

PARAMETERS : p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X'USER-COMMAND uC1.

PARAMETERS : p_r2 RADIOBUTTON GROUP r1.

SELECTION-SCREEN END OF BLOCK b2.





AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'M2'.

      IF p_r1 = 'X'.

        screen-active = '1'.

      ELSEIF p_r2 = 'X'.

        screen-active = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.