
*&---------------------------------------------------------------------*

*&  Include           ZEDR06_034_CLASS_EVENT_TOP

*&---------------------------------------------------------------------*






DATA : GS_STUDENT TYPE ZEDT06_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : OK_CODE TYPE SY-UCOMM.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GO_EVENT TYPE REF TO EVENT.