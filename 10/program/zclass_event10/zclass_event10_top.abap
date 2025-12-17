
*&---------------------------------------------------------------------*

*&  Include           ZCLASS_EVENT10_TOP

*&---------------------------------------------------------------------*




TABLES: ZEDT10_001.



DATA: BEGIN OF GS_STUDENT,

        ICON TYPE C LENGTH 4.

    include structure
ZEDT10_001
.

DATA: END OF GS_STUDENT.



DATA:

      GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: OK_CODE TYPE SY-UCOMM.

DATA: GO_EVENT TYPE REF TO EVENT.



DATA: GS_FCAT TYPE LVC_S_FCAT,

      GT_FCAT TYPE LVC_T_FCAT.



DATA: GS_LAYO TYPE LVC_S_LAYO.



DATA: GS_SORT TYPE LVC_S_SORT,

      GT_SORT TYPE LVC_T_SORT.



DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER,

      GC_GRID    TYPE REF TO CL_GUI_ALV_GRID.