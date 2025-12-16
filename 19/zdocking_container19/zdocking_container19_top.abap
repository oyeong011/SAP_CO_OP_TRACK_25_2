
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER19_TOP

*&---------------------------------------------------------------------*






TABLES: zedt19_0001.






*DATA : BEGIN OF GS_STUDENT,

*  ZCOLOR TYPE C LENGTH 4,

*  ZCODE LIKE ZEDT19_0001-ZCODE,

*  ZPERNR LIKE ZEDT19_0001-ZPERNR,

*  ZKNAME LIKE ZEDT19_0001-ZKNAME,

*  ZENAME LIKE ZEDT19_0001-ZENAME,

*  ZGENDER LIKE ZEDT19_0001-ZGENDER,

*  ZTEL LIKE ZEDT19_0001-ZTEL,

*  ZSUM LIKE ZEDT19_0001-ZSUM,

*  ZMAJOR LIKE ZEDT19_0001-ZMAJOR,

*  ZMNAME LIKE ZEDT19_0001-ZMNAME,

*  END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.






DATA : GT_STUDENT TYPE TABLE OF ZEDT19_0001,

       GS_STUDENT TYPE ZEDT19_0001.



DATA: gs_layout   TYPE lvc_s_layo,

      gs_fieldcat TYPE lvc_s_fcat,

      gt_fieldcat TYPE lvc_t_fcat,

      gt_sort     TYPE lvc_t_sort.



DATA : OK_CODE TYPE SY-UCOMM.



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER. "## ##

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID. "### ## ##