
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT004_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT16_EKKO,

         ZEDT16_EKPO,

         ZEDT16_RBKP,

         ZEDT16_RSEG,

         ZEDT16_LFM1,

         ZEDT16_LFB1.



DATA: BEGIN OF GS_INVOICE_HEADER,

        EBELN TYPE ZEDT16_EKKO-EBELN, " ######

        BUKRS TYPE ZEDT16_EKKO-BUKRS, " ####

        EKGRP TYPE ZEDT16_EKKO-EKGRP, " ####

        EKORG TYPE ZEDT16_EKKO-EKORG, " ####

        LIFNR TYPE ZEDT16_EKKO-LIFNR, " ###

        NAME1 TYPE ZEDT16_LFA1-NAME1, " #####

        BEDAT TYPE ZEDT16_EKKO-BEDAT, " PO ###

        BLDAT TYPE ZEDT16_RBKP-BLDAT, " ## ###

        WERKS TYPE ZEDT16_RBKP-WERKS, " ###

        MWSKZ TYPE ZEDT16_LFM1-MWSKZ,    " ####

        ZTERM TYPE ZEDT16_LFB1-ZTERM,

      END OF GS_INVOICE_HEADER.

DATA : GT_INVOICE_HEADER LIKE TABLE OF GS_INVOICE_HEADER.






*PARAMETERS : P_EBELN1 TYPE ZEDT16_EKPO-EBELN MODIF ID MD1. " ####

*PARAMETERS : P_WERKS1 TYPE ZEDT16_EKPO-WERKS MODIF ID MD1. " ###

*PARAMETERS : P_DATE  TYPE SY-DATUM MODIF ID MD1. " #####






" ## ##




*DATA: BEGIN OF GS_RBKP,

*        BELNR  TYPE ZEDT16_RBKP-BELNR,       " ###### *

*        GJAHR  TYPE ZEDT16_RBKP-GJAHR,       " #### *

*        BLART  TYPE ZEDT16_RBKP-BLART,       " ####

*        BLDAT  TYPE ZEDT16_RBKP-BLDAT,       " ###

*        BUDAT  TYPE ZEDT16_RBKP-BUDAT,       " ###

*        BUKRS  TYPE ZEDT16_RBKP-BUKRS,       " #### *

*        LIFNR  TYPE ZEDT16_RBKP-LIFNR,       " ### *

*        WAERS  TYPE ZEDT16_RBKP-WAERS,       " ##

*        ZTERM  TYPE ZEDT16_RBKP-ZTERM,       " ####

*        BKTXT  TYPE ZEDT16_RBKP-BKTXT,       " #####

*        XMWST  TYPE ZEDT16_RBKP-XMWST,       " ######

*        RMWWR  TYPE ZEDT16_RBKP-RMWWR,       " #####

*        WMWST  TYPE ZEDT16_RBKP-WMWST,       " ##

*        RBSTAT TYPE ZEDT16_RBKP-RBSTAT,      " ####

*        EBELN  TYPE ZEDT16_RBKP-EBELN,       " ######

*        WERKS  TYPE ZEDT16_RBKP-WERKS,       " ###

*      END OF GS_RBKP.

*DATA: GT_RBKP LIKE TABLE OF GS_RBKP.




DATA: GS_RBKP TYPE ZEDT16_RBKP.



DATA: GT_RBKP LIKE TABLE OF GS_RBKP.



" ## ###




*DATA: BEGIN OF GS_RSEG,

*        L_CHECK TYPE C LENGTH 4,             " ## ####

*        BELNR   TYPE ZEDT16_RSEG-BELNR,       " ###### *

*        GJAHR   TYPE ZEDT16_RSEG-GJAHR,       " #### *

*        BUZEI   TYPE ZEDT16_RSEG-BUZEI,       " ###### *

*        EBELN   TYPE ZEDT16_RSEG-EBELN,       " ######

*        EBELP   TYPE ZEDT16_RSEG-EBELP,       " ######

*        MATNR   TYPE ZEDT16_RSEG-MATNR,       " ####

*        TXZ01   TYPE ZEDT16_RSEG-TXZ01,       " ###

