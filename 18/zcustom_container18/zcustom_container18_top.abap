
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER18_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT018_001.



DATA : GS_STUDENT TYPE ZEDT018_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : OK_CODE TYPE SY-UCOMM.



"######

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



"### ##.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.

DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.