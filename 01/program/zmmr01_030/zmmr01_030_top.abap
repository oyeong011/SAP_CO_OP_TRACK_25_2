
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_030_TOP

*&---------------------------------------------------------------------*




TABLES : ZEKKO01, ZEKPO01 , ZMAT01, ZMKPF01 , ZMSEG01 ,ZRSEG01 , ZRBKP01.




*&--------------------------------------------------------------------*

*&  CONTROLS

*&--------------------------------------------------------------------*




CONTROLS : GC_TABSTRIP_HEADER TYPE TABSTRIP,

           GC_TABSTRIP_ITEM   TYPE TABSTRIP.



CONTROLS: TC_SIMU TYPE TABLEVIEW USING SCREEN 0400.




*&--------------------------------------------------------------------*

*&  CONSTANTS

*&--------------------------------------------------------------------*




CONSTANTS : C_1 TYPE N           VALUE '1',

            C_2 TYPE N           VALUE '2',

            C_3 TYPE N           VALUE '3',

            C_4 TYPE N           VALUE '4',

            C_5 TYPE N           VALUE '5',

            C_6 TYPE N           VALUE '6',

            C_7 TYPE N           VALUE '7',

            C_8 TYPE N           VALUE '8',

            C_9 TYPE N           VALUE '9',

            C_0 TYPE N           VALUE '0',



            C_A TYPE C           VALUE 'A',

            C_B TYPE C           VALUE 'B',

            C_C TYPE C           VALUE 'C',

            C_D TYPE C           VALUE 'D',

            C_E TYPE C           VALUE 'E',

            C_F TYPE C           VALUE 'F',

            C_G TYPE C           VALUE 'G',

            C_H TYPE C           VALUE 'H',

            C_I TYPE C           VALUE 'I',

            C_J TYPE C           VALUE 'J',

            C_K TYPE C           VALUE 'K',

            C_L TYPE C           VALUE 'L',

            C_M TYPE C           VALUE 'M',

            C_N TYPE C           VALUE 'N',

            C_O TYPE C           VALUE 'O',

            C_P TYPE C           VALUE 'P',

            C_Q TYPE C           VALUE 'Q',

            C_R TYPE C           VALUE 'R',

            C_S TYPE C           VALUE 'S',

            C_T TYPE C           VALUE 'T',

            C_U TYPE C           VALUE 'U',

            C_V TYPE C           VALUE 'V',

            C_W TYPE C           VALUE 'W',

            C_X TYPE C           VALUE 'X',

            C_Y TYPE C           VALUE 'Y',

            C_Z TYPE C           VALUE 'Z',

            C_ICON_NONE    TYPE TV_IMAGE    VALUE 'BNONE'.



CONSTANTS : C_INSR(4) TYPE C           VALUE 'INSR',

            C_DELE(4) TYPE C           VALUE 'DELE',

            C_SAVE(4) TYPE C           VALUE 'SAVE',

            C_BACK(4) TYPE C           VALUE 'BACK',

            C_EXIT(4) TYPE C           VALUE 'EXIT',

            C_ENTR(4) TYPE C           VALUE 'ENTR',

            C_CANC(4) TYPE C           VALUE 'CANC',

            C_SALL(4) TYPE C           VALUE 'SALL',

            C_DALL(4) TYPE C           VALUE 'DALL',

            C_TEXT(4) TYPE C           VALUE 'TEXT',



            C_CRUD(6) TYPE C           VALUE 'CREATE',

            C_DISP(7) TYPE C           VALUE 'DISPLAY'.



CONSTANTS : C_NR_IV      TYPE CHAR2 VALUE '01',

            C_NR_IV_CANC TYPE CHAR2 VALUE '06',

            C_NR_FI      TYPE CHAR2 VALUE '02',

            C_NR_FI_CANC TYPE CHAR2 VALUE '03'.



CONSTANTS : C_WAERS_D TYPE ZMSEG01-WAERS VALUE 'KRW'.




*----------------------------------------------------------------------*

* Types

*----------------------------------------------------------------------*




TYPES : BEGIN OF TY_100.