*        WERKS   TYPE ZEDT16_RSEG-WERKS,       " ###

*        LGORT   TYPE ZEDT16_RSEG-LGORT,       " ####

*        MENGE   TYPE ZEDT16_RSEG-MENGE,       " ##

*        MEINS   TYPE ZEDT16_RSEG-MEINS,       " ####

*        WAERS   TYPE ZEDT16_RSEG-WAERS,       " ##

*        WRBTR   TYPE ZEDT16_RSEG-WRBTR,       " ####

*        MWSKZ   TYPE ZEDT16_RSEG-MWSKZ,       " ####

*        WMWST   TYPE ZEDT16_RSEG-WMWST,       " ##

*        SHKZG   TYPE ZEDT16_RSEG-SHKZG,       " #####

*        SGTXT   TYPE ZEDT16_RSEG-SGTXT,       " ######

*        LOEKZ  TYPE ZEDT16_RBKP-LOEKZ,       " #####

*      END OF GS_RSEG.

*DATA: GT_RSEG LIKE TABLE OF GS_RSEG.




DATA: GS_RSEG TYPE ZEDT16_RSEG.



DATA: GT_RSEG LIKE TABLE OF GS_RSEG.



DATA : BEGIN OF GS_ALV,

         L_CHECK  TYPE C LENGTH 1,        " ## ####



         " [## # - ### ### # # #### ###]

         EBELN    TYPE ZEDT16_EKPO-EBELN, " #### ##

         EBELP    TYPE ZEDT16_EKPO-EBELP, " ##

         WERKS    TYPE ZEDT16_EKPO-WERKS, " ###



         " [## ##]

         MATNR    TYPE ZEDT16_EKPO-MATNR, " ####

         MAKTX    TYPE ZEDT16_EKPO-MAKTX, " ###

         LGORT    TYPE ZEDT16_EKPO-LGORT, "



         " [## ##]

         MENGE    TYPE ZEDT16_EKPO-MENGE, " # ##(PO) ##

         WEMNG    TYPE ZEDT16_EKPO-MENGE, " ### ## (DB ###)

         OPEN_QTY TYPE ZEDT16_EKPO-MENGE, " ## ## ## (MENGE - WEMNG)

         ERFMG    TYPE ZEDT16_EKPO-MENGE, " # ## ## ## (###)

         MEINS    TYPE ZEDT16_EKPO-MEINS, " ## ##



         " [## # ## - #### ## BPRME# ### ##]

         BPRME    TYPE ZEDT16_EKPO-BPRME, " # ## (### BPRME## ### #### ##)

         WAERS    TYPE ZEDT16_EKKO-WAERS, " ##



         " [## ##]

         WRBTR    TYPE ZEDT16_RSEG-WRBTR, " #### (ERFMG * BPRME)

         MWSKZ    TYPE ZEDT16_RSEG-MWSKZ, " ####

         WMWST    TYPE ZEDT16_RSEG-WMWST, " ## (WRBTR * 0.1)

         DMBTR    TYPE BSIK-DMBTR,        " # ### (### + ##)



         " [##]

         SHKZG    TYPE ZEDT16_RSEG-SHKZG, " ##### (S)

         SGTXT    TYPE ZEDT16_RSEG-SGTXT, " ##



       END OF GS_ALV.



DATA : GT_ALV LIKE TABLE OF GS_ALV.



DATA : BEGIN OF GS_PO_HEADER.

    include structure
ZEDT16_EKKO
.

DATA : END OF GS_PO_HEADER.



DATA : BEGIN OF GS_PO_ITEM.

    include structure
ZEDT16_EKPO
.

DATA : END OF GS_PO_ITEM.

DATA : GT_PO_ITEM LIKE TABLE OF GS_PO_ITEM.



" ZEDT16_MKPF

" MBLNR : ######

" MJAHR : ####

" BLART : ####

" BLDAT : ###

" BUDAT : ###

DATA : BEGIN OF GS_MKPF.

    include structure
ZEDT16_MKPF
.

DATA : END OF GS_MKPF.




*DATA : GT_MKPF LIKE TABLE OF GS_MKPF.






" ZEDT16_MSEG

" MBLNR : ###### *

