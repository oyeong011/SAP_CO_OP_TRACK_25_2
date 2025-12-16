
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_026_TOP

*&---------------------------------------------------------------------*






TABLES: ZEDT20_002.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT20_002
.

  DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: OK_CODE TYPE SY-UCOMM.



DATA: GT_FIELDCAT TYPE LVC_T_FCAT.

DATA: GS_FIELDCAT TYPE LVC_S_FCAT.

DATA: GS_LAYOUT TYPE LVC_S_LAYO.

DATA: GS_SORT TYPE LVC_S_SORT.

DATA: GT_SORT TYPE LVC_T_SORT.



DATA: GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID.