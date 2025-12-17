
*&---------------------------------------------------------------------*

*&  Include           ZWORK24_002_TOP

*&---------------------------------------------------------------------*






TABLES : ZTCURR24.



"### ### # ITAB ###

DATA : BEGIN OF GS_OUTPUT.

  include structure
ZTCURR24
.

  DATA : SORT_KEY TYPE I.

DATA : END OF GS_OUTPUT.

DATA : GT_OUTPUT LIKE TABLE OF GS_OUTPUT.



"ALV

"### ##

DATA : OK_CODE TYPE SY-UCOMM.



"## ##

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

DATA : GS_FC TYPE LVC_S_FCAT,

       GT_FC TYPE LVC_T_FCAT.



DATA : GS_SORT TYPE LVC_S_SORT,

       GT_SORT TYPE LVC_T_SORT.



"## ### ##

DATA : GO_EVENT TYPE REF TO EVENT.