" MJAHR : #### *

" ZEILE : ##### *

" MATNR : ####

" WERKS : ###

" LGORT : ####

" LIFNR : #####

" WAERS : ###

" MENGE : ##

" MEINS : ##

" EBELN : ######

" BUKRS : ####

" GJAHR : ####

" BELNR : ####

" SHKZG : ###

" DMBTR : ##

DATA : BEGIN OF GS_MSEG.

    include structure
ZEDT16_MSEG
.

DATA : END OF GS_MSEG.

DATA : GT_MSEG LIKE TABLE OF GS_MSEG.






*&---------------------------------------------------------------------*

*&  ALV ### ## ## (## ## + ###)

*&---------------------------------------------------------------------*




DATA: BEGIN OF GS_ALV_DIS,

        " [## ##]

        L_CHECK TYPE C LENGTH 4,          " #### (## ### #)



        " [Key Fields - ## ## # ##]

        BELNR   TYPE ZEDT16_RBKP-BELNR,   " ###### (##/### ##)

        GJAHR   TYPE ZEDT16_RBKP-GJAHR,   " #### (##/### ##)

        BUZEI   TYPE ZEDT16_RSEG-BUZEI,   " ###### (###)



        " [## ## ## (RBKP)] - PO##(GS_INVOICE_HEADER) ##

        BLART   TYPE ZEDT16_RBKP-BLART,   " #### (RE, KG #)

        BLDAT   TYPE ZEDT16_RBKP-BLDAT,   " ###

        BUDAT   TYPE ZEDT16_RBKP-BUDAT,   " ###

        RBSTAT  TYPE ZEDT16_RBKP-RBSTAT,  " #### (5:### #)

        ZTERM   TYPE ZEDT16_RBKP-ZTERM,   " ####

        BKTXT   TYPE ZEDT16_RBKP-BKTXT,   " ## ###



        BUKRS   TYPE ZEDT16_RBKP-BUKRS,   " ####

        LIFNR   TYPE ZEDT16_RBKP-LIFNR,   " ###



        " [## ### ## (RSEG)] - PO ## ##

        EBELN   TYPE ZEDT16_RSEG-EBELN,   " ######

        EBELP   TYPE ZEDT16_RSEG-EBELP,   " ######

        MATNR   TYPE ZEDT16_RSEG-MATNR,   " ####

        TXZ01   TYPE ZEDT16_RSEG-TXZ01,   " ###

        WERKS   TYPE ZEDT16_RSEG-WERKS,   " ###

        LGORT   TYPE ZEDT16_RSEG-LGORT,   " ####



        " [## # ##]

        MENGE   TYPE ZEDT16_RSEG-MENGE,   " ##

        MEINS   TYPE ZEDT16_RSEG-MEINS,   " ##

        WAERS   TYPE ZEDT16_RBKP-WAERS,   " ## (##/### ##)

        WRBTR   TYPE ZEDT16_RSEG-WRBTR,   " #### (Item Net Value)

        WMWST   TYPE ZEDT16_RSEG-WMWST,   " ## (Item Tax)

        MWSKZ   TYPE ZEDT16_RSEG-MWSKZ,   " ####



        " [## ## ##] - ALV## #### ##

        DMBTR   TYPE ZEDT16_RSEG-WRBTR,   " #### (### + ##)



        " [## ##]

        SHKZG   TYPE ZEDT16_RSEG-SHKZG,   " ##### (S/H)

        SGTXT   TYPE ZEDT16_RSEG-SGTXT,   " ### ###





      END OF GS_ALV_DIS.



DATA: GT_ALV_DIS LIKE TABLE OF GS_ALV_DIS.



DATA : OK_CODE TYPE SY-UCOMM.



CONTROLS: TS_INFO TYPE TABSTRIP.



DATA: GV_SUB_DYNNR TYPE SY-DYNNR VALUE '0101'.



" ######

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.



" #####

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

DATA : GC_GRID_200 TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.

DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GO_EVENT TYPE REF TO EVENT.

DATA : GO_EVENT_RECEIVER TYPE REF TO LCL_EVENT_RECEIVER.



DATA : GS_VARIANT TYPE DISVARIANT.