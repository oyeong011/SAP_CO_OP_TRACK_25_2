
*&---------------------------------------------------------------------*

*&  Include  ZCUSTOM_CONTAINER21_TOP  (OO ALV / LVC ##)

*&---------------------------------------------------------------------*






TABLES: zedt21_001.



" ### ###

DATA: gs_student TYPE zedt21_001.

DATA: gt_student LIKE TABLE OF zedt21_001.



" OK_CODE #

DATA: ok_code TYPE sy-ucomm.



" #### & ###

DATA: gc_custom TYPE REF TO cl_gui_custom_container.

DATA: gc_grid   TYPE REF TO cl_gui_alv_grid.



DATA : gs_fieldcat TYPE lvc_s_fcat.

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.