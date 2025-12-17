
*&---------------------------------------------------------------------*

*& Report ZEDR07_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_016.






*TABLES : zedt07_002.

*

*DATA : gs_student TYPE zedt07_002.

**DATA : gs_student1 TYPE zedt07_001.

*

**DATA : BEGIN OF gs_st.

**  DATA : zcode TYPE zedt07_001,

**         zpernr TYPE zedt07_001,

**         zkname TYPE zedt07_001,

**         zename TYPE zedt07_001,

**         zgender TYPE zedt07_001,

**         zmajor TYPE zedt07_002,

**         zmname TYPE zedt07_002.

**DATA : END OF gs_st.

*

**DATA: gt_st LIKE TABLE OF gs_st.

**DATA : gt_student1 LIKE TABLE OF gs_student1.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : gs_fieldcat TYPE slis_fieldcat_alv,

*       gt_fieldcat TYPE slis_t_fieldcat_alv.

*

*DATA : gs_layout TYPE slis_layout_alv.

*

*DATA : gs_sort TYPE slis_sortinfo_alv.

*DATA : gt_sort TYPE slis_t_sortinfo_alv.

*

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

*  SELECT-OPTIONS : s_zcode for zedt07_002-zcode.

*  PARAMETERS : p_zpernr LIKE zedt07_002-zpernr.

*SELECTION-SCREEN END OF BLOCK b1.

*

*INITIALIZATION.

*s_zcode-low = 'SSU-01'.

*s_zcode-high = 'SSU-99'.

*APPEND s_zcode.

*

*  START-OF-SELECTION.

*    PERFORM get_data.

*

*  END-OF-SELECTION.

*    PERFORM alv_display.

*

*FORM ALV_DISPLAY .

*

*  PERFORM field_catalog.

*  PERFORM alv_layout.

*  PERFORM alv_sort.

*

*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*

*  EXPORTING

*    is_layout  = gs_layout

*    it_fieldcat = gt_fieldcat

*    it_sort = gt_sort

*  TABLES

*    t_outtab = gt_student.

*

*ENDFORM.

*

*FORM GET_DATA .

*  SELECT * FROM zedt07_002

*  INTO CORRESPONDING FIELDS OF TABLE gt_student

*  WHERE zcode IN s_zcode.

*

**  SELECT * FROM zedt07_001

**  INTO CORRESPONDING FIELDS OF TABLE gt_student1

**  WHERE zcode IN s_zcode.

**

**  MOVE-CORRESPONDING gt_student TO gt_st.

**  MOVE-CORRESPONDING gt_student1 TO gt_st.

*

*ENDFORM.

*

*FORM FIELD_CATALOG .

*  CLEAR : gs_fieldcat, gt_fieldcat.

*  gs_fieldcat-col_pos = 1. "### output##

*  gs_fieldcat-fieldname = 'ZCODE'.

*  gs_fieldcat-seltext_m = '####'.

*  APPEND gs_fieldcat TO gt_fieldcat.

*

*  CLEAR : gs_fieldcat.

*  gs_fieldcat-col_pos = 2.

*  gs_fieldcat-fieldname = 'ZPERNR'.

*  gs_fieldcat-seltext_m = '####'.

*  APPEND gs_fieldcat TO gt_fieldcat.

*

*  CLEAR : gs_fieldcat.

*  gs_fieldcat-col_pos = 3.

*  gs_fieldcat-fieldname = 'ZKNAME'.

*  gs_fieldcat-seltext_m = '##'.

*  APPEND gs_fieldcat TO gt_fieldcat.

*

*  CLEAR : gs_fieldcat.

*  gs_fieldcat-col_pos = 4.

*  gs_fieldcat-fieldname = 'ZENAME'.

*  gs_fieldcat-seltext_m = '####'.

*  APPEND gs_fieldcat TO gt_fieldcat.

*

*  CLEAR : gs_fieldcat.

*  gs_fieldcat-col_pos = 5.

*  gs_fieldcat-fieldname = 'ZGENDER'.

*  gs_fieldcat-seltext_m = '##'.

*  APPEND gs_fieldcat TO gt_fieldcat.

*

*  CLEAR : gs_fieldcat.

*  gs_fieldcat-col_pos = 6.

*  gs_fieldcat-fieldname = 'ZMAJOR'.

*  gs_fieldcat-seltext_m = '##'.

*  APPEND gs_fieldcat TO gt_fieldcat.

*

*  CLEAR : gs_fieldcat.

*  gs_fieldcat-col_pos = 7.

*  gs_fieldcat-fieldname = 'ZMNAME'.

*  gs_fieldcat-seltext_m = '###'.

*  APPEND gs_fieldcat TO gt_fieldcat.

*

*ENDFORM.

*

*FORM alv_layout.

*

*  gs_layout-no_colhead = 'X'.

