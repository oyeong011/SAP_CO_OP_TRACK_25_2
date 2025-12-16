
*&---------------------------------------------------------------------*

*&  Include           ZCUSTUM_CONTAINER11_TOP

*&---------------------------------------------------------------------*




TABLES : ZEDT11_001.

DATA: GS_STUDENT TYPE ZEDT11_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: OK_CODE TYPE SY-UCOMM.



DATA: GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : gs_fieldcat TYPE lvc_s_fcat.

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.