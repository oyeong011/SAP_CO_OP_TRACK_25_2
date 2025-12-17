
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_021_TOP

*&---------------------------------------------------------------------*






TABLES : zedt07_001, zedt07_002.



DATA : BEGIN OF gs_student,

  zcolor TYPE c LENGTH 4,

  zcode LIKE zedt07_001-zcode,

  zpernr LIKE zedt07_001-zpernr,

  zkname LIKE zedt07_001-zkname,

  zename LIKE zedt07_001-zename,

  zgender LIKE zedt07_001-zgender,

  zsum LIKE zedt07_002-zsum,

  zmajor LIKE zedt07_002-zmajor,

  zmname LIKE zedt07_002-zmname,

  END OF gs_student.



DATA : gt_student LIKE TABLE OF gs_student.



DATA : ok_code TYPE sy-ucomm.



"######

DATA : gc_docking TYPE REF TO cl_gui_docking_container.

DATA : gc_splitter TYPE REF TO cl_gui_splitter_container.



"#### ## ##

DATA : gc_container1 TYPE REF TO cl_gui_container.

DATA : gc_container2 TYPE REF TO cl_gui_container.



"### ##

DATA : gc_grid1 TYPE REF TO cl_gui_alv_grid.

DATA : gc_grid2 TYPE REF TO cl_gui_alv_grid.



DATA : gs_variant TYPE disvariant.



DATA : gs_fieldcat TYPE lvc_s_fcat.

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.