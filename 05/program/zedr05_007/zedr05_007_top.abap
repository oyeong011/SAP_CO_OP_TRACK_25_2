
*&---------------------------------------------------------------------*

*&  Include           ZEDR05_007_TOP

*&---------------------------------------------------------------------*










DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDS05_001
.

DATA : END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

        GC_GRID TYPE REF TO CL_GUI_ALV_GRID.