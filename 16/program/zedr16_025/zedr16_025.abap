
*&---------------------------------------------------------------------*

*& Report ZEDR16_025

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_025.






*TYPES: BEGIN OF slis_fieldcat_main.

*    INCLUDE TYPE slis_fieldcat_main0.

*    INCLUDE TYPE slis_fieldcat_main1.

*TYPES: END OF slis_fieldcat_main.

*

*TYPES: BEGIN OF slis_fieldcat_alv_spec,

*         key_sel(1)  TYPE c,

*         no_sum(1)   TYPE c,

*         sp_group(4) TYPE c,

*         reprep(1)   TYPE c,

*         input(1)    TYPE c,

*         edit(1)     TYPE c,

*         hotspot(1)  TYPE c,

*       END OF slis_fieldcat_alv_spec.

*

*TYPES: BEGIN OF slis_fieldcat_alv.

*    INCLUDE TYPE slis_fieldcat_main.

*    INCLUDE TYPE slis_fieldcat_alv_spec.

*TYPES: END OF slis_fieldcat_alv.

*

*TYPES: BEGIN OF slis_fieldcat_alv1.

*    INCLUDE TYPE slis_fieldcat_main1.

*TYPES: END OF slis_fieldcat_alv1.

*

*TYPES: slis_t_fieldcat_alv TYPE slis_fieldcat_alv OCCURS 1.






TABLES : zedt16_002.



DATA: gs_student TYPE zedt16_002.

DATA: gt_student LIKE TABLE OF gs_student.



DATA : gs_fieldcat TYPE slis_fieldcat_alv.

DATA : gt_fieldcat TYPE slis_t_fieldcat_alv.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECT-OPTIONS : s_zcode FOR zedt16_002-zcode.




*PARAMETERS : p_zpernr LIKE zedt16_002-zpernr.

*PARAMETERS : p_zgen LIKE zedt16_002-zgender MODIF ID sc1.




SELECTION-SCREEN END OF BLOCK b1.











INITIALIZATION.

  s_zcode-low = 'ssu-01'.

  s_zcode-high = 'ssu-99'.

  APPEND s_zcode.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'SC1'.

      screen-input = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM get_data.




*  PERFORM modify_data.






END-OF-SELECTION.

  PERFORM alv_display.



FORM get_data .

  SELECT * FROM zedt16_002

    INTO CORRESPONDING FIELDS OF TABLE gt_student

  WHERE zcode IN s_zcode.

ENDFORM.





FORM alv_display .



  PERFORM field_catalog.

  PERFORM call_alv.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM field_catalog .



  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'.

  gs_fieldcat-just = 'L'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'.

  gs_fieldcat-just = 'C'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZMAJOR'.

  gs_fieldcat-seltext_m = '##'.

  gs_fieldcat-just = 'R'.

  gs_fieldcat-no_out = 'X'.

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

  gs_fieldcat-currency = 'KRW'.

  gs_fieldcat-do_sum = 'X'.

  gs_fieldcat-no_zero = 'X'.

  gs_fieldcat-no_sign = 'X'.

  gs_fieldcat-outputlen = 20.

  gs_fieldcat-emphasize = 'X'.

  gs_fieldcat-edit = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZWAERS'.

  gs_fieldcat-seltext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'CRDATE'.

  gs_fieldcat-seltext_m = '###'.

  gs_fieldcat-edit_mask = '____-__-__'.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM call_alv .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      it_fieldcat = gt_fieldcat

    TABLES

      t_outtab    = gt_student.

ENDFORM.