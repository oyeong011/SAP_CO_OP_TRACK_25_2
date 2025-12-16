
*&---------------------------------------------------------------------*

*&  Include           ZWORK13_002_TOP

*&---------------------------------------------------------------------*






DATA: GS_TCURR TYPE ZTCURR13,

      GT_TCURR LIKE TABLE OF GS_TCURR.



DATA: LS_KEY      TYPE WWWDATATAB,      "WWWDATA #### # ### ### ###"

      LV_XLSXFILE TYPE RLGRAP-FILENAME. "XLSX## ## ##"



DATA: LO_APPLICATION TYPE OLE2_OBJECT,  "Excel####"

      LO_WORKBOOKS   TYPE OLE2_OBJECT,  "## ## ### ##"

      LO_WORKBOOK    TYPE OLE2_OBJECT,  "## ## ##"

      LO_WORKSHEET   TYPE OLE2_OBJECT,  "## ## ## ## ####"

      LO_CELL        TYPE OLE2_OBJECT.  "#### ## ## #"



DATA LV_ROW TYPE I VALUE 2. "#### # ## # 2### ##, 1## ######"



DATA: LV_PDFNAME     TYPE STRING,     "PDF ## ##"

      LV_PDFFILE TYPE STRING.



DATA : LV_XLSXFILE_STRING TYPE STRING.

DATA : LV_RC TYPE I. "RETURN CODE"






*&------------------------------PDF ##---------------------------------*




DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



DATA : GS_SORT TYPE LVC_S_SORT,

       GT_SORT TYPE LVC_T_SORT.



DATA : GS_VARIANT TYPE DISVARIANT.



DATA: GV_TEMP_DIR TYPE STRING.

DATA: GV_SAVE_DIR TYPE STRING.



DATA : OK_CODE TYPE SY-UCOMM.