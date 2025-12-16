
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER11_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT11_001, ZEDT11_002.

DATA: BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4,

  ZCODE LIKE ZEDT11_001-ZCODE,

  ZPERNR LIKE ZEDT11_001-ZPERNR,

  ZKNAME LIKE ZEDT11_001-ZKNAME,

  ZENAME LIKE ZEDT11_001-ZENAME,

  ZGENDER LIKE ZEDT11_001-ZGENDER,

  ZSUM LIKE ZEDT11_002-ZSUM,

  ZMAJOR LIKE ZEDT11_002-ZMAJOR,

  ZMNAME LIKE ZEDT11_002-ZMNAME,

  END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: OK_CODE TYPE SY-UCOMM.



DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.



DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

DATA : gs_variant TYPE disvariant.



DATA : gs_fieldcat TYPE lvc_s_fcat.

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.