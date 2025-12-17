
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_025_TOP

*&---------------------------------------------------------------------*








TABLES: ZEDT20_002.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT20_002
.

  DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: OK_CODE TYPE SY-UCOMM.



DATA: GT_FIELDCAT TYPE slis_t_fieldcat_alv.

DATA: GS_FIELDCAT TYPE slis_fieldcat_alv.

DATA: GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

DATA: GS_SORT TYPE slis_sortinfo_alv.

DATA: GT_SORT TYPE slis_t_sortinfo_alv.