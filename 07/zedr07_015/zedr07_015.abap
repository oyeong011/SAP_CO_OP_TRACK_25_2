
*&---------------------------------------------------------------------*

*& Report ZEDR07_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_015.



TABLES : zedt07_001, zedt07_002.






*DATA : gs_student TYPE zedt07_001.




DATA : gs_student TYPE zedt07_002.

DATA : gt_student LIKE TABLE OF gs_student.



DATA : gs_fieldcat TYPE slis_fieldcat_alv.

DATA : gt_fieldcat TYPE slis_t_fieldcat_alv.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.




*  SELECT-OPTIONS : s_zcode for zedt07_001-zcode.

*  PARAMETERS : p_zpernr LIKE zedt07_001-zpernr.

*  PARAMETERS : p_zgen LIKE zedt07_001-zgender MODIF ID sc1.






  SELECT-OPTIONS : s_zcode for zedt07_002-zcode.

  PARAMETERS : p_zpernr LIKE zedt07_002-zpernr.




*  PARAMETERS : p_zgen LIKE zedt07_002-zgender MODIF ID sc1.




SELECTION-SCREEN END OF BLOCK b1.



INITIALIZATION.

s_zcode-low = 'SSU-01'.

s_zcode-high = 'SSU-99'.

APPEND s_zcode.



AT SELECTION-SCREEN OUTPUT.




*  LOOP AT SCREEN.

*    IF screen-group1 = 'SC1'.

*      screen-input = 0.

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.






START-OF-SELECTION.

  PERFORM get_data.

  PERFORM modify_data.

END-OF-SELECTION.

  PERFORM alv_display.



FORM ALV_DISPLAY .




*  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*

*  EXPORTING

*    i_structure_name = 'ZEDT07_001'

*  TABLES

*    t_outtab = gt_student.






  PERFORM field_catalog.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'



  EXPORTING

    it_fieldcat = gt_fieldcat

  TABLES

    t_outtab = gt_student.

ENDFORM.



FORM GET_DATA .






*  SELECT * FROM zedt07_001




  SELECT * FROM zedt07_002

    INTO CORRESPONDING FIELDS OF TABLE gt_student

  WHERE zcode IN s_zcode.



ENDFORM.



FORM MODIFY_DATA .



ENDFORM.



FORM FIELD_CATALOG .

  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1. "### output##

  gs_fieldcat-fieldname = 'ZCODE'. "## ##### ## #### ####### ## ### ####

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'. "#### #### ### ##### #.

  gs_fieldcat-just = 'L'. "## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-just = 'C'. "## ##

  APPEND gs_fieldcat TO gt_fieldcat.






*  CLEAR : gs_fieldcat.

*  gs_fieldcat-col_pos = 3.

*  gs_fieldcat-fieldname = 'ZKNAME'.

*  gs_fieldcat-seltext_m = '##'.

*  APPEND gs_fieldcat TO gt_fieldcat.






  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZMAJOR'.

  gs_fieldcat-seltext_m = '##'.

  gs_fieldcat-just = 'R'. "### ##

  gs_fieldcat-no_out = 'X'. "## ### ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-seltext_m = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZSUM'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-do_sum = 'X'. "## ##

  gs_fieldcat-no_zero = 'X'. "0# #### ####

  gs_fieldcat-no_sign = 'X'. "### #### (### ### ## ###)

  gs_fieldcat-outputlen = 20. "### # ##

  gs_fieldcat-emphasize = 'X'. "##### ## ##

  gs_fieldcat-edit = 'X'. "### ### # ### ## #### ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZWARS'.

  gs_fieldcat-seltext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'CRDATE'.

  gs_fieldcat-seltext_m = '###'.

  gs_fieldcat-edit_mask = '____-__-__'.

  gs_fieldcat-edit = 'X'. "### ### # ### ## #### ##

  APPEND gs_fieldcat TO gt_fieldcat.



ENDFORM.