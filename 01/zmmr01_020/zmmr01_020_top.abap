
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_020_TOP

*&---------------------------------------------------------------------*




TABLES : ZEKKO01, ZEKPO01 , ZMAT01, ZMKPF01 , ZMSEG01.




*&--------------------------------------------------------------------*

*&  CONTROLS

*&--------------------------------------------------------------------*




CONTROLS : GC_TABSTRIP_HEADER TYPE TABSTRIP,

           GC_TABSTRIP_ITEM   TYPE TABSTRIP.




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

            c_icon_none    TYPE tv_image    VALUE 'BNONE'.



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



CONSTANTS : C_NR_FI_GR      TYPE CHAR2 VALUE '04',

            C_NR_FI_GR_CANC TYPE CHAR2 VALUE '05'.



CONSTANTS : C_KURSF_TEMP TYPE P DECIMALS 5 VALUE '1.0000',

            C_WAERS_D    TYPE ZBKPF01-WAERS VALUE 'KRW'.






*----------------------------------------------------------------------*

* VARIANT

*----------------------------------------------------------------------*




DATA: GV_OKCODE   TYPE SY-UCOMM,

      GV_DYNNR    TYPE SY-DYNNR,

      GV_DYNNR2    TYPE SY-DYNNR,

      GV_MODE     TYPE CHAR10.                          " 'CREATE' 'DISPLAY'

DATA GV_PERIOD TYPE CHAR2.

DATA : GV_ERROR_FLAG TYPE I.

DATA : GV_ALV_INITIALIZED TYPE ABAP_BOOL VALUE ABAP_FALSE.

DATA : GV_CURR_INDEX TYPE INT4 VALUE 1.

DATA : GC_CUSTOM  TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_CUSTOM2 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_CUSTOM3 TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



DATA : GO_TREE TYPE REF TO CL_GUI_COLUMN_TREE.

DATA : GV_CLICKED_NODE TYPE TV_NODEKEY.





DATA : GC_GRID  TYPE REF TO CL_GUI_ALV_GRID,

       GC_GRID2 TYPE REF TO CL_GUI_ALV_GRID,

       GC_GRID3 TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.                     "ALV FCAT ### ### ##

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_VARIANT TYPE DISVARIANT.                      "ALV VARIANT ##

DATA : GS_LAYOUT TYPE LVC_S_LAYO.                       "ALV LAYOUT ##



DATA : GS_SORT TYPE LVC_S_SORT.                         "ALV SORT ### ### ##

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GV_CNT TYPE I VALUE 1.

DATA: GT_EXCLUDE TYPE UI_FUNCTIONS,

      GS_EXCLUDE TYPE UI_FUNC.

DATA : GV_CHECK_FLAG TYPE ABAP_BOOL.




*----------------------------------------------------------------------*

* SCREEN VARIANT

*----------------------------------------------------------------------*




DATA : MEINS1 TYPE ZEKPO01-MEINS,

       MEINS2 TYPE ZEKPO01-MEINS,

       MEINS3 TYPE ZEKPO01-MEINS.




*----------------------------------------------------------------------*

* Types

*----------------------------------------------------------------------*






TYPES : BEGIN OF TY_100.

TYPES :




*----------------------------------------------------------------------*

* ###

*----------------------------------------------------------------------*




        LIFNR      TYPE ZLFA1_01-LIFNR,    "#####

        NAME1      TYPE ZLFA1_01-NAME1,    "####

        LAND1      TYPE ZLFA1_01-LAND1,    "##

        PSTLZ      TYPE ZLFA1_01-PSTLZ,    "####

        ORT01      TYPE ZLFA1_01-ORT01,    "##



        PUR_LOEVM  TYPE ZLFB1_01-LOEVM,



        PUR_WAERS  TYPE ZLFM1_01-WAERS,    "### ## ##

        PUR_MWSKZ  TYPE ZLFM1_01-MWSKZ,    "### ####



        BUKRS      TYPE ZEKKO01-BUKRS,     "####

        EKORG      TYPE ZEKKO01-EKORG,     "####

        EKGRP      TYPE ZEKKO01-EKGRP,     "####

        BEDAT      TYPE ZEKKO01-BEDAT,     "######

        WAERS      TYPE ZEKKO01-WAERS,     "##

        INCO1      TYPE ZEKKO01-INCO1,     "####1

        INCO2      TYPE ZEKKO01-INCO2,     "####2



        EKORG_TX   TYPE T024E-EKOTX,       "#### ###

        EKGRP_TX   TYPE T024-EKNAM,        "#### ####




