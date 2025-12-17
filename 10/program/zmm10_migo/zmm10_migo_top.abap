
*&---------------------------------------------------------------------*

*&  Include           ZMM10_MIGO_TOP

*&---------------------------------------------------------------------*




TYPE-POOLS: ICON.






* 1. ### ##

* ####(PO) #### ##(MIGO) #### ## #####.




TABLES: ZEDT10_EKKO,   " #### ## [4]

        ZEDT10_EKPO,   " #### ### [5]

        ZEDT10_MKPF,   " ## ## ## [1]

        ZEDT10_MSEG.   " ## ## ### [2]






* 2. ALV ### ### # ### ### ##

* ### 3.2 '## ## ##' ## [3]




DATA: BEGIN OF GS_ITEM,

        L_CHECK  TYPE C,              " #### (## ###)

        ICON     TYPE C LENGTH 4,     " ## ### (##/## ###)



        "MSEG# PK# #### ##

        ZEILE    TYPE ZEDT10_MSEG-ZEILE,



        " ## ## ## 4## ##

        DONE_QTY TYPE ZEDT10_EKPO-MENGE, " 2. ### ## (###)

        OPEN_QTY TYPE ZEDT10_EKPO-MENGE, " 3. ## ## (PO - ###)

        GR_QTY   TYPE ZEDT10_EKPO-MENGE, " 4. ## ## ## (Edit)



        " ####(PO) ## ###

        EBELN    TYPE ZEDT10_EKPO-EBELN, " #### ##

        EBELP    TYPE ZEDT10_EKPO-EBELP, " ## ##

        LIFNR    TYPE ZEDT10_EKKO-LIFNR, " ###

        BEDAT    TYPE ZEDT10_EKKO-BEDAT, " ###(PO##)



        " ## # ## ##

        MATNR    TYPE ZEDT10_EKPO-MATNR, " ## ##

        MAKTX    TYPE ZEDT10_EKPO-MAKTX, " ## ##

        MENGE    TYPE ZEDT10_EKPO-MENGE, " ## ## (## ###)

        MEINS    TYPE ZEDT10_EKPO-MEINS, " ## ##

        NETPR    TYPE ZEDT10_EKPO-NETPR, " ##

        WAERS    TYPE ZEDT10_EKKO-WAERS, " ## #



        " ## ##

        PRDAT    TYPE ZEDT10_EKPO-PRDAT, " ## ###

        WERKS    TYPE ZEDT10_EKPO-WERKS, " ###

        LGORT    TYPE ZEDT10_EKPO-LGORT, " ## ##



        " ## ## ###

        MESSAGE  TYPE C LENGTH 100,      " BAPI/## ## ###

      END OF GS_ITEM.



DATA: GT_ITEM LIKE TABLE OF GS_ITEM.






* 3. ALV ## ## ##




DATA: GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER, " ####

      GO_ALV       TYPE REF TO CL_GUI_ALV_GRID,         " ALV ###

      GS_LAYOUT    TYPE LVC_S_LAYO,                     " ####

      GT_FCAT      TYPE LVC_T_FCAT,                     " ## ####

      GS_FCAT      TYPE LVC_S_FCAT.






* 4. ## ##




DATA: OK_CODE TYPE SY-UCOMM.






* 5. ## ## (#### ##)




CONSTANTS: C_MVT_GR TYPE BWART VALUE '101', " ## #### [6]

           C_DOC_WE TYPE BLART VALUE 'WE'.  " ## #### [1]





CLASS LCL_EVENT_HANDLER DEFINITION DEFERRED.



DATA: GO_EVENT_HANDLER TYPE REF TO LCL_EVENT_HANDLER.