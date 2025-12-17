
*&---------------------------------------------------------------------*

*&  Include           ZWORK12_002_TOP

*&---------------------------------------------------------------------*




TABLES : ZTCURR12.

TABLES: SSCRFIELDS.



"### ### # ITAB ###

DATA : BEGIN OF GS_ZTCURR.

  include structure
ZTCURR12
.

DATA : END OF GS_ZTCURR.

DATA : GT_ZTCURR LIKE TABLE OF GS_ZTCURR.



"ALV

"### ##

DATA : OK_CODE TYPE SY-UCOMM.



"## ### ##

DATA : GO_EVENT TYPE REF TO EVENT.



"## ##

"#### #######.

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.  "#### ->F01## FORM CREATE_OBJECT

"### ##

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT.