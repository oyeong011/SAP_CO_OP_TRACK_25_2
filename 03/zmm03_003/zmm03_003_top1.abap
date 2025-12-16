
*&---------------------------------------------------------------------*

*&  Include           ZMM03_003_TOP

*&---------------------------------------------------------------------*

* ### ##




TABLES : ZEDT03_MKPF, "##### ##

         ZEDT03_MSEG, "##### ###

         ZEDT03_EKKO, "#### ##

         ZEDT03_EKPO, "#### ###

         SSCRFIELDS.






* ### ### ## (ALV ###)




DATA: BEGIN OF GS_DATA,

        L_CHECK TYPE C,             " #### (###)

        " --- #### ## (EKKO) ---

        EBELN   TYPE ZEDT03_EKKO-EBELN,   "######

        LIFNR   TYPE ZEDT03_EKKO-LIFNR,   "###

        BEDAT   TYPE ZEDT03_EKKO-BEDAT,   "###

        WAERS   TYPE ZEDT03_EKKO-WAERS,   "##

        " --- #### ### (EKPO) ---

        EBELP   TYPE ZEDT03_EKPO-EBELP,   "####

        MATNR   TYPE ZEDT03_EKPO-MATNR,   "####

        MAKTX   TYPE ZEDT03_EKPO-MAKTX,   "###

        MENGE   TYPE ZEDT03_EKPO-MENGE,   "PO## (## ## ##)

        MEINS   TYPE ZEDT03_EKPO-MEINS,   "##

        BPRME   TYPE ZEDT03_EKPO-BPRME,   "##

        PRDAT   TYPE ZEDT03_EKPO-PRDAT,   "###

        WERKS   TYPE ZEDT03_EKPO-WERK,    "###

        LGORT   TYPE ZEDT03_EKPO-LGORT,   "####

        " --- ## ### ## ## ---

        GMENGE TYPE ZEDT03_MSEG-MENGE,  "### ## (## ###)

        MBLNR    TYPE ZEDT03_MKPF-MBLNR,  "###### (###)

        MJAHR    TYPE ZEDT03_MKPF-MJAHR,  "#### (###)

        LOEKZ    TYPE ZEDT03_MSEG-LOEKZ,  "#####

      END OF GS_DATA.



DATA: GT_DATA LIKE TABLE OF GS_DATA.






* ### ### ##




DATA : OK_CODE TYPE SY-UCOMM.



" GUI STATUS## ### ### ## ### ##

DATA: GT_EXCLUDE TYPE TABLE OF SY-UCOMM.






* ALV ## ### ###




DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER. " ####(##)

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID. " ALV ###



DATA : GO_EVENT TYPE REF TO LCL_EVENT. "### ###



DATA : GS_FIELDCAT TYPE LVC_S_FCAT. "## ####

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO. "####



DATA : GS_SORT TYPE LVC_S_SORT. "##

DATA : GT_SORT TYPE LVC_T_SORT.