*----------------------------------------------------------------------*

* PO

*----------------------------------------------------------------------*




        EBELP      TYPE ZEKPO01-EBELP,     "#### ##

        EBELN      TYPE ZEKKO01-EBELN,     "######

        MATNR      TYPE ZEKPO01-MATNR,     "####

        MAKTX      TYPE ZEKPO01-MAKTX,     "###

        MATKL      TYPE ZEKPO01-MATKL,     "####

        MENGE      TYPE ZEKPO01-MENGE,     "##

        MEINS      TYPE ZEKPO01-MEINS,     "####

        BPRME      TYPE ZEKPO01-BPRME,     "######

        NETPR      TYPE ZEKPO01-NETPR,     "##

        NETWR      TYPE ZEKPO01-NETWR,     "###

        MWSKZ      TYPE ZEKPO01-MWSKZ,     "####

        WERKS      TYPE ZEKPO01-WERKS,     "###

        LGORT      TYPE ZEKPO01-LGORT,     "####

        PRDAT      TYPE ZEKPO01-PRDAT,     "###



        WERKS_TX TYPE T001W-NAME1,       "####

        LGORT_TX TYPE T001L-LGOBE,       "#####




*----------------------------------------------------------------------*

* ##

*----------------------------------------------------------------------*




        MBLNR       TYPE ZMKPF01-MBLNR,     "######

        MJAHR       TYPE ZMKPF01-MJAHR,     "####

        BLART       TYPE ZMKPF01-BLART,     "####

        BKTXT       TYPE ZMKPF01-BKTXT,     "#####



        ZEILE       TYPE ZMSEG01-ZEILE,     "## ####

        SHKZG       TYPE ZMSEG01-SHKZG,     "##/## ##

        DMBTR       TYPE ZMSEG01-DMBTR,     "## ##

        GR_QTY      TYPE ZMSEG01-MENGE,     "### ### ##(##)

        GR_DONE_QTY TYPE ZMSEG01-MENGE,     "### ## ##(##)

        REM_QTY     TYPE ZMSEG01-MENGE,     "## ## ##

        BWART       TYPE ZMSEG01-BWART,     "#### (## 101)




*----------------------------------------------------------------------*

* ##

*----------------------------------------------------------------------*




        BELNR       TYPE ZRBKP01-BELNR,      " ## ####

        BSCHL       TYPE ZBSEG01-BSCHL,

        KOART       TYPE ZBSEG01-KOART,

        HKONT       TYPE ZBSEG01-HKONT,

        SAKNR       TYPE ZBSEG01-SAKNR,

        KURSF       TYPE ZRBKP01-KURSF,






*----------------------------------------------------------------------*

* ####

*----------------------------------------------------------------------*




        BUDAT       TYPE ZMKPF01-BUDAT,     "###

        BLDAT       TYPE ZMKPF01-BLDAT,     "###

        TCODE       TYPE ZBKPF01-TCODE,     "#### ##



        CRNAME      TYPE ZMKPF01-CRNAME,     "###

        CRDATE      TYPE ZMKPF01-CRDATE,     "###

        CRZEIT      TYPE ZMKPF01-CRZEIT,     "####

        CPUDT       TYPE ZMKPF01-CRDATE,     "###

        CPUTM       TYPE ZMKPF01-CRZEIT,     "####




*----------------------------------------------------------------------*

* ##

*----------------------------------------------------------------------*




        CELLTAB    TYPE LVC_T_STYL,

        NO_EDIT    TYPE ABAP_BOOL,         " ## #### ### edit field# ##

        REMARK     TYPE CHAR20,            " ## (##### , ####)

        MODE_TX    TYPE C LENGTH 16,       "## # ### ## TEXT

        LINE       TYPE C LENGTH 4,

        ERR_FLAG   TYPE C LENGTH 1,        "## ##

        L_CHECK    TYPE C LENGTH 1,

        COLOR      TYPE C LENGTH 4,       "### @08@ @09@ @0A@

        STYLE      TYPE LVC_T_STYL.        "ALV ###(## ##/###)



TYPES  END OF TY_100.






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



DATA: GT_FI_ALV TYPE STANDARD TABLE OF TY_FI_ALV,

      GS_FI_ALV TYPE TY_FI_ALV.



DATA: GT_FI_SUM TYPE STANDARD TABLE OF TY_FI_SUM, "## ## ##

      GS_FI_SUM TYPE TY_FI_SUM.






*----------------------------------------------------------------------*

* Structure & Table

*----------------------------------------------------------------------*




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