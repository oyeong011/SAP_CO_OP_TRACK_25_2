
"====================================================================="

include structure
ZWORK11_001_TOP
.

"====================================================================="

TABLES: ZTCURR11, SSCRFIELDS.






* ALV/## ## ## (## ### 1:1 ##)




DATA: BEGIN OF GS_TCURR,

        KURST  LIKE ZTCURR11-KURST,   "####

        FCURR  LIKE ZTCURR11-FCURR,   "####

        TCURR  LIKE ZTCURR11-TCURR,   "####

        GDATU  LIKE ZTCURR11-GDATU,   "####

        UKURS  LIKE ZTCURR11-UKURS,   "## (## ##)

        FFACT  LIKE ZTCURR11-FFACT,   "#### ####

        TFACT  LIKE ZTCURR11-TFACT,   "#### ####

        CRNAME TYPE CRNAM,            "###

        CRDATE TYPE CRDAT,            "###

      END OF GS_TCURR.



DATA: GT_TCURR LIKE TABLE OF GS_TCURR.






* ## ## ## (ALSM_EXCEL_TO_INTERNAL_TABLE ## ##)




DATA: T_RAW_EXCEL TYPE TABLE OF ALSMEX_TABLINE,

      S_RAW_EXCEL TYPE ALSMEX_TABLINE.






* ## ## ###




DATA: G_FUNCTION_KEY TYPE SMP_DYNTXT.

SELECTION-SCREEN: FUNCTION KEY 1.






* DOCKING ####/ALV GRID




DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER,

      GC_GRID    TYPE REF TO CL_GUI_ALV_GRID.






* VARIANT / FIELDCAT / LAYOUT / SORT




DATA: GS_VARIANT  TYPE DISVARIANT,

      GS_FIELDCAT TYPE LVC_S_FCAT,

      GT_FIELDCAT TYPE LVC_T_FCAT,

      GS_LAYOUT   TYPE LVC_S_LAYO,

      GS_SORT     TYPE LVC_S_SORT,

      GT_SORT     TYPE LVC_T_SORT.






* ## ## ##(###)




DATA: GS_KEY      TYPE WWWDATATAB,

      GV_FILE     TYPE STRING,

      GV_PATH     TYPE STRING,

      GV_FULLPATH TYPE STRING,

      GV_DEST     TYPE RLGRAP-FILENAME VALUE 'C:\'.






* ALV ###




DATA: GO_EVENT TYPE REF TO EVENT.






* OK-CODE




DATA: OK_CODE TYPE SY-UCOMM.