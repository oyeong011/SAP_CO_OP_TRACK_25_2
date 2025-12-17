
*&---------------------------------------------------------------------*

*&  Include           ZMM21_004_TOP

*&---------------------------------------------------------------------*






           "### ## " ## ### "## ## "##### "## ## "## ###

  TABLES : ZEKKO21, ZEKPO21, ZMKPF21, ZMSEG21, ZRBKP21, ZRSEG21.



  "## ## ### ##





DATA : BEGIN OF gs_inv,

  zcheck TYPE char1,                 "####



  bukrs TYPE zrseg21-bukrs,          "####

  ebeln TYPE zrseg21-ebeln,          "######

  ebelp TYPE zrseg21-ebelp,          "########

  matnr TYPE zrseg21-matnr,          "####

  buzei  TYPE zrseg21-buzei,

  dmbtr TYPE bsik-dmbtr,           "####

  mwsts TYPE bsik-mwsts,           "##

  costs TYPE bsik-dmbtr,           "### (#### + ##)



  waers TYPE zmseg21-waers,           "##

  mwskz TYPE bsik-mwskz,           "####

  sgtxt TYPE bsik-sgtxt,                  "###



  lifnr TYPE zmseg21-lifnr,           "###



  bstme TYPE zrseg21-bstme,           "##

  menge TYPE zmseg21-menge,           "##

  meins TYPE zmseg21-meins,           "## (###)

END OF gs_inv.







DATA : GT_INV LIKE TABLE OF GS_INV.



DATA : BEGIN OF gs_inv_search,

  zcheck TYPE char1,                 "####



  belnr  TYPE zrseg21-belnr,          "#### #

  gjahr  TYPE zrseg21-gjahr,          "#### #



  bukrs  TYPE zrseg21-bukrs,          "####

  ebeln  TYPE zrseg21-ebeln,          "######

  werks  TYPE zrseg21-werks,          "###

  buzei  TYPE zrseg21-buzei,

  dmbtr  TYPE bsik-dmbtr,             "####

  mwsts  TYPE bsik-mwsts,             "##

  waers  TYPE zmseg21-waers,          "##

  mwskz  TYPE bsik-mwskz,             "####

  sgtxt  TYPE bsik-sgtxt,             "###

  lifnr  TYPE zmseg21-lifnr,          "#####

END OF gs_inv_search.



DATA : GT_INV_SEARCH LIKE TABLE OF GS_INV_SEARCH.



"## ## ### ##

DATA : GS_MKPF TYPE ZMKPF21.

DATA : GT_MKPF LIKE TABLE OF GS_MKPF.



DATA : GS_MSEG TYPE ZMSEG21.

DATA : GT_MSEG LIKE TABLE OF GS_MSEG.

"## ## ### ##

DATA : GS_RBKP TYPE ZRBKP21.

DATA : GT_RBKP LIKE TABLE OF ZRBKP21.



DATA : GS_RSEG TYPE ZRSEG21.

DATA : GT_RSEG LIKE TABLE OF GS_RSEG.



 "## ### ###



  DATA : BEGIN OF GS_CHECK.

    INCLUDE STRUCTURE GS_RSEG.

    DATA : ZCHECK TYPE C,

          END OF GS_CHECK.

  DATA : GT_CHECK LIKE TABLE OF GS_CHECK.





  "## OK_CODE

  DATA : OK_CODE TYPE SY-UCOMM.

  "DOCKING CONTAINER ## ## ##

  DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.



  "### ## ##

  DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

  DATA : GS_VARIANT TYPE DISVARIANT.





  "###### ## ## ##

  DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

  DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

  DATA : GS_LAYOUT TYPE LVC_S_LAYO.

  "ALV SORT ## ##

  DATA : GS_SORT TYPE LVC_S_SORT.

  DATA : GT_SORT TYPE LVC_T_SORT.

  "EVENT ## ##

  DATA : GO_EVENT TYPE REF TO EVENT.