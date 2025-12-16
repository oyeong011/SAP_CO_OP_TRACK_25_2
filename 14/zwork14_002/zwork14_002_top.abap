
*&---------------------------------------------------------------------*

*&  Include           ZWORK14_002_TOP

*&---------------------------------------------------------------------*






"### ##

TABLES : ZTCURR14, SSCRFIELDS.



"PDF ### OBJECT ##

TYPE-POOLS: OLE2.

DATA: GO_APPLICATION TYPE OLE2_OBJECT,  "## ######

      GO_WBOOK TYPE OLE2_OBJECT,  "###

      GO_SHEET TYPE OLE2_OBJECT,  "##

      GO_CELL TYPE OLE2_OBJECT.   "#



"## ### ##

DATA: GS_OUT TYPE ZTCURR14,

      GT_OUT TYPE TABLE OF ZTCURR14.



DATA: OK_CODE TYPE SY-UCOMM.



"ALV ### ##

DATA: GO_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA: GT_FCAT TYPE LVC_T_FCAT,

      GS_FCAT TYPE LVC_S_FCAT,

      GS_LAYOUT TYPE LVC_S_LAYO.