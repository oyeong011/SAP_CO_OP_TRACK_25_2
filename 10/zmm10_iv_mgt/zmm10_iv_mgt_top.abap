
*&---------------------------------------------------------------------*

*& Include          ZMM10_IV_MGT_TOP

*&---------------------------------------------------------------------*




TABLES: ICON.






* [### ##]




TABLES: ZEDT10_EKKO,   " #### ##

        ZEDT10_EKPO,   " #### ###

        ZEDT10_RBKP,   " ## ##

        ZEDT10_RSEG,   " ## ###

        ZEDT10_EKBE,   " #### ##

        ZEDT10_LFM1,   " ### ### (#### ###)

        ZEDT10_MWSKZ.  " #### ###



" ALV # ## ### ##/##

CONSTANTS: C_MODE_CREA TYPE C VALUE 'C',  " ## ##

           C_MODE_DISP TYPE C VALUE 'D'.  " ## ##



CONSTANTS: C_DOC_RE   TYPE BLART VALUE 'RE',  " ####: ####

           C_SHKZG_H  TYPE SHKZG VALUE 'H',  " ## (#### ##)

           C_SHKZG_S  TYPE SHKZG VALUE 'S',  " ## (##/##)

           C_VGABE_IV TYPE VGABE VALUE '2'. " PO##: ##(Invoice)







" ALV ### ### # ### ###




* [ALV ### ### ## - GS_DATA]




DATA: BEGIN OF GS_DATA,

        " 1. ## ##

        L_CHECK TYPE C,              " ####

        ICON    TYPE C LENGTH 4,     " ## ###

        MESSAGE TYPE C LENGTH 100,   " ###



        " 2. ####(PO) ## ##

        EBELN   TYPE ZEDT10_EKPO-EBELN, " PO ##

        EBELP   TYPE ZEDT10_EKPO-EBELP, " PO ##

        MATNR   TYPE ZEDT10_EKPO-MATNR, " ## ##

        MAKTX   TYPE ZEDT10_EKPO-MAKTX, " ## ##

        WERKS   TYPE ZEDT10_EKPO-WERKS, " ###

        LGORT   TYPE ZEDT10_EKPO-LGORT, " ####



        " 3. ## # ## ##

        MENGE   TYPE ZEDT10_EKPO-MENGE, " ## (## or ####)

        MEINS   TYPE ZEDT10_EKPO-MEINS, " ##

        NETPR   TYPE ZEDT10_EKPO-NETPR, " ## (PO ##)

        WAERS   TYPE ZEDT10_EKKO-WAERS, " ##



        " 4. ## ## ## ## (##)

        WRBTR   TYPE ZEDT10_RSEG-WRBTR, " #### (## * ##)

        MWSKZ   TYPE ZEDT10_RSEG-MWSKZ, " ####

        MWSTS   TYPE ZEDT10_BSIK-MWSTS, " ## (###)

        DMBTR   TYPE ZEDT10_RBKP-DMBTR, " ### (### + ##)

        SHKZG   TYPE ZEDT10_RSEG-SHKZG, " ### (S/H)



        " 5. ## # ## ##

        BUKRS   TYPE ZEDT10_EKKO-BUKRS, " ####

        LIFNR   TYPE ZEDT10_EKKO-LIFNR, " ###

        SGTXT   TYPE ZEDT10_BSIK-SGTXT, " ## (###)



        " 6. ## ## ## (## ###)

        BELNR   TYPE ZEDT10_RBKP-BELNR, " ## ##

        GJAHR   TYPE ZEDT10_RBKP-GJAHR, " ## ##

        BUDAT   TYPE ZEDT10_RBKP-BUDAT, " ###



      END OF GS_DATA.



DATA: GT_DATA LIKE TABLE OF GS_DATA.





" ALV ## ## ##

DATA: GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_ALV       TYPE REF TO CL_GUI_ALV_GRID.



" ### ### ### ## ##

CLASS LCL_EVENT_HANDLER DEFINITION DEFERRED.

DATA: GO_HANDLER TYPE REF TO LCL_EVENT_HANDLER.



" Layout # Field Catalog

DATA: GS_LAYOUT TYPE LVC_S_LAYO,

      GT_FCAT   TYPE LVC_T_FCAT.



" DB ##### ### ###

DATA: LT_RBKP TYPE TABLE OF ZEDT10_RBKP,

      LT_RSEG TYPE TABLE OF ZEDT10_RSEG,

      LT_BSIK TYPE TABLE OF ZEDT10_BSIK,

      LT_EKBE TYPE TABLE OF ZEDT10_EKBE.



" OK_CODE

DATA: OK_CODE TYPE SY-UCOMM.