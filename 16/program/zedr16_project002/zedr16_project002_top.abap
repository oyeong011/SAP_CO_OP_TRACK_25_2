
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT002_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT16_EKKO, " #### ##

         ZEDT16_EKPO, " #### ###

         ZEDT16_LFA1, " ### ###

         ZEDT16_LFB1, " #### ###

         ZEDT16_LFM1, " #### ###

         ZEDT16_200. " ## ###



DATA : BEGIN OF GS_LFA1.

    include structure
ZEDT16_LFA1
.

DATA : END OF GS_LFA1.

DATA : GT_LFA1 LIKE TABLE OF GS_LFA1.



DATA : BEGIN OF GS_LFB1.

    include structure
ZEDT16_LFB1
.

DATA : END OF GS_LFB1.

DATA : GT_LFB1 LIKE TABLE OF GS_LFB1.



DATA : BEGIN OF GS_LFM1.

    include structure
ZEDT16_LFM1
.

DATA : END OF GS_LFM1.

DATA : GT_LFM1 LIKE TABLE OF GS_LFM1.



DATA : BEGIN OF GS_MARA.

    include structure
ZEDT16_200
.

DATA : END OF GS_MARA.

DATA : GT_MARA LIKE TABLE OF GS_MARA.



" ZEDT16_200

"





DATA : BEGIN OF GS_HEADER,

         EBELN TYPE ZEDT16_EKKO-EBELN, " ######

         BUKRS TYPE ZEDT16_EKKO-BUKRS, " ####

         EKGRP TYPE ZEDT16_EKKO-EKGRP, " ####

         EKORG TYPE ZEDT16_EKKO-EKORG, " ####

         LIFNR TYPE ZEDT16_EKKO-LIFNR, " ###

         BEDAT TYPE ZEDT16_EKKO-BEDAT, " ###

         WAERS TYPE ZEDT16_EKKO-WAERS, " ##

       END OF GS_HEADER.

DATA : GT_HEADER LIKE TABLE OF GS_HEADER.



DATA : BEGIN OF GS_ITEM, " ##, #### ##

         ICON(4) TYPE C,              " ## ###

         EBELN   TYPE ZEDT16_EKPO-EBELN, " ###### *

         EBELP   TYPE ZEDT16_EKPO-EBELP, " ## *

         MATNR   TYPE ZEDT16_EKPO-MATNR, " #### *

         MAKTX   TYPE ZEDT16_EKPO-MAKTX, " ### *

         MENGE   TYPE ZEDT16_EKPO-MENGE, " ## *

         MEINS   TYPE ZEDT16_EKPO-MEINS, " ## *

         WAERS   TYPE ZEDT16_EKKO-WAERS, " ##(##)

         MWSKZ   TYPE ZEDT16_LFM1-MWSKZ, " ####(##)

         BPRME   TYPE ZEDT16_EKPO-BPRME, " ## *

         PRDAT   TYPE ZEDT16_EKPO-PRDAT, "### *

         WERKS   TYPE ZEDT16_EKPO-WERKS, " ### *

         LGORT   TYPE ZEDT16_EKPO-LGORT, " #### *

       END OF GS_ITEM.

DATA : GT_ITEM LIKE TABLE OF GS_ITEM.



DATA : OK_CODE TYPE SY-UCOMM.



" ######

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



" #####

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.

DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GO_EVENT TYPE REF TO EVENT.

DATA : GO_EVENT_RECEIVER TYPE REF TO LCL_EVENT_RECEIVER.



DATA : GS_VARIANT TYPE DISVARIANT.