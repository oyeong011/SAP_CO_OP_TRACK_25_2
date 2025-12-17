
*&---------------------------------------------------------------------*

*&  Include           ZMM18_003_TOP

*&---------------------------------------------------------------------*




DATA: OK_CODE TYPE SY-UCOMM.






*---------------------------------------------------------------------*

* Screen 100 : Header

*---------------------------------------------------------------------*




DATA: GF_MBLNR TYPE ZMKPF_18-MBLNR,

      GF_MJAHR TYPE ZMKPF_18-MJAHR,

      GF_BLART TYPE ZMKPF_18-BLART,

      GF_BLDAT TYPE ZMKPF_18-BLDAT,

      GF_BUDAT TYPE ZMKPF_18-BUDAT.






*---------------------------------------------------------------------*

* Screen 100 : PO ## ## ##

*---------------------------------------------------------------------*




DATA: BEGIN OF GS_ITEM,

        L_CHECK TYPE C LENGTH 1,

        EBELN   TYPE ZEKKO_18-EBELN,

        EBELP   TYPE ZEKPO_18-EBELP,

        LIFNR   TYPE ZEKKO_18-LIFNR,

        BEDAT   TYPE ZEKKO_18-BEDAT,

        MATNR   TYPE ZEKPO_18-MATNR,

        MAKTX   TYPE ZMARA_18-MAKTX,

        MENGE   TYPE ZEKPO_18-MENGE,

        MEINS   TYPE ZEKPO_18-MEINS,

        BPRME   TYPE ZEKPO_18-BPRME,

        WAERS   TYPE ZEKKO_18-WAERS,

        PRDAT   TYPE ZEKPO_18-PRDAT,

        WERKS   TYPE ZEKPO_18-WERKS,

        LGORT   TYPE ZEKPO_18-LGORT,

        GR_DONE TYPE MENGE_D,

        GR_REM  TYPE MENGE_D,

        GR_NOW  TYPE MENGE_D,

      END OF GS_ITEM.

DATA: GT_ITEM LIKE TABLE OF GS_ITEM.



DATA: G_ONCE TYPE C LENGTH 1.






*---------------------------------------------------------------------*

* #### ###

*---------------------------------------------------------------------*




DATA: GS_MKPF TYPE ZMKPF_18,

      GS_MSEG TYPE ZMSEG_18.



DATA: GV_SEL_MBLNR TYPE ZMKPF_18-MBLNR.






*---------------------------------------------------------------------*

* Screen 200 : Header ##

*---------------------------------------------------------------------*




DATA: GF_MBLNR_200 TYPE ZMKPF_18-MBLNR,

      GF_BLART_200 TYPE ZMKPF_18-BLART,

      GF_BLDAT_200 TYPE ZMKPF_18-BLDAT,

      GF_BUDAT_200 TYPE ZMKPF_18-BUDAT.






*---------------------------------------------------------------------*

* Screen 200 : #### ###

*---------------------------------------------------------------------*




DATA: BEGIN OF GS_GOODS_LIST,

        MBLNR TYPE ZMKPF_18-MBLNR,

        BUDAT TYPE ZMKPF_18-BUDAT,

      END OF GS_GOODS_LIST.

DATA: GT_GOODS_LIST LIKE TABLE OF GS_GOODS_LIST.



DATA: BEGIN OF GS_GOODS_ALV,

        DISP_TEXT TYPE CHAR200,

      END OF GS_GOODS_ALV.

DATA: GT_GOODS_ALV LIKE TABLE OF GS_GOODS_ALV.






*---------------------------------------------------------------------*

* Screen 200 : ## ###

*---------------------------------------------------------------------*




DATA: BEGIN OF GS_ITEM_ALV,

        LV_CHECK TYPE C LENGTH 1,

        MBLNR    TYPE ZMSEG_18-MBLNR,

        ZEILE    TYPE ZMSEG_18-ZEILE,

        EBELN    TYPE ZMSEG_18-EBELN,

        EBELP    TYPE ZEKPO_18-EBELP,

        LIFNR    TYPE ZMSEG_18-LIFNR,

        MATNR    TYPE ZMSEG_18-MATNR,

        MAKTX    TYPE ZMARA_18-MAKTX,

        MENGE    TYPE ZMSEG_18-MENGE,

        MEINS    TYPE ZMSEG_18-MEINS,

        WERKS    TYPE ZMSEG_18-WERKS,

        LGORT    TYPE ZMSEG_18-LGORT,

      END OF GS_ITEM_ALV.

DATA: GT_ITEM_ALV LIKE TABLE OF GS_ITEM_ALV.






*---------------------------------------------------------------------*

* Custom Control

*---------------------------------------------------------------------*




CONSTANTS: GC_CONT1 TYPE SCRFNAME VALUE 'CONT1',

           GC_CONT2 TYPE SCRFNAME VALUE 'CONT2',

           GC_CONT3 TYPE SCRFNAME VALUE 'CONT3'.






*---------------------------------------------------------------------*

* ALV Objects

*---------------------------------------------------------------------*




DATA: GO_CONT_100 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_GRID_100 TYPE REF TO CL_GUI_ALV_GRID.



DATA: GO_CONT_200_L TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_GRID_200_L TYPE REF TO CL_GUI_ALV_GRID,

      GO_CONT_200_I TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_GRID_200_I TYPE REF TO CL_GUI_ALV_GRID.






*---------------------------------------------------------------------*

* Field Catalog / Layout

*---------------------------------------------------------------------*




DATA: GT_FIELDCAT_100 TYPE LVC_T_FCAT,

      GS_LAYOUT_100   TYPE LVC_S_LAYO.



DATA: GT_FIELDCAT_200_L TYPE LVC_T_FCAT,

      GS_LAYOUT_200_L   TYPE LVC_S_LAYO.



DATA: GT_FIELDCAT_200_I TYPE LVC_T_FCAT,

      GS_LAYOUT_200_I   TYPE LVC_S_LAYO.



DATA: GT_TOOLBAR TYPE UI_FUNCTIONS.



DATA: GO_EVENT_100   TYPE REF TO EVENT,

      GO_EVENT_200_L TYPE REF TO EVENT,

      GO_EVENT_200_I TYPE REF TO EVENT.