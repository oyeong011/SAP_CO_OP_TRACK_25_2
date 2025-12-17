
*&---------------------------------------------------------------------*

*&  Include           ZWORK22_002_TOP

*&---------------------------------------------------------------------*






TABLES : ZTCURR22.



"ALV ###

"DATA : BEGIN OF GS_CURR_DIS,

"  KURST LIKE ZTCURR22-KURST,  "####

"  FCURR LIKE ZTCURR22-FCURR,  "####

"  TCURR LIKE ZTCURR22-TCURR,  "####

  "GDATU LIKE ZTCURR22-GDATU,  "####

"  UKURS LIKE ZTCURR22-UKURS,   "##

"  FFACT LIKE ZTCURR22-FFACT,  "########

"  TFACT LIKE ZTCURR22-TFACT,  "########

"  CRNAME TYPE SY-UNAME,       "###

"  CRDATE TYPE SY-DATUM,       "###

"END OF GS_CURR_DIS.

"DATA : GT_CURR_DIS LIKE TABLE OF GS_CURR_DIS.



TYPES: BEGIN OF ty_curr_dis,

         kurst  TYPE ztcurr22-kurst,

         fcurr  TYPE ztcurr22-fcurr,

         tcurr  TYPE ztcurr22-tcurr,

         gdatu  TYPE ztcurr22-gdatu,

         ukurs  TYPE ztcurr22-ukurs,

         ffact  TYPE ztcurr22-ffact,

         tfact  TYPE ztcurr22-tfact,

         crname TYPE ztcurr22-crname,

         crdate TYPE ztcurr22-crdate,

       END OF ty_curr_dis.

DATA: gs_curr_dis TYPE ty_curr_dis.

DATA: gt_curr_dis TYPE TABLE OF ty_curr_dis.



"OK##

DATA : OK_CODE TYPE SY-UCOMM.



"### ####

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA: GS_FIELDCAT TYPE LVC_S_FCAT.

DATA: GT_FIELDCAT TYPE LVC_T_FCAT.



DATA: GS_LAYOUT TYPE LVC_S_LAYO.



"PDF ### ## ##

DATA : GV_TEMP_DIR TYPE STRING."## ####



DATA : GV_TEMPLATE_PATH TYPE STRING."##### ### ##

DATA : GV_EXCEL_PATH TYPE STRING."### ## ##

DATA : GV_PDF_PATH TYPE STRING. "PDF ## ##



DATA : GV_TEMPLATE_RL TYPE RLGRAP-FILENAME."## ## ##

DATA : GV_PDF_PATH_RL TYPE RLGRAP-FILENAME."PDF ## ##



CONSTANTS: GC_DEBUG TYPE C VALUE 'X'."####