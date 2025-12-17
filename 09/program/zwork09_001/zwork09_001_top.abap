
*&---------------------------------------------------------------------*

*&  Include           ZWORK09_001_TOP

*&---------------------------------------------------------------------*






TABLES : SSCRFIELDS. "Selection Screen# ## ##### ###

SELECTION-SCREEN FUNCTION KEY 1. "## 1# ## (### ####)



"SMW0 # ###

DATA : GS_WWWKEY TYPE WWWDATATAB.



"##

CONSTANTS :

  C_OBJID TYPE W3OBJID VALUE 'ZCURR09_TPL', "SMW0 #### ID

  C_TPLNAME TYPE STRING VALUE '######_###.csv'."#####



"##, ## ALV ######

DATA : GS_CURR TYPE ZTCURR09,

       GT_CURR LIKE TABLE OF GS_CURR.



DATA : BEGIN OF GS_CURR_ALV,

  KURST LIKE ZTCURR09-KURST,  "####

  FCURR LIKE ZTCURR09-FCURR,  "####

  TCURR LIKE ZTCURR09-TCURR,  "####

  GDATU LIKE ZTCURR09-GDATU,  "####

  UKURS TYPE P LENGTH 9 DECIMALS 5, "##

 " UKURS LIKE ZTCURR09-UKURS,   "##

  FFACT LIKE ZTCURR09-FFACT,  "########

  TFACT LIKE ZTCURR09-TFACT,  "########

  ERNAME TYPE SY-UNAME,       "###

  ERDATE TYPE SY-DATUM,       "###

END OF GS_CURR_ALV.

DATA : GT_CURR_ALV LIKE TABLE OF GS_CURR_ALV.



"OK_CODE

DATA : OK_CODE TYPE SY-UCOMM.



"docking ####, grid ## ####

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



"######, ####, ## ## ##

DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



DATA : GS_SORT TYPE LVC_S_SORT,

       GT_SORT TYPE LVC_T_SORT.



"#### ## ## ##

DATA : GS_VARIANT TYPE DISVARIANT.



"### ##

DATA : GO_EVENT TYPE REF TO EVENT.