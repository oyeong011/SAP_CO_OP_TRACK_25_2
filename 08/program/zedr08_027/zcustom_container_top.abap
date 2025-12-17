
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER_TOP

*&---------------------------------------------------------------------*




TABLES : ZEDT08_001.



DATA : GS_STUDENT TYPE ZEDT08_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : OK_CODE TYPE SY-UCOMM.



DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.