
*&---------------------------------------------------------------------*

*&  Include           ZMM03_004_TOP

*&---------------------------------------------------------------------*



* ### ##




TABLES: ZEDT03_RBKP,"##### ##

        ZEDT03_RSEG,"##### ###

        ZEDT03_BSIK,"## ###

        ZEDT03_EKKO,"#### ## (### ###)

        ZEDT03_EKPO,"#### ### (### ###)

        SSCRFIELDS. "## ##






* ### ### ## (ALV ###)




DATA: BEGIN OF GS_DATA,

        L_CHECK TYPE C,              " ####

        "#### ##

        EBELN   TYPE ZEDT03_EKKO-EBELN, "######

        EBELP   TYPE ZEDT03_EKPO-EBELP, "####

        LIFNR   TYPE ZEDT03_EKKO-LIFNR, "###

        MATNR   TYPE ZEDT03_EKPO-MATNR, "####

        MAKTX   TYPE ZEDT03_EKPO-MAKTX, "###

        WERKS   TYPE ZEDT03_EKPO-WERK,  "###

        WAERS   TYPE ZEDT03_EKKO-WAERS, "##

        EKORG   TYPE ZEDT03_EKKO-EKORG, "####

        "## ##

        MENGE   TYPE ZEDT03_EKPO-MENGE, "PO## (###)

        IVMNG   TYPE ZEDT03_RSEG-MENGE, "#### (##/##)

        MEINS   TYPE ZEDT03_EKPO-MEINS, "##

        BPRME   TYPE ZEDT03_EKPO-BPRME, "##

        WRBTR   TYPE ZEDT03_RSEG-WRBTR, "####

        MWSKZ   TYPE ZEDT03_RSEG-MWSKZ, "####

        MWSTS   TYPE ZEDT03_BSIK-MWSTS, "##

        SGTXT   TYPE ZEDT03_BSIK-SGTXT, "##

        "## ##

        BELNR   TYPE ZEDT03_RBKP-BELNR, "######

        GJAHR   TYPE ZEDT03_RBKP-GJAHR, "####

        BLDAT   TYPE ZEDT03_RBKP-BLDAT, "###

        SHKZG   TYPE ZEDT03_RSEG-SHKZG, "######

        STBLG   TYPE ZEDT03_RBKP-STBLG, "#####

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