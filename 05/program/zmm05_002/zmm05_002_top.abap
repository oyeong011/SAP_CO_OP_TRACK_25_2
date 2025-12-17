
TABLES : ZLFA1_05,  " ### ###

         ZLFB1_05,

         ZLFM1_05,

         ZMARA05,      " ## ###

         ZEKKO_05,     " PO ##

         ZEKPO_05,     " PO ###

         MAKT.         " ## ##



CONSTANTS : GC_SAVE TYPE SY-UCOMM VALUE 'SAVE',

            GC_BACK TYPE SY-UCOMM VALUE 'BACK',

            GC_EXIT TYPE SY-UCOMM VALUE 'EXIT',

            GC_CANC TYPE SY-UCOMM VALUE 'CANC'.



DATA : BEGIN OF GS_ITEM,

         ICON(4)       TYPE C,              " ## ###

         EBELP         TYPE ZEKPO_05-EBELP, " ####

         MATNR         TYPE ZEKPO_05-MATNR, " ####

         MAKTX         TYPE ZEKPO_05-MAKTX, " ####

         MENGE         TYPE ZEKPO_05-MENGE, " ##

         STPRS         TYPE ZEKPO_05-STPRS, " ## (##)

         MEINS         TYPE ZEKPO_05-MEINS, " ## ##

         WAERS         TYPE ZEKKO_05-WAERS, " ## (## ## or ###)

         MWSKZ         TYPE MWSKZ,          " #### (###!)

         PRDAT         TYPE ZEKPO_05-PRDAT, " ###

         WERKS         TYPE ZEKPO_05-WERKS, " ###

         LGORT         TYPE ZEKPO_05-LGORT, " ####

         BPRME         TYPE ZEKPO_05-BPRME, " ## ## (EA)

         CELLTAB       TYPE LVC_T_STYL,     " # ###

       END OF GS_ITEM.



DATA : GT_ITEM LIKE TABLE OF GS_ITEM.



" ## ##

DATA : BEGIN OF GS_HEADER,

         BUKRS TYPE ZEKKO_05-BUKRS,

         LIFNR TYPE ZEKKO_05-LIFNR,

         EKORG TYPE ZEKKO_05-EKORG,

         EKGRP TYPE ZEKKO_05-EKGRP,

         BEDAT TYPE ZEKKO_05-BEDAT,

         WAERS TYPE ZEKKO_05-WAERS,

         MWSKZ TYPE ZLFM1_05-MWSKZ,

         EBELN TYPE EBELN,

       END OF GS_HEADER.



" ALV Object

DATA : GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GO_GRID      TYPE REF TO CL_GUI_ALV_GRID.



" Layout & Field Catalog

DATA : GS_LAYOUT  TYPE LVC_S_LAYO,

       GT_FCAT    TYPE LVC_T_FCAT,

       GS_FCAT    TYPE LVC_S_FCAT.



" Common Variables

DATA : OK_CODE   TYPE SY-UCOMM,

       GV_OKCODE TYPE SY-UCOMM.

DATA : GO_EVENT_RECEIVER TYPE REF TO LCL_EVENT_RECEIVER.