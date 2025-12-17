
*&---------------------------------------------------------------------*

*&  Include           ZEDR03_017_TOP

*&---------------------------------------------------------------------*




TABLES : ZEDT03_001.



DATA : BEGIN OF GS_STUDENT,

  ZICON TYPE ICONNAME.

  include structure
ZEDT03_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GS_SAVE LIKE GS_STUDENT.

DATA : GT_SAVE LIKE TABLE OF GS_STUDENT.



DATA : OK_CODE TYPE SY-UCOMM. "###### ### ## ##






*DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER. "### #### ##




DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER. "## #### ##

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID. " ### ## ## ##



DATA : GO_EVENT TYPE REF TO EVENT.



DATA : GS_VARIANT TYPE DISVARIANT.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT. "## #### (## ALV# ###!)

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO. "#### (## ALV# ###!)



DATA : GS_SORT TYPE LVC_S_SORT. "SORT (## ALV# ###!)

DATA : GT_SORT TYPE LVC_T_SORT.