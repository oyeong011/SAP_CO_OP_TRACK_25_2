
*&---------------------------------------------------------------------*

*&  Include           ZMM06_002_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT06_EKKO,

         ZEDT06_EKPO,

         ZEDT06_LFA1,

         ZEDT06_MAT.



" OK_CODE ##.

DATA : OK_CODE TYPE SY-UCOMM.



" ## ## #

DATA : GV_EBELP_MAX TYPE ZEDT06_EKPO-EBELP.



" ### ####.

DATA : GO_EVENT TYPE REF TO EVENT.



" ---------------------------------------------

" #### ## ## (EKKO)

" ---------------------------------------------

TYPES : BEGIN OF TY_EKKO,        " EKKO

  EBELN TYPE ZEDT06_EKKO-EBELN, " ######

  BUKRS TYPE ZEDT06_EKKO-BUKRS, " ####

  EKGRP TYPE ZEDT06_EKKO-EKGRP, " ####

  EKORG TYPE ZEDT06_EKKO-EKORG, " ####

  LIFNR TYPE ZEDT06_EKKO-LIFNR, " ###

  BEDAT TYPE ZEDT06_EKKO-BEDAT, " ###

  WAERS TYPE ZEDT06_EKKO-WAERS, " ##

  END OF TY_EKKO.

DATA : GS_EKKO TYPE TY_EKKO.

DATA : GT_EKKO TYPE TABLE OF TY_EKKO.

DATA : GS_EKKO_ALV TYPE TY_EKKO.

DATA : GT_EKKO_ALV TYPE TY_EKKO.



" ---------------------------------------------

" #### ## ## (EKPO)

" ---------------------------------------------

TYPES : BEGIN OF TY_EKPO,        " EKKO

  EBELN TYPE ZEDT06_EKPO-EBELN, " ######

  EBELP TYPE ZEDT06_EKPO-EBELP, " ##

  MATNR TYPE ZEDT06_EKPO-MATNR, " ####

  MAKTX TYPE ZEDT06_EKPO-MAKTX, " ###

  MENGE TYPE ZEDT06_EKPO-MENGE, " ##

  MEINS TYPE ZEDT06_EKPO-MEINS, " ##

  BPRME TYPE ZEDT06_EKPO-BPRME, " ##

  PRDAT TYPE ZEDT06_EKPO-PRDAT, " ###

  WERKS TYPE ZEDT06_EKPO-WERKS, " ###

  LGORT TYPE ZEDT06_EKPO-LGORT, " ####

  END OF TY_EKPO.

DATA : GS_EKPO TYPE TY_EKPO.

DATA : GT_EKPO TYPE TABLE OF TY_EKPO.



" ---------------------------------------------

" ## # ALV ### ## (PO ALV)

" ---------------------------------------------

TYPES : BEGIN OF TY_PO_ALV,

  SEL  TYPE C,                 " ####

  EBELP TYPE ZEDT06_EKPO-EBELP, " ##

  MATNR TYPE ZEDT06_EKPO-MATNR, " ####

  MAKTX TYPE ZEDT06_EKPO-MAKTX, " ###  -> MAKT-MAKTX

  MENGE TYPE ZEDT06_EKPO-MENGE, " PO##

  BPRME TYPE ZEDT06_EKPO-BPRME, " ##

  MEINS TYPE ZEDT06_EKPO-MEINS, " ##

  WAERS TYPE ZEDT06_EKKO-WAERS, " ##

  MWSKZ TYPE ZEDT06_LFM1-MWSKZ, " ####

  PRDAT TYPE ZEDT06_EKPO-PRDAT, " ###

  WERKS TYPE ZEDT06_EKPO-WERKS, " ###

  LGORT TYPE ZEDT06_EKPO-LGORT, " ####

  END OF TY_PO_ALV.

DATA : GS_PO_ALV TYPE TY_PO_ALV.

DATA : GT_PO_ALV LIKE TABLE OF GS_PO_ALV.

" ---------------------------------------------

" ## # ALV ### ## (PO ALV)

" ---------------------------------------------

TYPES: BEGIN OF TY_EKPO_ALV,

  EBELN TYPE ZEDT06_EKPO-EBELN,

  EBELP TYPE ZEDT06_EKPO-EBELP,

  MATNR TYPE ZEDT06_EKPO-MATNR,

  MAKTX TYPE ZEDT06_EKPO-MAKTX,

  MENGE TYPE ZEDT06_EKPO-MENGE,

  MEINS TYPE ZEDT06_EKPO-MEINS,

  BPRME TYPE ZEDT06_EKPO-BPRME,

  PRDAT TYPE ZEDT06_EKPO-PRDAT,

  WERKS TYPE ZEDT06_EKPO-WERKS,

  LGORT TYPE ZEDT06_EKPO-LGORT,

  WAERS TYPE ZEDT06_EKKO-WAERS,

END OF TY_EKPO_ALV.

DATA : GS_EKPO_ALV TYPE TY_EKPO_ALV.

DATA : GT_EKPO_ALV TYPE TABLE OF TY_EKPO_ALV.



" ---------------------------------------------

" ## ## ## # AVL ### ##.

" ---------------------------------------------

DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT,

       GS_LAYOUT TYPE LVC_S_LAYO,

       GS_SORT TYPE LVC_S_SORT,

       GT_SORT TYPE LVC_T_SORT.

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER,

       GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

" ---------------------------------------------

" ## ## ## # AVL ### ##.

" ---------------------------------------------

DATA : GS_FIELDCAT_300 TYPE LVC_S_FCAT,

       GT_FIELDCAT_300 TYPE LVC_T_FCAT,

       GS_LAYOUT_300 TYPE LVC_S_LAYO,

       GS_SORT_300 TYPE LVC_S_SORT,

       GT_SORT_300 TYPE LVC_T_SORT.

DATA : GC_CUSTOM_300 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_GRID_300 TYPE REF TO CL_GUI_ALV_GRID.

" ---------------------------------------------

" ## ## ## ### ##.

" ---------------------------------------------

TYPES: BEGIN OF TY_EKKO_DISPLAY,

         EBELN TYPE CHAR10,   " ######

         BUKRS TYPE CHAR4,    " ####

         EKGRP TYPE CHAR3,    " ####

         EKORG TYPE CHAR4,    " ####

         LIFNR TYPE CHAR10,   " ###

         BEDAT TYPE CHAR10,   " ### (YYYY-MM-DD ## ##)

         WAERS TYPE CHAR3,    " ##

       END OF TY_EKKO_DISPLAY.



DATA: GS_EKKO_DISP TYPE TY_EKKO_DISPLAY.