TYPES :

        LIFNR      TYPE ZLFA1_01-LIFNR,    "#####

        NAME1      TYPE ZLFA1_01-NAME1,    "####

        LAND1      TYPE ZLFA1_01-LAND1,    "##

        PSTLZ      TYPE ZLFA1_01-PSTLZ,    "####

        ORT01      TYPE ZLFA1_01-ORT01,    "##



        PUR_LOEVM  TYPE ZLFB1_01-LOEVM,

        ZTERM      TYPE ZLFB1_01-ZTERM,    " ####

        ZTERM_TX   TYPE CHAR50,            " #### ###

        BANKL      TYPE ZLFB1_01-BANKL,

        BANKL_TX   TYPE CHAR40,

        BANKN      TYPE ZLFB1_01-BANKN,

        AKONT      TYPE ZLFB1_01-AKONT,    " ####



        PUR_WAERS  TYPE ZLFM1_01-WAERS,    "### ## ##

        PUR_MWSKZ  TYPE ZLFM1_01-MWSKZ,    "### ####




*----------------------------------------------------------------------*

*  PO ##

*----------------------------------------------------------------------*




        EBELN      TYPE ZEKKO01-EBELN,     "######

        BUKRS      TYPE ZEKKO01-BUKRS,     "####

        BUKRS_TX   TYPE CHAR40,            "#### ###

        EKORG      TYPE ZEKKO01-EKORG,     "####

        EKGRP      TYPE ZEKKO01-EKGRP,     "####

        BEDAT      TYPE ZEKKO01-BEDAT,     "######

        WAERS      TYPE ZEKKO01-WAERS,     "##

        INCO1      TYPE ZEKKO01-INCO1,     "####1

        INCO2      TYPE ZEKKO01-INCO2,     "####2



        EKORG_TX   TYPE T024E-EKOTX,       "#### ###

        EKGRP_TX   TYPE T024-EKNAM,        "#### ####



        EBELP      TYPE ZEKPO01-EBELP,     "#### ##

        MATNR      TYPE ZEKPO01-MATNR,     "####

        MAKTX      TYPE ZEKPO01-MAKTX,     "###

        MATKL      TYPE ZEKPO01-MATKL,     "####

        MENGE      TYPE ZEKPO01-MENGE,     "##

        MEINS      TYPE ZEKPO01-MEINS,     "####

        BPRME      TYPE ZEKPO01-BPRME,     "######

        NETPR      TYPE ZEKPO01-NETPR,     "##

        NETWR      TYPE ZEKPO01-NETWR,     "###

        WERKS      TYPE ZEKPO01-WERKS,     "###

        LGORT      TYPE ZEKPO01-LGORT,     "####

        PRDAT      TYPE ZEKPO01-PRDAT,     "###

        WERKS_TX   TYPE T001W-NAME1,       "####

        LGORT_TX   TYPE T001L-LGOBE,       "#####




*----------------------------------------------------------------------*

* ## ##

*----------------------------------------------------------------------*






        ZEILE       TYPE ZMSEG01-ZEILE,     "## ####

        SHKZG       TYPE ZMSEG01-SHKZG,     "##/## ##

        DMBTR       TYPE ZMSEG01-DMBTR,     "## ##

        BWART       TYPE ZMSEG01-BWART,     "#### (## 101)




*----------------------------------------------------------------------*

* ## ##

*----------------------------------------------------------------------*




        BELNR       TYPE ZRBKP01-BELNR,      " ## ####

        WMWST       TYPE ZRBKP01-WMWST,      " ##

        MWSKZ       TYPE ZRBKP01-MWSKZ,      " ####

        TAX_RATE    TYPE ZBKPF01-KURSF,      " ####

        BKTXT       TYPE ZRBKP01-BKTXT,      " ## ###

        GJAHR       TYPE ZRBKP01-GJAHR,      " ####

        RMWWR       TYPE ZRBKP01-RMWWR,      " # ####

        KURSF       TYPE ZRBKP01-KURSF,      " ##

        TXKRS       TYPE ZRBKP01-TXKRS,      " #####

        STBLG       TYPE ZRBKP01-STBLG,      " ### ####

        STJAH       TYPE ZRBKP01-STJAH,      " ### ####

        XREVR       TYPE ZRBKP01-XREVR,      " ### ## ###



        FRTWR       TYPE ZRBKP01-RMWWR,      " ###




