
*&---------------------------------------------------------------------*

*&  Include           ZEDR24_025_USERCOMMAND_TOP

*&---------------------------------------------------------------------*




TYPE-POOLS: ICON.



DATA : BEGIN OF GS_002.

  include structure
ZEDT24_002
.

  DATA : ICON TYPE ICON_D.

DATA : END OF GS_002.

DATA : GT_002 LIKE TABLE OF GS_002.



DATA : OK_CODE TYPE SY-UCOMM.



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.



DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FC TYPE LVC_S_FCAT,

       GT_FC TYPE LVC_T_FCAT.



DATA : GO_EVENT TYPE REF TO EVENT.