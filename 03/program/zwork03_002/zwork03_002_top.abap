
*&---------------------------------------------------------------------*

*&  Include           ZWORK03_001_TOP

*&---------------------------------------------------------------------*




TABLES : ZTCURR03.



"&--------## ### ##---------&"



CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.



DATA : BEGIN OF GS_CURR,

    KURST LIKE ZTCURR03-KURST, "####

    FCURR LIKE ZTCURR03-FCURR, "####

    TCURR LIKE ZTCURR03-TCURR, "####

    GDATU LIKE ZTCURR03-GDATU, "#### ###

    UKURS TYPE P LENGTH 11 DECIMALS 5, "##

    FFACT LIKE ZTCURR03-FFACT, "#### ### ##

    TFACT LIKE ZTCURR03-TFACT, "#### ### ##

    ERNAM LIKE ZTCURR03-ERNAM, "###

    ERDAT LIKE ZTCURR03-ERDAT, "###

  END OF GS_CURR.

DATA : GT_CURR LIKE TABLE OF GS_CURR.



RANGES GR_ZDATE FOR ZEDT03_100-ZJDATE. "## ##



"&----------ALV ###----------&"



DATA : OK_CODE TYPE SY-UCOMM. "###### ### ## ##



DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER. "### #### ##

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID. " ### ## ## ##



DATA : GO_EVENT TYPE REF TO EVENT.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT. "## ####

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO. "####



DATA : GS_SORT TYPE LVC_S_SORT. "SORT

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GTABS_TMPL TYPE CXTAB_CONTROL.



" OLE ###

DATA : GO_EXCEL TYPE OLE2_OBJECT,

       GO_WORDBOOKS TYPE OLE2_OBJECT,

       GO_WORDBOOK TYPE OLE2_OBJECT,

       GO_SHEET TYPE OLE2_OBJECT,

       GO_CELL TYPE OLE2_OBJECT.



" ##, ###

DATA : GV_DIR TYPE STRING, "#### ### ####

       GV_XLSX TYPE STRING, "### ## ###

       GV_PDF TYPE STRING. "## PDF ###