*----------------------------------------------------------------------*

* ## ## ##

*----------------------------------------------------------------------*




         BUZEI   TYPE ZRSEG01-BUZEI,      " ## ## ####

         WRBTR   TYPE ZRSEG01-WRBTR,      " ##(####)



         BSTME   TYPE ZRSEG01-BSTME,      " #### ##

         BPMNG   TYPE ZRSEG01-BPMNG,      " #### ##

         BKLAS   TYPE ZRSEG01-BKLAS,      " #####

         SGTXT   TYPE ZRSEG01-SGTXT,      " ### ###



         IV_QTY      TYPE ZRSEG01-MENGE,     "## ## ##

         IV_DONE_QTY TYPE ZRSEG01-MENGE,     "## ####

         IV_REM_QTY  TYPE ZRSEG01-MENGE,     "## ####

         PRICE_SUM   TYPE ZEKPO01-NETPR,     "PO #### # ##

         BALANCE     TYPE ZEKPO01-NETPR,     "### ### ##

         AMOUNT      TYPE ZEKPO01-NETPR,     "### ## ##




*----------------------------------------------------------------------*

* ## ##

*----------------------------------------------------------------------*




        BSCHL      TYPE ZBSEG01-BSCHL,

        KOART      TYPE ZBSEG01-KOART,

        HKONT      TYPE ZBSEG01-HKONT,

        SAKNR      TYPE ZBSEG01-SAKNR,




*----------------------------------------------------------------------*

* ####

*----------------------------------------------------------------------*




        BUDAT       TYPE ZMKPF01-BUDAT,     "###

        BLDAT       TYPE ZMKPF01-BLDAT,     "###

        MBLNR       TYPE ZMKPF01-MBLNR,     "######

        MJAHR       TYPE ZMKPF01-MJAHR,     "####

        BLART       TYPE ZMKPF01-BLART,     "####

        TCODE       TYPE ZBKPF01-TCODE,     "#### ##



        CRNAME      TYPE ZMKPF01-CRNAME,     "###

        CRDATE      TYPE ZMKPF01-CRDATE,     "###

        CRZEIT      TYPE ZMKPF01-CRZEIT,     "####








*----------------------------------------------------------------------*

* ##

*----------------------------------------------------------------------*




        LINE_NUM   TYPE ZEKPO01-EBELP,     " ALV ##

        SALE_TX    TYPE CHAR40,

        MODE_TX    TYPE C LENGTH 16,       "## # ### ## TEXT

        STATUS     TYPE C LENGTH 1,        "Y=### / G=#### / N=###

        LINE       TYPE C LENGTH 4,

        ERR_FLAG   TYPE C LENGTH 1,        "## ##

        L_CHECK    TYPE C LENGTH 1,

        COLOR      TYPE C LENGTH 4,       "### @08@ @09@ @0A@

        CELLTAB    TYPE LVC_T_STYL,        "ALV ###(## ##/###)

        MSG        TYPE CHAR100.           "## ## ## ###



TYPES  END OF TY_100.



TYPES: BEGIN OF TY_GLA,

        LINE_NUM TYPE CHAR4,        " ##

        L_CHECK  TYPE CHAR1,        " ##

        HKONT    TYPE HKONT,        " G/L ##

        SGTXT    TYPE SGTXT,        " ###

        SHKZG    TYPE SHKZG,        " ##/##

        WRBTR    TYPE WRBTR,        " #### ##

        DMBTR    TYPE DMBTR,        " #### ##

        MWSKZ    TYPE MWSKZ,        " ####

        TXJCD    TYPE TXJCD,        " ## ## ##

        DROPN  TYPE CHAR04,

       END OF TY_GLA.



TYPES: BEGIN OF TY_MAT,

         LINE_NUM TYPE CHAR4,        " ##

         L_CHECK  TYPE CHAR1,        " ##

         MATNR  TYPE ZMAT01-MATNR,      " ##

         WERKS  TYPE ZMAT01-WERKS,      " ###

         BWKEY  TYPE BWKEY,              " ####

         SHKZG  TYPE SHKZG,             " D/C

         WRBTR  TYPE WRBTR,             " ##

         MENGE  TYPE MENGE_D,           " ##

         MEINS  TYPE MEINS,              " ##

         MWSKZ  TYPE ZLFM1_01-MWSKZ,      " ####

         DROPN  TYPE CHAR04,

       END OF TY_MAT.






