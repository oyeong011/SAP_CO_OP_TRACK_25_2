
*&---------------------------------------------------------------------*

*&  Include           ZWORK24_001_TOP

*&---------------------------------------------------------------------*






"SCR## ### ### ##

TABLES : ZTCURR24.

TABLES : SSCRFIELDS.



"## #### ## ##

DATA : GT_FILE_TABLE TYPE FILETABLE,

       GV_RC TYPE I,

       GV_FILENAME TYPE STRING.



"## ## ### #### ##

DATA : BEGIN OF GS_EXCEL,

  KURST LIKE ZTCURR24-KURST, "## ##

  FCURR LIKE ZTCURR24-FCURR, "## ##

  TCURR LIKE ZTCURR24-TCURR, "## ##

  GDATU LIKE ZTCURR24-GDATU, "## ## ###

  UKURS LIKE ZTCURR24-UKURS, "##

  FFACT LIKE ZTCURR24-FFACT, "## ## ### ##

  TFACT LIKE ZTCURR24-TFACT, "## ## ### ##

END OF GS_EXCEL.

DATA : GT_EXCEL LIKE TABLE OF GS_EXCEL.



"## ## ## ## ##

DATA : BEGIN OF GS_OUTPUT.

  include structure
ZTCURR24
.

DATA : END OF GS_OUTPUT.

DATA : GT_OUTPUT LIKE TABLE OF GS_OUTPUT.



"ALV

"### ##

DATA : OK_CODE TYPE SY-UCOMM.



"## ##

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

DATA : GS_FC TYPE LVC_S_FCAT,

       GT_FC TYPE LVC_T_FCAT.



"## ### ##

DATA : GO_EVENT TYPE REF TO EVENT.