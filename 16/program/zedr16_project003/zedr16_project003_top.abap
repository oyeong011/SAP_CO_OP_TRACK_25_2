
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT003_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT16_MKPF,

         ZEDT16_MSEG,

         ZEDT16_EKKO,

         ZEDT16_EKPO.



DATA : BEGIN OF GS_ALV,

         L_CHECK  TYPE C LENGTH 1,        " ## ####

         EBELN    TYPE ZEDT16_EKPO-EBELN, " ######

         EBELP    TYPE ZEDT16_EKPO-EBELP, " ##

         LIFNR    TYPE ZEDT16_EKKO-LIFNR, " ###

         BEDAT    TYPE ZEDT16_EKKO-BEDAT, " ###

         MATNR    TYPE ZEDT16_EKPO-MATNR, " ####

         MAKTX    TYPE ZEDT16_EKPO-MAKTX, " ###



         MENGE    TYPE ZEDT16_EKPO-MENGE, " [## ##] # ##(PO) ##

         WEMNG    TYPE ZEDT16_EKPO-MENGE, " [## ##] ### ## (## ### #)

         OPEN_QTY TYPE ZEDT16_EKPO-MENGE, " [##] ## ## ## (##) -> (MENGE - WEMNG)

         ERFMG    TYPE ZEDT16_EKPO-MENGE, " [##] ## ## ## (### / Edit)



         MEINS    TYPE ZEDT16_EKPO-MEINS, " ##

         BPRME    TYPE ZEDT16_EKPO-BPRME, " ##

         WAERS    TYPE ZEDT16_EKKO-WAERS, " ##

         PRDAT    TYPE ZEDT16_EKPO-PRDAT, " ###

         WERKS    TYPE ZEDT16_EKPO-WERKS, " ###

         LGORT    TYPE ZEDT16_EKPO-LGORT, " ####

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

" MBLNR : ######

" MJAHR : ####

" ZEILE : #####

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



DATA : BEGIN OF GS_ALV_DIS,

         MBLNR TYPE ZEDT16_MKPF-MBLNR, " ######

         MJAHR TYPE ZEDT16_MKPF-MJAHR, " ####

         BLART TYPE ZEDT16_MKPF-BLART, " ####

         BLDAT TYPE ZEDT16_MKPF-BLDAT, " ###

         BUDAT TYPE ZEDT16_MKPF-BUDAT, " ###

         ZEILE TYPE ZEDT16_MSEG-ZEILE, " #####

         MATNR TYPE ZEDT16_MSEG-MATNR, " ####

         WERKS TYPE ZEDT16_MSEG-WERKS, " ###

         LGORT TYPE ZEDT16_MSEG-LGORT, " ####

         LIFNR TYPE ZEDT16_MSEG-LIFNR, " #####

         WAERS TYPE ZEDT16_MSEG-WAERS, " ###

         MENGE TYPE ZEDT16_MSEG-MENGE, " ##

         MEINS TYPE ZEDT16_MSEG-MEINS, " ##

         EBELN TYPE ZEDT16_MSEG-EBELN, " ######

         BUKRS TYPE ZEDT16_MSEG-BUKRS, " ####

         GJAHR TYPE ZEDT16_MSEG-GJAHR, " ####

         BELNR TYPE ZEDT16_MSEG-BELNR, " ####

         SHKZG TYPE ZEDT16_MSEG-SHKZG, " ###

         DMBTR TYPE ZEDT16_MSEG-DMBTR, " ##

       END OF GS_ALV_DIS.

DATA : GT_ALV_DIS LIKE TABLE OF GS_ALV_DIS.



DATA : OK_CODE TYPE SY-UCOMM.



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