*----------------------------------------------------------------------*

* SIMULATION ALV

*----------------------------------------------------------------------*




TYPES: BEGIN OF TY_SIMU,

        BUZEI      TYPE ZBSEG01-BUZEI,  "##

        BSCHL      TYPE ZBSEG01-BSCHL,  "###

        KOART      TYPE ZBSEG01-KOART,  "####

        SAKNR      TYPE ZBSEG01-SAKNR,  "##### #### G/L ##

        HKONT      TYPE ZBSEG01-HKONT,  "### ##(####)# G/L ##

        SGTXT      TYPE ZBSEG01-SGTXT,  "##

        TEXT       TYPE CHAR40,         "##### ##

        KURSF      TYPE ZBKPF01-KURSF,  "## ## # ####

        WRBTR      TYPE ZBSEG01-WRBTR,  "####

        WAERS      TYPE ZBKPF01-WAERS,  "##

        DMBTR      TYPE ZBSEG01-DMBTR,  "####

        WAERS_D    TYPE ZBKPF01-WAERS,  "##

        MWSKZ      TYPE ZBSEG01-MWSKZ,  "####

        XBLNR      TYPE ZBSEG01-XBLNR,  "## ####



        EBELN      TYPE ZEKPO01-EBELN,  "PO ##

        EBELP      TYPE ZEKPO01-EBELP,  "PO ##

        MATNR      TYPE ZEKPO01-MATNR,  "##

        MAKTX      TYPE ZEKPO01-MAKTX,  "###

        LIFNR      TYPE ZBSEG01-LIFNR,  "#####



        KTOSL      TYPE ZSKA1_01-KTOSL, "#### #

        SHKZG      TYPE ZBSEG01-SHKZG,  "#/##

      END OF TY_SIMU.



TYPES: BEGIN OF TY_SIMU_HEADER,

    DR_SUM   TYPE ZBSEG01-WRBTR, " ##

    CR_SUM   TYPE ZBSEG01-WRBTR, " ##

    BALANCE  TYPE ZBSEG01-WRBTR, " ##

    DIFF_SUM TYPE ZBSEG01-WRBTR, "#### ##

  END OF TY_SIMU_HEADER.




*----------------------------------------------------------------------*

* ## ALV

*----------------------------------------------------------------------*




TYPES: BEGIN OF TY_FI_ALV,

    BUZEI TYPE ZBSEG01-BUZEI, "##

    BSCHL TYPE ZBSEG01-BSCHL, "###

    HKONT TYPE ZBSEG01-HKONT, "##

    SGTXT TYPE ZBSEG01-SGTXT, "##

    WRBTR TYPE ZBSEG01-WRBTR, "####

    WAERS TYPE ZBKPF01-WAERS, "##

    DMBTR TYPE ZBSEG01-DMBTR, "####

    WAERS_D TYPE ZBKPF01-WAERS,

    MWSKZ TYPE ZBSEG01-MWSKZ, "####

    SHKZG TYPE ZBSEG01-SHKZG, "#/##

  END OF TY_FI_ALV.



TYPES: BEGIN OF TY_FI_SUM,

    BSCHL TYPE ZBSEG01-BSCHL, "###

    HKONT TYPE ZBSEG01-HKONT, "##

    SGTXT TYPE ZBSEG01-SGTXT, "##

    WRBTR TYPE ZBSEG01-WRBTR, "####

    WAERS TYPE ZBKPF01-WAERS, "##

    DMBTR TYPE ZBSEG01-DMBTR, "####

    WAERS_D TYPE ZBKPF01-WAERS,

    MWSKZ TYPE ZBSEG01-MWSKZ, "####

    SHKZG TYPE ZBSEG01-SHKZG, "#/##

  END OF TY_FI_SUM.




*----------------------------------------------------------------------*

* Structure & Table

*----------------------------------------------------------------------*




DATA : GT_DISP_100 TYPE STANDARD TABLE OF TY_100,

       GS_DISP_100 TYPE TY_100.



DATA : GT_HEADER_100 TYPE STANDARD TABLE OF TY_100,

       GS_HEADER_100 TYPE TY_100.



