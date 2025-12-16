
*&---------------------------------------------------------------------*

*&  Include           ZWORK09_002_TOP

*&---------------------------------------------------------------------*




"OLE2 ###

TYPE-POOLS : OLE2.



"##ALV ######

DATA : BEGIN OF GS_CURR_ALV,

  KURST LIKE ZTCURR09-KURST,  "####

  FCURR LIKE ZTCURR09-FCURR,  "####

  TCURR LIKE ZTCURR09-TCURR,  "####

  GDATU LIKE ZTCURR09-GDATU,  "####

  UKURS LIKE ZTCURR09-UKURS,   "##

  FFACT LIKE ZTCURR09-FFACT,  "########

  TFACT LIKE ZTCURR09-TFACT,  "########

  ERNAME TYPE SY-UNAME,       "###

  ERDATE TYPE SY-DATUM,       "###

END OF GS_CURR_ALV.

DATA : GT_CURR_ALV LIKE TABLE OF GS_CURR_ALV.



"OK_CODE

DATA : OK_CODE TYPE SY-UCOMM.



"custom #### ####

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.



"grid #### ####

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



"######, ####

DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



"PDF ##### ## ##

DATA : GV_EXCEL_DIR TYPE STRING,           "## ####

       GV_PDF_DIR TYPE STRING,             "#### ## #### ####

       GV_TEMPLATE_FULL_PATH TYPE STRING,  "## ## ### ## ## ##

       GV_PDF_FULL_PATH TYPE STRING.       "PDF ## ## ##



"OLE ##

DATA : GO_EXCEL TYPE OLE2_OBJECT,          "Excel.Application

       GO_SHEET TYPE OLE2_OBJECT.          "ActiveSheet



"RLGRAP-FILENAME ## ##

DATA : GV_TEMPLATE_RLGRAP TYPE RLGRAP-FILENAME,

       GV_PDF_RLGRAP TYPE RLGRAP-FILENAME.