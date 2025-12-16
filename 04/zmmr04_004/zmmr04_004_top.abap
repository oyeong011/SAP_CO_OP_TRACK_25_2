
*&---------------------------------------------------------------------*

*&  Include           ZMMR04_004_TOP

*&---------------------------------------------------------------------*




DATA : OK_CODE TYPE SY-UCOMM.



DATA GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA GS_FIELDCAT TYPE LVC_S_FCAT.

DATA GT_FIELDCAT TYPE LVC_T_FCAT.



DATA GS_LAYOUT TYPE LVC_S_LAYO.

DATA GS_VARIANT TYPE DISVARIANT.



DATA GO_EVENT TYPE REF TO EVENT.



DATA : BEGIN OF GS_PO,

  L_CHECK TYPE C,                 " ##(####)

  EBELN TYPE ZEKPO04-EBELN,       " ######

  EBELP TYPE ZEKPO04-EBELP,       " ##

  LIFNR TYPE ZEKKO04-LIFNR,       " ###

  ZMATNAME TYPE ZEKPO04-ZMATNAME, " ###

  MENGE TYPE ZEKPO04-MENGE,       " ##

  MEINS TYPE ZEKPO04-MEINS,       " ##

  STPRS TYPE ZEKPO04-STPRS,       " ##

  WAERS TYPE ZEKKO04-WAERS,       " ##

  ZMWSKZ TYPE ZEKPO04-ZMWSKZ,     " ####

  ZNETAM TYPE ZRSEG04-ZNETAM,     " ###

  MWSTS TYPE ZRSEG04-MWSTS,       " ##

  ZGROSS TYPE ZRSEG04-ZGROSS,     " ###

  END OF GS_PO.

DATA GT_PO LIKE TABLE OF GS_PO.



DATA : BEGIN OF GS_INVOICE.

  include structure
ZRSEG04
.

  DATA : L_CHECK TYPE C,  " ## ## ## ####

  ZMATNAME TYPE ZEKPO04-ZMATNAME, " ###

  WAERS TYPE ZEKKO04-WAERS,       " ##

  END OF GS_INVOICE.

DATA GT_INVOICE LIKE TABLE OF GS_INVOICE.






*## ZRBKP04

*######* BELNR

*####*   GJAHR

*####    BUKRS

*###     LIFNR

*##      WAERS

*###     BLDAT

*###     BUDAT



*### ZRSEG04

**###### BELNR

**#### GJAHR

**##### BUZEI

*###### EBELN

*### ZWERKS

*#### MATNR

*## MENGE

*##  MEINS

*#### ZMWSKZ

*## STPRS

*#### ZNETAM

*##  MWSTS

*##  ZGROSS