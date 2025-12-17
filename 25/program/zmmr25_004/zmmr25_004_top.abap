
*&---------------------------------------------------------------------*

*& Include ZMMR25_004_TOP

*&---------------------------------------------------------------------*








TABLES: ZEDT25_LFA1,

        ZEDT25_LFB1,

        ZEDT25_LFM1,

        ZEDT25_ZEKKO,

        ZEDT25_ZEKPO,

        ZEDT25_ZRBKP,

        ZEDT25_ZRSEG,

        ZEDT25_ZTERM.



" ##### ##a

TYPES: BEGIN OF TY_PROCESS.

TYPES:   ZCHECK TYPE C LENGTH 1,           " ## ####

         BUZEI  TYPE ZEDT25_ZRSEG-BUZEI,   " ## ####

         EBELP  TYPE ZEDT25_ZEKPO-EBELP,   " PO ###

         MATNR  TYPE ZEDT25_ZEKPO-MATNR,   " ####

         MAKTX  TYPE ZEDT25_ZEKPO-MAKTX,   " ###

         WERKS  TYPE ZEDT25_ZEKPO-WERKS,   " ###

         LGORT  TYPE ZEDT25_ZEKPO-LGORT,   " ####

         MENGE  TYPE ZEDT25_ZEKPO-MENGE,   " ##

         MEINS  TYPE ZEDT25_ZEKPO-MEINS,   " ##

         STPRS  TYPE ZEDT25_ZEKPO-STPRS,   " ##

         WRBTR  TYPE ZEDT25_ZRSEG-WRBTR,   " ####

         MWSKZ  TYPE ZEDT25_ZRSEG-MWSKZ,   " ####

         WMWST  TYPE ZEDT25_ZRSEG-WMWST,   " ##

         WAERS  TYPE ZEDT25_ZEKKO-WAERS,   " ##

         TOTAL  TYPE ZEDT25_ZRSEG-WRBTR,   " ### (###+##)

         SGTXT  TYPE ZEDT25_ZRSEG-SGTXT,   " ### ###

         EBELN  TYPE ZEDT25_ZEKKO-EBELN,   " PO##

         BUKRS  TYPE ZEDT25_ZEKKO-BUKRS,   " ####

         LIFNR  TYPE ZEDT25_ZEKKO-LIFNR.   " ##

TYPES: END OF TY_PROCESS.



" ##### ##

TYPES: BEGIN OF TY_INQUIRY.

TYPES:   ZCHECK TYPE C LENGTH 1,           " ## ####

         BELNR  TYPE ZEDT25_ZRBKP-BELNR,   " ######

         GJAHR  TYPE ZEDT25_ZRBKP-GJAHR,   " ####

         BUZEI  TYPE ZEDT25_ZRSEG-BUZEI,   " ####

         EBELN  TYPE ZEDT25_ZRSEG-EBELN,   " PO##

         EBELP  TYPE ZEDT25_ZRSEG-EBELP,   " PO###

         MATNR  TYPE ZEDT25_ZRSEG-MATNR,   " ####

         TXZ01  TYPE ZEDT25_ZRSEG-TXZ01,   " ###

         WERKS  TYPE ZEDT25_ZRSEG-WERKS,   " ###

         LGORT  TYPE ZEDT25_ZRSEG-LGORT,   " ####

         MENGE  TYPE ZEDT25_ZRSEG-MENGE,   " ##

         MEINS  TYPE ZEDT25_ZRSEG-MEINS,   " ##

         WRBTR  TYPE ZEDT25_ZRSEG-WRBTR,   " ####

         MWSKZ  TYPE ZEDT25_ZRSEG-MWSKZ,   " ####

         WMWST  TYPE ZEDT25_ZRSEG-WMWST,   " ##

         WAERS  TYPE ZEDT25_ZRSEG-WAERS,   " ##

         TOTAL  TYPE ZEDT25_ZRSEG-WRBTR,   " ###

         SGTXT  TYPE ZEDT25_ZRSEG-SGTXT.   " ###

TYPES: END OF TY_INQUIRY.



" ## ## ##

TYPES: BEGIN OF TY_HEADER,

         LIFNR TYPE ZEDT25_ZEKKO-LIFNR,   " ####

         NAME1 TYPE ZEDT25_LFA1-NAME1,    " ###

         BUKRS TYPE ZEDT25_ZEKKO-BUKRS,   " ####

         EBELN TYPE ZEDT25_ZEKKO-EBELN,   " PO##

         WERKS TYPE ZEDT25_ZEKPO-WERKS,   " ###

         BUDAT TYPE ZEDT25_ZRBKP-BUDAT,   " ###

         BLDAT TYPE ZEDT25_ZRBKP-BLDAT,   " ###

         WAERS TYPE ZEDT25_ZEKKO-WAERS,   " ##

         ZTERM TYPE ZEDT25_LFB1-ZTERM,    " ####

         ZTEXT TYPE ZEDT25_ZTERM-TEXT,    " #####

         MWSKZ TYPE MWSKZ,                 " ####

         TAX_RATE TYPE P DECIMALS 2,       " ##

       END OF TY_HEADER.



DATA: GS_HEADER TYPE TY_HEADER,

      GT_PROCESS TYPE TABLE OF TY_PROCESS,

      GS_PROCESS TYPE TY_PROCESS,

      GT_INQUIRY TYPE TABLE OF TY_INQUIRY,

      GS_INQUIRY TYPE TY_INQUIRY.



DATA: GT_FCAT   TYPE LVC_T_FCAT,

      GS_FCAT   TYPE LVC_S_FCAT,

      GS_LAYOUT TYPE LVC_S_LAYO.



DATA: GO_CONTAINER_100 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_GRID_100      TYPE REF TO CL_GUI_ALV_GRID,

      GO_EVENT_100     TYPE REF TO LCL_EVENT_RECEIVER,

      GO_CONTAINER_200 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_GRID_200      TYPE REF TO CL_GUI_ALV_GRID,

      GO_EVENT_200     TYPE REF TO LCL_EVENT_RECEIVER.



DATA: OK_CODE TYPE SY-UCOMM,

      SAVE_OK TYPE SY-UCOMM.