
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_002_TOP

*&---------------------------------------------------------------------*



*----------------------------------------------------------------------*

* Tables

*----------------------------------------------------------------------*




TABLES : ZEKKO01, ZEKPO01.






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

            C_Z TYPE C           VALUE 'Z'.



CONSTANTS:  C_KTOKK_DOMESTIC   TYPE ZLFA1_01-KTOKK VALUE '1000',   "##

            C_KTOKK_FOREIGN    TYPE ZLFA1_01-KTOKK VALUE '2000',   "##

            C_KTOKK_PERSON     TYPE ZLFA1_01-KTOKK VALUE '3000',   "##

            C_KTOKK_CARD       TYPE ZLFA1_01-KTOKK VALUE '4000',   "####

            C_KTOKK_BANK       TYPE ZLFA1_01-KTOKK VALUE '5000',   "####

            C_KTOKK_ONETIME    TYPE ZLFA1_01-KTOKK VALUE '9000'.   "1##



CONSTANTS : C_INSR(4) TYPE C           VALUE 'INSR',

            C_DELE(4) TYPE C           VALUE 'DELE',

            C_SAVE(4) TYPE C           VALUE 'SAVE',

            C_BACK(4) TYPE C           VALUE 'BACK',

            C_EXIT(4) TYPE C           VALUE 'EXIT',

            C_ENTR(4) TYPE C           VALUE 'ENTR',

            C_CANC(4) TYPE C           VALUE 'CANC',

            C_SALL(4) TYPE C           VALUE 'SALL',

            C_DALL(4) TYPE C           VALUE 'DALL',

            C_TEXT(4) TYPE C           VALUE 'TEXT'.



CONSTANTS : GV_GRID_SIZE TYPE I VALUE 2000. " ## - DOCKING CONTAINER SIZE




*----------------------------------------------------------------------*

* VARIANT

*----------------------------------------------------------------------*




DATA: GV_OKCODE   TYPE SY-UCOMM,

      GV_MODE     TYPE CHAR10.                          " 'CREATE' 'DISPLAY'



DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.             "GRID ### ##



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.                     "ALV FCAT ### ### ##

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_VARIANT TYPE DISVARIANT.                      "ALV VARIANT ##

DATA : GS_LAYOUT TYPE LVC_S_LAYO.                       "ALV LAYOUT ##

DATA : GS_SORT TYPE LVC_S_SORT.                         "ALV SORT ### ### ##

DATA : GT_SORT TYPE LVC_T_SORT.



DATA: GT_EXCLUDE TYPE UI_FUNCTIONS,

      GS_EXCLUDE TYPE UI_FUNC.




*----------------------------------------------------------------------*

* Types

*----------------------------------------------------------------------*






TYPES : BEGIN OF TY_100.

TYPES :

        LIFNR      TYPE ZLFA1_01-LIFNR,         "#####

        LIFNR_TX   TYPE ZLFA1_01-NAME1,         "####

        LAND1      TYPE ZLFA1_01-LAND1,         "##



        PUR_LOEVM  TYPE ZLFB1_01-LOEVM,



        PUR_WAERS  TYPE ZLFM1_01-WAERS,         "### ## ##

        PUR_MWSKZ  TYPE ZLFM1_01-MWSKZ,         "### ####



        EBELN      TYPE ZEKKO01-EBELN,     "######

        BUKRS      TYPE ZEKKO01-BUKRS,     "####

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

        MWSKZ      TYPE ZEKPO01-MWSKZ,     "####

        WERKS      TYPE ZEKPO01-WERKS,     "###

        LGORT      TYPE ZEKPO01-LGORT,     "####

        PRDAT      TYPE ZEKPO01-PRDAT,     "###



        "### ## ## ###

        WERKS_NAME TYPE T001W-NAME1,       "####

        LGORT_NAME TYPE T001L-LGOBE,       "#####





        STATUS     TYPE C LENGTH 1,        "Y=### / G=#### / N=###

        ICON       TYPE ICON_D,            "ALV ###

        MSG        TYPE CHAR100,           "## ## ## ###

        ERR_FLAG   TYPE C LENGTH 1,        "## ##

        COLOR      TYPE LVC_T_SCOL,        "ALV ##

        STYLE      TYPE LVC_T_STYL.        "ALV ###(## ##/###)



TYPES  END OF TY_100.




*----------------------------------------------------------------------*

* Structure & Table

*----------------------------------------------------------------------*




DATA : GT_DISP_100 TYPE STANDARD TABLE OF TY_100,

       GS_DISP_100 TYPE TY_100.

DATA : GT_HEADER_100 TYPE STANDARD TABLE OF TY_100,

       GS_HEADER_100 TYPE TY_100.



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






*----------------------------------------------------------------------*

*  Objects

*----------------------------------------------------------------------*




DATA : GO_EVENT TYPE REF TO LCL_EVENT_RECEIVER.



DATA : LV_ERROR_FLAG TYPE I.