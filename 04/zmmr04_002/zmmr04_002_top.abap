
*&---------------------------------------------------------------------*

*&  Include           ZMMR04_00ZEKPO04_TOP

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

  EBELP TYPE ZEKPO04-EBELP,       " ##

  ZMATNR TYPE ZEKPO04-ZMATNR,     " ####

  ZMATNAME TYPE ZEKPO04-ZMATNAME, " ###

  MENGE TYPE ZEKPO04-MENGE,       " PO##

  STPRS TYPE ZEKPO04-STPRS,       " ##

  MEINS TYPE ZEKPO04-MEINS,       " ##

  WAERS TYPE ZEKKO04-WAERS,       " ##

  ZMWSKZ TYPE ZLFM1_04-ZMWSKZ,    " ####

  PRDAT TYPE ZEKPO04-PRDAT,       " ###

  ZWERKS TYPE ZEKPO04-ZWERKS,     " ###

  ZLGORT TYPE ZEKPO04-ZLGORT,     " ####

  MARK TYPE C,                    " ## ## ###

  END OF GS_PO.

DATA GT_PO LIKE TABLE OF GS_PO.



DATA GV_FLAG.   " ### ### #### ##