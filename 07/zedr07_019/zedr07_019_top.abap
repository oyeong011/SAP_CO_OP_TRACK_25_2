
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_019_TOP

*&---------------------------------------------------------------------*




TABLES : zedt07_001.



DATA : gs_student TYPE zedt07_001.

DATA : gt_student LIKE TABLE OF gs_student.



DATA : ok_code TYPE sy-ucomm.



"######

DATA : gc_custom TYPE REF TO cl_gui_custom_container.



"### ##

DATA : gc_grid TYPE REF TO cl_gui_alv_grid.



DATA : gs_fieldcat TYPE lvc_s_fcat.

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.