
*&---------------------------------------------------------------------*

*&  Include           ZMM05_003_TOP

*&---------------------------------------------------------------------*






TABLES : ZMKPF_05. "##-##

TABLES : ZMSEG_05. "##-###

TABLES : ZEKKO_05. "####-##

TABLES : ZEKPO_05. "####-###



"## ## ## (ZMKPF_05 ##)

DATA : BEGIN OF GS_MKPF,

  MBLNR LIKE ZMKPF_05-MBLNR,  "#### ##

  MJAHR LIKE ZMKPF_05-MJAHR,  "####

  BLART LIKE ZMKPF_05-BLART,  "####

  BLDAT LIKE ZMKPF_05-BLDAT,  "###

  BUDAT LIKE ZMKPF_05-BUDAT,  "###

  " ##: ZMKPF_05# EBELN, WERKS# #### ## ##### ## ## ## ### # ##

  " ## ## ## ### ## ##### ####, INSERT# ##

  EBELN LIKE ZEKKO_05-EBELN,

  WERKS LIKE ZEKPO_05-WERKS,

END OF GS_MKPF.

DATA : GT_MKPF LIKE TABLE OF GS_MKPF.



DATA : GV_SELECTED_MBLNR LIKE ZMKPF_05-MBLNR. "



"## ## ### (ZMSEG_05 ##)

DATA : BEGIN OF GS_MSEG,

  MBLNR  LIKE ZMSEG_05-MBLNR,   "######

  MJAHR  LIKE ZMSEG_05-MJAHR,   "####

  ZEILE  LIKE ZMSEG_05-ZEILE,   "##### (PO #### ## ##)

  BWART  LIKE ZMSEG_05-BWART,   "####

  MATNR  LIKE ZMSEG_05-MATNR,   "####

  ZWERKS LIKE ZMSEG_05-ZWERKS,  "### (### ###)

  ZLGORT LIKE ZMSEG_05-ZLGORT,  "#### (### ###)

  LIFNR  LIKE ZMSEG_05-LIFNR,   "#####

  WAERS  LIKE ZMSEG_05-WAERS,   "###

  MENGE  LIKE ZMSEG_05-MENGE,   "##

  MEINS  LIKE ZMSEG_05-MEINS,   "##

  EBELN  LIKE ZMSEG_05-EBELN,   "#### ##

  BUKRS  LIKE ZMSEG_05-BUKRS,   "####

  GJAHR  LIKE ZMSEG_05-GJAHR,   "####

  BELNR  LIKE ZMSEG_05-BELNR,   "#### (###)

  SHKZG  LIKE ZMSEG_05-SHKZG,   "###

  DMBTR  LIKE ZMSEG_05-DMBTR,   "##



  CHECK      TYPE C,

  EBELP      TYPE EBELP,       " PO ## ## (10, 20...)

  MAKTX      TYPE MAKTX,       " ###

  PO_MENGE   TYPE MENGE_D,     " PO ##

  BLDAT      TYPE BLDAT,       " ### (## ##)

  STATUS_TXT TYPE C LENGTH 10, " ## (##/##)

  END OF GS_MSEG.

DATA : GT_MSEG LIKE TABLE OF GS_MSEG.



"## ## ### (ALV ### ###)

DATA : BEGIN OF GS_ITEM,

  CHECK    TYPE C,                  "## ####

  BWART    LIKE ZMSEG_05-BWART,     "####

  EBELN    LIKE ZEKPO_05-EBELN,     "######

  EBELP    LIKE ZEKPO_05-EBELP,     "##

  LIFNR    LIKE ZEKKO_05-LIFNR,     "###

  BEDAT    LIKE ZEKKO_05-BEDAT,     "###

  MATNR    LIKE ZEKPO_05-MATNR,     "####

  MAKTX    LIKE ZEKPO_05-MAKTX,     "###

  MENGE    LIKE ZEKPO_05-MENGE,     "## ## ##



  " [##] ZEKPO_05# WEMNG# ### ## ### ## ###

  WEMNG    LIKE ZEKPO_05-MENGE,     "## ## ## (## Type ##)

  OPEN_QTY LIKE ZEKPO_05-MENGE,     "### ##

  GR_QTY   LIKE ZEKPO_05-MENGE,     "## ## ##



  MEINS    LIKE ZEKPO_05-MEINS,     "##

  STPRS    LIKE ZEKPO_05-STPRS,     "##

  WAERS    LIKE ZEKKO_05-WAERS,     "##

  PRDAT    LIKE ZEKPO_05-PRDAT,     "###

  WERKS    LIKE ZEKPO_05-WERKS,     "###

  LGORT    LIKE ZEKPO_05-LGORT,     "####

  END OF GS_ITEM.

DATA : GT_ITEM LIKE TABLE OF GS_ITEM.



"#### ##

DATA : BEGIN OF GS_PO_HEADER.

  include structure
ZEKKO_05
.

  DATA : WERKS TYPE WERKS_D.

DATA : END OF GS_PO_HEADER.



DATA : OK_CODE TYPE SY-UCOMM.



"#### ###

DATA : BEGIN OF GS_PO_ITEM.

  include structure
ZEKPO_05
.

  " [##] DB ## # WEMNG ## ## ## ## ## (## DB# #### ##)

  DATA : WEMNG LIKE ZEKPO_05-MENGE.

DATA : END OF GS_PO_ITEM.

DATA : GT_PO_ITEM LIKE TABLE OF GS_PO_ITEM.



"### ## # ALV ## ##

DATA : GO_EVENT TYPE REF TO LCL_EVENT_HANDLER,

       GY_DYNNR TYPE SY-DYNNR VALUE '0101'.



"[100# ###]

DATA : GC_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GC_GRID      TYPE REF TO CL_GUI_ALV_GRID.



DATA : GC_CONTAINER_201 TYPE REF TO CL_GUI_CUSTOM_CONTAINER, " CON2 ##

       GC_SPLITTER      TYPE REF TO CL_GUI_SPLITTER_CONTAINER, " ### ##

       GC_PARENT_LEFT   TYPE REF TO CL_GUI_CONTAINER,          " ## # (###)

       GC_PARENT_RIGHT  TYPE REF TO CL_GUI_CONTAINER.          " ### # (ALV#)



DATA : GO_TREE          TYPE REF TO CL_GUI_SIMPLE_TREE,        " ## ##

       GC_GRID_201      TYPE REF TO CL_GUI_ALV_GRID.           " ALV ##



"SUBSCREEN

DATA : GS_FC TYPE LVC_S_FCAT,

       GT_FC TYPE LVC_T_FCAT.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.