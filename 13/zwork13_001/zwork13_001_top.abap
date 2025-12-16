
*&---------------------------------------------------------------------*

*&  Include           ZWORK13_001_TOP

*&---------------------------------------------------------------------*






"-------------------------------------## ###-------------------------------------"

DATA : LV_FILE_NAME TYPE STRING.                       "## ## ## ## ##"

DATA : LV_FILE_TABLE TYPE FILETABLE.                  "## FILE_TABLE"

DATA : LV_RC TYPE I.                                  "## ## ## ##"



DATA : GS_MAP_EXCEL TYPE ALSMEX_TABLINE,              "# ## ### ### ###"

       GT_MAP_EXCEL LIKE TABLE OF GS_MAP_EXCEL.



FIELD-SYMBOLS: <FS_EXCEL_LINE> TYPE ALSMEX_TABLINE.



DATA : GS_FINAL TYPE ZTCURR13,                        "#### #### #### ###"

       GT_FINAL LIKE TABLE OF GS_FINAL.

"------------------------------------### ####------------------------------------"

TABLES : SSCRFIELDS.              "### #### #### ##### ###"

SELECTION-SCREEN FUNCTION KEY 1.  "## 1 ###"

DATA : I_FUNCTXT TYPE SMP_DYNTXT. "## ###### ###"



DATA:

  LS_KEY    TYPE WWWDATATAB,           "WWWDATA #### # ### ### ###"

  LV_FILE   TYPE STRING,               "#### ### ### (####)"

  LV_PATH   TYPE STRING,               "#### ### ## ## (###)"

  LV_FUPATH TYPE STRING,               "#### ### ### ## ## (## + ###)"

  LV_DEST   TYPE LOCALFILE.            "'DOWNLOAD_WEB_OBJECT' ### ### ### ## (LOCALFILE ##)"



CONSTANTS:

  LC_OBJID    TYPE WWWDATATAB-OBJID VALUE 'ZTCURR_EXCEL',  "WWWDATA #### ID"

  LC_DEF_FNAME TYPE STRING VALUE '## #### ###.xlsx'.      "## ### #### ### ## ##"





DATA : OK_CODE TYPE SY-UCOMM.



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GO_EVENT TYPE REF TO EVENT.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.



DATA : GS_VARIANT TYPE DISVARIANT.