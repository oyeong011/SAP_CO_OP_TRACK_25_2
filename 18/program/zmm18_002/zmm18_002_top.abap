
*&---------------------------------------------------------------------*

*&  Include           ZMM18_002_TOP

*&---------------------------------------------------------------------*




TABLES: ZEKKO_18, ZEKPO_18, ZLFM1_18, ZMARA_18. " ZMARA_18 ## (###)



DATA: GV_MODE    TYPE CHAR1.    " 'C' = CREATE, 'D' = DISPLAY

DATA: OK_CODE    TYPE SY-UCOMM,

      GV_OK_CODE TYPE SY-UCOMM.



" 1. ## ###

DATA: BEGIN OF GS_EKKO,

        EBELN TYPE ZEKKO_18-EBELN, " #### ##

        BUKRS TYPE ZEKKO_18-BUKRS, " ####

        EKGRP TYPE ZEKKO_18-EKGRP, " ####

        EKORG TYPE ZEKKO_18-EKORG, " ####

        LIFNR TYPE ZEKKO_18-LIFNR, " ###

        BEDAT TYPE ZEKKO_18-BEDAT, " ###

        WAERS TYPE ZEKKO_18-WAERS, " ##

      END OF GS_EKKO.



DATA: GT_EKKO LIKE TABLE OF GS_EKKO.



" 2. ### ### (ALV ###)

DATA: BEGIN OF GS_EKPO,

        EBELN TYPE ZEKPO_18-EBELN, " #### ##

        EBELP TYPE ZEKPO_18-EBELP, " ## ##

        MATNR TYPE ZEKPO_18-MATNR, " ## ##

        MAKTX TYPE ZEKPO_18-MAKTX, " ## ## (#### ### ##)

        MENGE TYPE ZEKPO_18-MENGE, " ##

        MEINS TYPE ZEKPO_18-MEINS, " ##

        NETPR TYPE ZEKPO_18-NETPR, " ##

        BPRME TYPE ZEKPO_18-BPRME, " ## ##

        PRDAT TYPE ZEKPO_18-PRDAT, " ###

        WERKS TYPE ZEKPO_18-WERKS, " ###

        LGORT TYPE ZEKPO_18-LGORT, " ####

        MWSKZ TYPE ZEKPO_18-MWSKZ, " ####

        WAERS TYPE ZEKKO_18-WAERS, " ##

      END OF GS_EKPO.



DATA: GT_EKPO LIKE TABLE OF GS_EKPO.



" 3. ### ### ### (DB ## ## ## ##!)

DATA: GT_DEL_EKPO LIKE TABLE OF GS_EKPO.



" 4. ALV ## ##

" ### ####

DATA: GO_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



" ALV ###

DATA: GO_GRID TYPE REF TO CL_GUI_ALV_GRID.



" ## #### (## ##, ##, ## ##)

DATA: GT_FIELDCAT TYPE LVC_T_FCAT,

      GS_FIELDCAT TYPE LVC_S_FCAT.



" ####

DATA: GS_LAYOUT   TYPE LVC_S_LAYO.



" ##

DATA: GT_SORT TYPE LVC_T_SORT,

      GS_SORT TYPE LVC_S_SORT.



" #### ## ##

DATA: GS_VARIANT  TYPE DISVARIANT.



" 5. ## ## (LOOP ## # ##)

FIELD-SYMBOLS: <FS_EKPO> LIKE LINE OF GT_EKPO.



DATA : GO_EVENT TYPE REF TO EVENT.