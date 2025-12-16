
*&---------------------------------------------------------------------*

*&  Include           ZEDR21_022_TOP

*&---------------------------------------------------------------------*






TABLES : zedt21_001.





DATA : BEGIN OF gs_student,

  icon TYPE c LENGTH 4,

  mandt LIKE zedt21_001-mandt,

  zcode21 LIKE zedt21_001-zcode21,

  zpernr21 LIKE zedt21_001-zpernr21,

  zkname21 LIKE zedt21_001-zkname21,

  zename21 LIKE zedt21_001-zename21,

  zgubun21 LIKE zedt21_001-zgubun21,

  ztel21 LIKE zedt21_001-ztel21,

  crname LIKE zedt21_001-crname,

  crdate LIKE zedt21_001-crdate,

  crzeit LIKE zedt21_001-crzeit,

  aename LIKE zedt21_001-aename,

  aezeit LIKE zedt21_001-aezeit,

  END OF gs_student.

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