DATA : GT_GLA TYPE STANDARD TABLE OF TY_GLA,

       GS_GLA TYPE TY_GLA.



DATA : GT_MAT TYPE STANDARD TABLE OF TY_MAT,

       GS_MAT TYPE TY_MAT.



DATA: GT_SIMU TYPE STANDARD TABLE OF TY_SIMU,

      GS_SIMU TYPE TY_SIMU.



DATA: GT_SIMU_HEADER TYPE STANDARD TABLE OF TY_SIMU_HEADER,

      GS_SIMU_HEADER TYPE TY_SIMU_HEADER.



DATA: GT_FI_ALV TYPE STANDARD TABLE OF TY_FI_ALV,

      GS_FI_ALV TYPE TY_FI_ALV.



DATA: GT_FI_SUM TYPE STANDARD TABLE OF TY_FI_SUM, "## ## ##

      GS_FI_SUM TYPE TY_FI_SUM.






*----------------------------------------------------------------------*

* VARIANT

*----------------------------------------------------------------------*




DATA: GV_OKCODE   TYPE SY-UCOMM,

      GV_DYNNR    TYPE SY-DYNNR,

      GV_DYNNR2   TYPE SY-DYNNR,

      GV_MODE     TYPE CHAR10,                          " 'CREATE' 'DISPLAY'

      GV_ICON_STATUS TYPE C LENGTH 4,

      GV_ERROR_FLAG TYPE C LENGTH 2.

DATA GV_PERIOD TYPE CHAR2.

DATA : GV_ALV_INITIALIZED TYPE ABAP_BOOL VALUE ABAP_FALSE.

DATA : GV_LIST_INITIALIZED TYPE ABAP_BOOL VALUE ABAP_FALSE.



DATA : GC_CUSTOM  TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_CUSTOM2 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_CUSTOM3 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_CUSTOM4 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_CUSTOM5 TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



DATA : GC_GRID  TYPE REF TO CL_GUI_ALV_GRID,

       GC_GRID2 TYPE REF TO CL_GUI_ALV_GRID,

       GC_GRID3 TYPE REF TO CL_GUI_ALV_GRID,

       GC_GRID4 TYPE REF TO CL_GUI_ALV_GRID,

       GC_GRID5 TYPE REF TO CL_GUI_ALV_GRID.



DATA : GO_TREE TYPE REF TO CL_GUI_COLUMN_TREE.

DATA : GV_CLICKED_NODE TYPE TV_NODEKEY.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.                     "ALV FCAT ### ### ##

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_FIELDCAT2 TYPE LVC_S_FCAT.                     "ALV FCAT ### ### ##

DATA : GT_FIELDCAT2 TYPE LVC_T_FCAT.



DATA : GS_VARIANT TYPE DISVARIANT.                      "ALV VARIANT ##

DATA : GS_LAYOUT TYPE LVC_S_LAYO.                       "ALV LAYOUT ##

DATA : GS_LAYOUT2 TYPE LVC_S_LAYO.                       "ALV LAYOUT ##



DATA : GS_SORT TYPE LVC_S_SORT.                         "ALV SORT ### ### ##

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GV_CNT TYPE I VALUE 1.

DATA : GT_EXCLUDE TYPE UI_FUNCTIONS,

       GS_EXCLUDE TYPE UI_FUNC.

DATA : P_LIST TYPE CHAR10.

DATA : GV_TAX_CHECK TYPE C LENGTH 1.



DATA : BEGIN OF GS_LIST_SHKZG,

         SHKZG TYPE SHKZG,

         DROP_DOWN_HANDLE TYPE CHAR04,

  END OF GS_LIST_SHKZG.

DATA : GT_LIST_SHKZG LIKE TABLE OF GS_LIST_SHKZG.




*----------------------------------------------------------------------*

* Structure & Table

*----------------------------------------------------------------------*

*--------------------------------------------------------------*

* #### ## ###

*--------------------------------------------------------------*




DATA : BEGIN OF GS_TAXCODE,

  MWSKZ TYPE ZTAXCODE01-MWSKZ,

  TEXT  TYPE ZTAXCODE01-TEXT.

DATA : END OF GS_TAXCODE.

