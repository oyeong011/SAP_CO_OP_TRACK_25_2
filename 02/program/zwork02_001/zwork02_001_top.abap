
*&---------------------------------------------------------------------*

*&  Include           ZWORK02_001_TOP

*&---------------------------------------------------------------------*




TABLES: ZTCURR02.



"### ### ##

DATA: GS_TCURR TYPE ZTCURR02,

      GT_TCURR TYPE TABLE OF ZTCURR02.



DATA : OK_CODE TYPE SY-UCOMM.



DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER. "## ## ##



DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID. "### ##



DATA: GO_EVENT TYPE REF TO EVENT.



DATA : GS_VARIANT TYPE DISVARIANT.



"## #### ##

DATA: GT_FIELDCAT TYPE LVC_T_FCAT,

      GS_FIELDCAT TYPE LVC_S_FCAT.



"#### ##

DATA: GS_LAYOUT TYPE LVC_S_LAYO.



"## ##

DATA: GT_SORT TYPE LVC_T_SORT,

      GS_SORT TYPE LVC_S_SORT.