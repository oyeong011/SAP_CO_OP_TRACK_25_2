
*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_TOP

*&---------------------------------------------------------------------*




TABLES : ZEDT06_EKPO,

         ZEDT06_MKPF,

         ZEDT06_MSEG.




*&---------------------------------------------------------------------*

*&  ## ##

*&---------------------------------------------------------------------*




DATA : OK_CODE TYPE SY-UCOMM.



" ### ####.

DATA: GO_EVT_200 TYPE REF TO EVT_200,

      GO_EVT_300 TYPE REF TO EVT_300.






*&---------------------------------------------------------------------*

*&  ### ### TYPE ##

*&---------------------------------------------------------------------*




TYPES : BEGIN OF TY_EKPO,

  SEL       TYPE C,                 " ####

  EBELN     TYPE ZEDT06_EKPO-EBELN, " ######

  EBELP     TYPE ZEDT06_EKPO-EBELP, " ##

  MATNR     TYPE ZEDT06_EKPO-MATNR, " ####

  MAKTX     TYPE ZEDT06_EKPO-MAKTX, " ###

  MENGE     TYPE ZEDT06_EKPO-MENGE, " ##

  MENGE_MAX TYPE ZEDT06_EKPO-MENGE, " ## ##

  MENGE_IN  TYPE I,                 " ## ### ##.

  MEINS     TYPE ZEDT06_EKPO-MEINS, " ##

  BPRME     TYPE ZEDT06_EKPO-BPRME, " ##

  PRDAT     TYPE ZEDT06_EKPO-PRDAT, " ###

  WERKS     TYPE ZEDT06_EKPO-WERKS, " ###

  LGORT     TYPE ZEDT06_EKPO-LGORT, " ####

  WAERS     TYPE ZEDT06_EKKO-WAERS, " ##

  END OF TY_EKPO.



TYPES : BEGIN OF TY_EKKO,        " EKKO

  EBELN TYPE ZEDT06_EKKO-EBELN, " ######

  BUKRS TYPE ZEDT06_EKKO-BUKRS, " ####

  EKGRP TYPE ZEDT06_EKKO-EKGRP, " ####

  EKORG TYPE ZEDT06_EKKO-EKORG, " ####

  LIFNR TYPE ZEDT06_EKKO-LIFNR, " ###

  BEDAT TYPE ZEDT06_EKKO-BEDAT, " ###

  WAERS TYPE ZEDT06_EKKO-WAERS, " ##

  END OF TY_EKKO.



TYPES : BEGIN OF TY_MKPF,

  MBLNR TYPE ZEDT06_MKPF-MBLNR, " ###### -> 5### ##.

  MJAHR TYPE ZEDT06_MKPF-MJAHR, " #### -> 5000000000# ##

  BLART TYPE ZEDT06_MKPF-BLART, " #### (WE)

  BLDAT TYPE ZEDT06_MKPF-BLDAT, " ###

  BUDAT TYPE ZEDT06_MKPF-BUDAT, " ###

  END OF TY_MKPF.



TYPES : BEGIN OF TY_MSEG,

  SEL   TYPE C,                 " ####

  MBLNR TYPE ZEDT06_MSEG-MBLNR, " ######

  MJAHR TYPE ZEDT06_MSEG-MJAHR, " ####

  ZEILE TYPE ZEDT06_MSEG-ZEILE, " #####

  MATNR TYPE ZEDT06_MSEG-MATNR, " ####

  WERKS TYPE ZEDT06_MSEG-WERKS, " ###

  LGORT TYPE ZEDT06_MSEG-LGORT, " ####

  LIFNR TYPE ZEDT06_MSEG-LIFNR, " #####

  WAERS TYPE ZEDT06_MSEG-WAERS, " ###

  MENGE TYPE ZEDT06_MSEG-MENGE, " ##

  MEINS TYPE ZEDT06_MSEG-MEINS, " ##

  EBELN TYPE ZEDT06_MSEG-EBELN, " ######

  BUKRS TYPE ZEDT06_MSEG-BUKRS, " ####

  GJAHR TYPE ZEDT06_MSEG-GJAHR, " ####

  BELNR TYPE ZEDT06_MSEG-BELNR, " ####

  SHKZG TYPE ZEDT06_MSEG-SHKZG, " ###

  DMBTR TYPE ZEDT06_MSEG-DMBTR, " ##

  END OF TY_MSEG.




*&---------------------------------------------------------------------*

*& ## ### ## ##

*&---------------------------------------------------------------------*




TYPES: BEGIN OF TY_MKPF_DISPLAY,

         MBLNR TYPE CHAR10,

         MJAHR TYPE CHAR4,

         BLART TYPE CHAR2,

         BLDAT TYPE CHAR10,

         BUDAT TYPE CHAR10,

       END OF TY_MKPF_DISPLAY.



DATA: GS_MKPF_DISP TYPE TY_MKPF_DISPLAY.






*&---------------------------------------------------------------------*

*&  ### ### ### ##

*&---------------------------------------------------------------------*




DATA: GS_MSEG TYPE ZEDT06_MSEG,

      GT_MSEG TYPE STANDARD TABLE OF ZEDT06_MSEG.

DATA: GS_MSEG_ALV TYPE TY_MSEG,

      GT_MSEG_ALV TYPE STANDARD TABLE OF TY_MSEG.

DATA: GS_MKPF TYPE ZEDT06_MKPF,

      GT_MKPF TYPE STANDARD TABLE OF ZEDT06_MKPF.

DATA : GS_EKPO TYPE TY_EKPO,

       GT_EKPO TYPE TABLE OF TY_EKPO.

DATA : GS_EKKO TYPE TY_EKKO,

       GT_EKKO TYPE TABLE OF TY_EKKO.

DATA: GS_BKPF TYPE ZEDT06_BKPF,

      GS_BSEG TYPE ZEDT06_BSEG.






*&---------------------------------------------------------------------*

*& #### ## # ### ## ## ##

*&---------------------------------------------------------------------*




DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT,

       GS_LAYOUT   TYPE LVC_S_LAYO,

       GS_SORT     TYPE LVC_S_SORT,

       GT_SORT     TYPE LVC_T_SORT.



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.






*&---------------------------------------------------------------------*

*& #### ## # ### ## ## ##

*&---------------------------------------------------------------------*




DATA : GS_FIELDCAT_300 TYPE LVC_S_FCAT,

       GT_FIELDCAT_300 TYPE LVC_T_FCAT,

       GS_LAYOUT_300   TYPE LVC_S_LAYO,

       GS_SORT_300     TYPE LVC_S_SORT,

       GT_SORT_300     TYPE LVC_T_SORT.



DATA : GC_CUSTOM_300 TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : GC_GRID_300 TYPE REF TO CL_GUI_ALV_GRID.