*  gs_layout-zebra = 'X'.

*  gs_layout-no_vline = 'X'.

*  gs_layout-no_hline = 'X'.

**  gs_layout-edit = 'X'.

*  gs_layout-totals_before_items = 'X'.

*ENDFORM.

*

*FORM alv_sort.

*

*  gs_sort-spos = 1.

*  gs_sort-fieldname = 'ZCODE'.

*  gs_sort-down = 'X'. "####

*  APPEND gs_sort to gt_sort.

*

*ENDFORM.



**********************************************************************




TABLES : zedt07_002.



DATA : BEGIN OF gs_student,

  zcolor TYPE c LENGTH 4,

  zcheck TYPE c,

  zcode LIKE zedt07_001-zcode,

  zpernr LIKE zedt07_001-zpernr,

  zkname LIKE zedt07_001-zkname,

  zename LIKE zedt07_001-zename,

  zgender LIKE zedt07_001-zgender,

  zmajor LIKE zedt07_002-zmajor,

  zmname LIKE zedt07_002-zmname,

  END OF gs_student.



DATA : BEGIN OF gt_student OCCURS 0,

  zcolor TYPE c LENGTH 4,

  zcheck TYPE c,

  zcode LIKE zedt07_001-zcode,

  zpernr LIKE zedt07_001-zpernr,

  zkname LIKE zedt07_001-zkname,

  zename LIKE zedt07_001-zename,

  zgender LIKE zedt07_001-zgender,

  zmajor LIKE zedt07_002-zmajor,

  zmname LIKE zedt07_002-zmname,

  END OF gt_student.



DATA : gs_fieldcat TYPE slis_fieldcat_alv,

       gt_fieldcat TYPE slis_t_fieldcat_alv.



DATA : gs_layout TYPE slis_layout_alv.



DATA : gs_sort TYPE slis_sortinfo_alv.

DATA : gt_sort TYPE slis_t_sortinfo_alv.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zcode for zedt07_002-zcode.

  PARAMETERS : p_zpernr LIKE zedt07_002-zpernr.

SELECTION-SCREEN END OF BLOCK b1.



INITIALIZATION.

s_zcode-low = 'SSU-01'.

s_zcode-high = 'SSU-99'.

APPEND s_zcode.



  START-OF-SELECTION.

    PERFORM get_data.

    PERFORM modify_data.



  END-OF-SELECTION.

    PERFORM alv_display.



FORM ALV_DISPLAY .



  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

  EXPORTING

    i_program_name = sy-repid

    i_internal_tabname = 'GT_STUDENT'

    i_inclname = sy-repid

   CHANGING

     ct_fieldcat = gt_fieldcat.



  PERFORM field_catalog.

  PERFORM alv_layout.

  PERFORM alv_sort.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'



  EXPORTING

    is_layout  = gs_layout

    it_fieldcat = gt_fieldcat

    it_sort = gt_sort

  TABLES

    t_outtab = gt_student.



ENDFORM.



FORM modify_data.

  CLEAR gs_student.



  LOOP AT gt_student INTO gs_student.

    IF gs_student-zename IS NOT INITIAL.

      gs_student-zcolor = '@0A@'.

    ENDIF.



    MODIFY gt_student FROM gs_student INDEX sy-tabix.

    CLEAR gs_student.

  ENDLOOP.

ENDFORM.



FORM GET_DATA .

  SELECT a~zcode

         a~zpernr

         a~zkname

         a~zename

         a~zgender

         b~zmajor

         b~zmname

    FROM zedt07_001 as a

    INNER JOIN zedt07_002 as b

    ON a~zcode = b~zcode

    INTO CORRESPONDING FIELDS OF TABLE gt_student.



ENDFORM.



FORM FIELD_CATALOG .

  CLEAR : gs_fieldcat, gt_fieldcat.



  gs_fieldcat-col_pos = 1. "### output##

  gs_fieldcat-fieldname = 'ZCOLOR'.

  gs_fieldcat-seltext_m = '###'.

  gs_fieldcat-icon = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZCHECK'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-checkbox = 'X'.

  gs_fieldcat-edit = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-seltext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-seltext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-seltext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZGENDER'.

  gs_fieldcat-seltext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'ZMAJOR'.

  gs_fieldcat-seltext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 9.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-seltext_m = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.



ENDFORM.



FORM alv_layout.






*  gs_layout-no_colhead = 'X'.




  gs_layout-zebra = 'X'.

  gs_layout-no_vline = 'X'.

  gs_layout-no_hline = 'X'.




*  gs_layout-edit = 'X'.




  gs_layout-totals_before_items = 'X'.

ENDFORM.



FORM alv_sort.



  gs_sort-spos = 1.

  gs_sort-fieldname = 'ZCODE'.

  gs_sort-down = 'X'. "####

  APPEND gs_sort to gt_sort.



ENDFORM.