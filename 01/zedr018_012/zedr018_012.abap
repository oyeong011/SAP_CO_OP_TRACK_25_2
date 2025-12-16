
*&---------------------------------------------------------------------*

*& Report ZEDR018_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_012.




*




TABLES : zedt018_001.




*




data : BEGIN OF gs_student.

  include structure
zedt018_001
.

  data : END OF gs_student.




*




data : gt_student like TABLE OF gs_student.




*




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zcode for zedt018_001-zcode DEFAULT 'SSU-01' no-extension.

  PARAMETERS : p_zpernr like zedt018_001-zpernr modif id m1.

  PARAMETERS : p_zgen like zedt018_001-zgender MODIF ID m2.

SELECTION-SCREEN end of BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS : p_r1 radiobutton GROUP r1 default 'X' USER-COMMAND uc1.

  PARAMETERS : p_r2 RADIOBUTTON GROUP r1.

SELECTION-SCREEN end of BLOCK b2.



at SELECTION-SCREEN OUTPUT. "selection-screen# #### ## ##

  loop at SCREEN.

    if screen-group1 = 'M2'. "modif id# ## ### ##!!

      if p_r1 = 'X'. " ###### ## m2 ##.

        screen-active = '1'.

      ELSEIF p_r2 = 'X'.

        screen-active = '0'.

      endif.

      screen-intensified = '1'.

    ENDIF.

    MODIFY SCREEN.

  endloop.