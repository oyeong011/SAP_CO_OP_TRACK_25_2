
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_022_TOP

*&---------------------------------------------------------------------*






TABLES : zedt07_001.



DATA : BEGIN OF gs_student,

  icon TYPE c LENGTH 4,

  mandt LIKE zedt07_001-mandt,

  zcode LIKE zedt07_001-zcode,

  zpernr LIKE zedt07_001-zpernr,

  zkname LIKE zedt07_001-zkname,

  zename LIKE zedt07_001-zename,

  zgender LIKE zedt07_001-zgender,

  ztel LIKE zedt07_001-ztel,

  crname LIKE zedt07_001-crname,

  crdate LIKE zedt07_001-crdate,

  crzeit LIKE zedt07_001-crzeit,

  aename LIKE zedt07_001-aename,

  aezeit LIKE zedt07_001-aezeit,

  END OF gs_student.






*DATA : BEGIN OF gs_student,

*  INCLUDE TYPE zedt07_001,

*  icon TYPE c,

*  END OF gs_student.






DATA : gt_student LIKE TABLE OF gs_student.



DATA : ok_code TYPE sy-ucomm.



DATA : gc_docking TYPE REF TO cl_gui_docking_container.



DATA : gc_grid TYPE REF TO cl_gui_alv_grid.



DATA : go_event TYPE REF TO event.



DATA : gs_variant TYPE disvariant.



DATA : gs_fieldcat TYPE lvc_s_fcat.

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.