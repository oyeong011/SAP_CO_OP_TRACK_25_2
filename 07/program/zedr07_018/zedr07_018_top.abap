
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_018_TOP

*&---------------------------------------------------------------------*




TABLES : zedt07_001.



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

  DATA : gt_student LIKE TABLE OF gs_student.



  DATA : ok_code TYPE sy-ucomm.



  DATA : gs_fieldcat TYPE slis_fieldcat_alv.

  DATA : gt_fieldcat TYPE slis_t_fieldcat_alv.



  DATA : gs_layout TYPE slis_layout_alv.



  DATA : gs_sort TYPE slis_sortinfo_alv.

  DATA : gt_sort TYPE slis_t_sortinfo_alv.