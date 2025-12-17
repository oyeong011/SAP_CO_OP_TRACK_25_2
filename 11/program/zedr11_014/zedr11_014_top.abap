
*&---------------------------------------------------------------------*

*&  Include  ZEDR11_014_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT11_001, ZEDT11_002.



DATA : BEGIN OF GS_STUDENT,

ZCOLOR TYPE C LENGTH 4,

ZCODE LIKE ZEDT11_001-ZCODE,

ZPERNR LIKE ZEDT11_001-ZPERNR,

ZKNAME LIKE ZEDT11_001-ZKNAME,

ZENAME LIKE ZEDT11_001-ZENAME,

ZGENDER LIKE ZEDT11_001-ZGENDER,

ZSUM LIKE ZEDT11_002-ZSUM,

ZMAJOR LIKE ZEDT11_002-ZMAJOR,

ZMNAME LIKE ZEDT11_002-ZMNAME,

END OF GS_STUDENT.



DATA : gt_student LIKE TABLE OF gs_student.



  DATA : ok_code TYPE sy-ucomm.



  DATA : gs_fieldcat TYPE slis_fieldcat_alv.

  DATA : gt_fieldcat TYPE slis_t_fieldcat_alv.



  DATA : gs_layout TYPE slis_layout_alv.



  DATA : gs_sort TYPE slis_sortinfo_alv.

  DATA : gt_sort TYPE slis_t_sortinfo_alv.