
*&---------------------------------------------------------------------*

*&  Include           ZMM12_003_TOP

*&---------------------------------------------------------------------*




TABLES: ZEKKO_12, ZEKPO_12. " #### ## / #### ##

TABLES: ZMKPF_12, ZMSEG_12. " #### ## / #### ##

DATA : GS_EKKO TYPE ZEKKO_12,         "######

       GT_EKKO LIKE TABLE OF GS_EKKO,

       GS_EKPO TYPE ZEKPO_12,         "#######

       GT_EKPO LIKE TABLE OF GS_EKPO,

       GS_MKPF TYPE ZMKPF_12,         "######

       GT_MKPF LIKE TABLE OF GS_MKPF,

       GS_MSEG TYPE ZMSEG_12,         "#######

       GT_MSEG LIKE TABLE OF GS_MSEG.



DATA : BEGIN OF GS_PO,

  CHECK TYPE C,                 " ##(####)

  EBELN TYPE ZEKPO_12-EBELN,       " ######

  EBELP TYPE ZEKPO_12-EBELP,       " ##

  LIFNR TYPE ZEKKO_12-LIFNR,       " ###

  BEDAT TYPE ZEKKO_12-BEDAT,         " ###

  MATNR TYPE ZEKPO_12-MATNR,     " ####

  MATNAME TYPE ZEKPO_12-MATNAME, " ###

  MENGE TYPE ZEKPO_12-MENGE,       " ##

  MEINS TYPE ZEKPO_12-MEINS,       " ##

  STPRS TYPE ZEKPO_12-STPRS,       " ##

  WAERS TYPE ZEKKO_12-WAERS,       " ##

  PRDAT TYPE ZEKPO_12-PRDAT,       " ###

  WERKS TYPE ZEKPO_12-WERKS,     " ###

  LGORT TYPE ZEKPO_12-LGORT,     " ####

  END OF GS_PO.

DATA GT_PO LIKE TABLE OF GS_PO.



DATA : BEGIN OF GS_MG, "#######

       CHECK TYPE C.     "#### ###.

       include structure
ZMSEG_12
.

DATA : END OF GS_MG.

DATA: GT_MG LIKE TABLE OF GS_MG.



DATA : OK_CODE TYPE SY-UCOMM.



DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA: GS_FIELDCAT TYPE LVC_S_FCAT.

DATA: GT_FIELDCAT TYPE LVC_T_FCAT.

DATA: GS_FIELDCAT2 TYPE LVC_S_FCAT.

DATA: GT_FIELDCAT2 TYPE LVC_T_FCAT.



DATA: GS_LAYOUT TYPE LVC_S_LAYO.

DATA: GS_VARIANT TYPE DISVARIANT.



DATA: GO_EVENT TYPE REF TO EVENT.