DATA : GT_TAXCODE LIKE TABLE OF GS_TAXCODE.




*--------------------------------------------------------------*

* ## ###

*--------------------------------------------------------------*




DATA : GT_ZMAT TYPE STANDARD TABLE OF ZMAT01.

DATA : GS_ZMAT TYPE ZMAT01.




*--------------------------------------------------------------*

* ### ### (##)

*--------------------------------------------------------------*




DATA : GT_LFA1 TYPE STANDARD TABLE OF ZLFA1_01.

DATA : GS_LFA1 TYPE ZLFA1_01.




*--------------------------------------------------------------*

* ### ### (####)

*--------------------------------------------------------------*




DATA : GT_LFB1 TYPE STANDARD TABLE OF ZLFB1_01.

DATA : GS_LFB1 TYPE ZLFB1_01.




*--------------------------------------------------------------*

* ### ### (####)

*--------------------------------------------------------------*




DATA : GT_LFM1 TYPE STANDARD TABLE OF ZLFM1_01.

DATA : GS_LFM1 TYPE ZLFM1_01.




*--------------------------------------------------------------*

* #### ## (EKKO ZTAB)

*--------------------------------------------------------------*




DATA : GT_EKKO TYPE STANDARD TABLE OF ZEKKO01.

DATA : GS_EKKO TYPE ZEKKO01.




*-------------------------------------------------------------*

* #### ## (EKPO ZTAB)

*--------------------------------------------------------------*




DATA : GT_EKPO TYPE STANDARD TABLE OF ZEKPO01.

DATA : GS_EKPO TYPE ZEKPO01.




*-------------------------------------------------------------*

* #### ## (MKPF ZTAB)

*--------------------------------------------------------------*




DATA : GT_MKPF TYPE STANDARD TABLE OF ZMKPF01.

DATA : GS_MKPF TYPE ZMKPF01.




*-------------------------------------------------------------*

* #### ## (MSEG ZTAB)

*--------------------------------------------------------------*




DATA : GT_MSEG TYPE STANDARD TABLE OF ZMSEG01.

DATA : GS_MSEG TYPE ZMSEG01.




*-------------------------------------------------------------*

* #### ## (MKPF ZTAB)

*--------------------------------------------------------------*




DATA : GT_RBKP TYPE STANDARD TABLE OF ZRBKP01.

DATA : GS_RBKP TYPE ZRBKP01.




*-------------------------------------------------------------*

* #### ## (MSEG ZTAB)

*--------------------------------------------------------------*




DATA : GT_RSEG TYPE STANDARD TABLE OF ZRSEG01.

DATA : GS_RSEG TYPE ZRSEG01.




*-------------------------------------------------------------*

* ## ## (BKPF ZTAB)

*--------------------------------------------------------------*




DATA : GT_BKPF TYPE STANDARD TABLE OF ZBKPF01,

       GS_BKPF TYPE ZBKPF01.




*-------------------------------------------------------------*

* ## ## (BSEG ZTAB)

*--------------------------------------------------------------*




DATA : GT_BSEG TYPE STANDARD TABLE OF ZBSEG01,

       GS_BSEG TYPE ZBSEG01.




*----------------------------------------------------------------------*

*  Objects

*----------------------------------------------------------------------*






DATA : GO_EVENT TYPE REF TO LCL_EVENT_RECEIVER.

DATA : GO_TREE_EVENT TYPE REF TO LCL_TREE_HANDLER.



TYPES: BEGIN OF TY_NODE,

         NODE_KEY TYPE LVC_NKEY,

         PARENT   TYPE LVC_NKEY,

         TEXT     TYPE STRING,

         ICON     TYPE TV_IMAGE,

         DATA     TYPE STRING,   " ## ##

       END OF TY_NODE.





DATA : GS_HEADER TYPE TREEV_HHDR.

DATA : GV_HCOL    TYPE TV_ITMNAME VALUE 'PO'.

DATA : GV_HCOL2   TYPE TV_ITMNAME VALUE 'MATDOC'.

DATA : GT_NODES TYPE TREEV_NTAB,

       GT_ITEMS TYPE STANDARD TABLE OF MTREEITM.

DATA GV_CHECK_FLAG TYPE CHAR1.