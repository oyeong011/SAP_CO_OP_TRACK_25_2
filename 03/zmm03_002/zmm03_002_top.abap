
*&---------------------------------------------------------------------*

*&  Include           ZMM03_002_TOP

*&---------------------------------------------------------------------*



* ### ##




TABLES : ZEDT03_EKKO, "#### ##

         ZEDT03_EKPO, "#### ###

         SSCRFIELDS.  "## ## ##






* ### ## (## ##)




CLASS LCL_EVENT DEFINITION DEFERRED.






* ## ##




CONSTANTS: GC_MODE_C TYPE C VALUE 'C',  " ## ## (Create)

           GC_MODE_D TYPE C VALUE 'D',  " ## ## (Display)

           GC_X      TYPE C VALUE 'X',  " Check

           GC_S      TYPE C VALUE 'S',  " ## (Success)

           GC_E      TYPE C VALUE 'E'.  " ## (Error)






* ### ### ## (ALV ###)




TYPES : BEGIN OF TY_DATA,

    "## ##

    ICON TYPE ICON_D, "### ## ###

    STATUS TYPE C,    "S : ##, E: ## (## ##)

    MESSAGE TYPE C LENGTH 100, "## ## ###)



    "## ##

    BUKRS TYPE ZEDT03_EKKO-BUKRS, "####

    LIFNR TYPE ZEDT03_EKKO-LIFNR, "###

    BEDAT TYPE ZEDT03_EKKO-BEDAT, "###



    "# ##

    EBELN TYPE ZEDT03_EKKO-EBELN, "PO ## (##### ##, ## # ##)

    EBELP TYPE ZEDT03_EKPO-EBELP, "## ## (10, 20, 30, ...)



    "### ## (#### ###)

    MATNR TYPE ZEDT03_200-ZMATNR, "#### (#####, ##)

    MAKTX TYPE ZEDT03_200-ZMATNAME, "### (#####)

    MENGE TYPE ZEDT03_EKPO-MENGE, "PO ##

    BPRME TYPE ZEDT03_EKPO-BPRME, "##

    MEINS TYPE ZEDT03_EKPO-MEINS, "##

    WAERS TYPE ZEDT03_200-WAERS, "## (#####)

    MWSKZ TYPE ZEDT03_LFM1-MWSKZ, "####

    PRDAT TYPE ZEDT03_EKPO-PRDAT, "### (## ##)

    WERK TYPE ZEDT03_EKPO-WERK, "### (##### ### ##)

    LGORT TYPE ZEDT03_EKPO-LGORT, "#### (##### ### ##)



    "ALV ##

    CELL_STYLE TYPE LVC_T_STYL, "# ####/### ##

  END OF TY_DATA.






* ### ### ##




DATA : OK_CODE TYPE SY-UCOMM.

DATA : GV_MODE TYPE C.






* ALV ## ### ###




DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER. " ####(##)

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID. " ALV ###



DATA : GO_EVENT TYPE REF TO LCL_EVENT. "### ###



DATA : GS_FIELDCAT TYPE LVC_S_FCAT. "## ####

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO. "####



DATA : GS_SORT TYPE LVC_S_SORT. "##

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GT_DATA TYPE TABLE OF TY_DATA. "ALV ## ###

DATA : GS_DATA TYPE TY_DATA.          "ALV ## ##

DATA : GT_DEL_ROWS TYPE TABLE OF TY_DATA. "### # ### (#### ##)