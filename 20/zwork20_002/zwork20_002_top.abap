
*&---------------------------------------------------------------------*

*&  Include           ZWORK20_002_TOP

*&---------------------------------------------------------------------*




TABLES: SSCRFIELDS.

 TYPES: T_C(1500) TYPE C,   " ##### #### ## ####### #### #### ## ##

             T_DATA    TYPE TABLE OF T_C.



DATA: GT_CLIPBOARD TYPE T_DATA."TABLE OF STRING.



DATA: GS_EXCEL TYPE SMP_DYNTXT.   " EXCEL# #### ### ### ## ##

DATA: GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.    " ALV### CUSTOM CONTAINER #### ##

DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID.    " ALV ### ALV GRID #### ##

DATA: OK_CODE TYPE SY-UCOMM.    " TOOLBAR ## ##



DATA: GS_FIELDCAT TYPE LVC_S_FCAT.    " ###### ###

DATA: GT_FIELDCAT TYPE LVC_T_FCAT.    " ###### ###



DATA: GT_SORT TYPE LVC_T_SORT.    " SORT ###

DATA: GS_SORT TYPE LVC_S_SORT.    " SORT ###



DATA: GS_LAYOUT TYPE LVC_S_LAYO.    " LAYOUT ###



DATA: GS_VARIANT TYPE DISVARIANT.   " LAYOUT #### ###



DATA: GC_FILE TYPE REF TO CL_GUI_FRONTEND_SERVICES.   " FRONTEND SERVICES ## ## ##



DATA: GV_TEMP_DT TYPE STRING,   " TEMP## ### ## ##

      GV_FILE_DT TYPE STRING.   " PDF## ### ## ##



DATA: GV_EXCEL_APP TYPE OLE2_OBJECT,    " ### #### ## ##

      GV_EXCEL_WORKBOOK TYPE OLE2_OBJECT.   " ###### #### ## ##

DATA: GV_FILE TYPE RLGRAP-FILENAME.   " RLGRAP-FILENAME ### ## #### ### ## ##



DATA: GO_EVENT TYPE REF TO EVENT.   " EVENT ## ## ##



DATA: BEGIN OF GS_EXCHANGE.   " ## ### ### ###

  DATA: KURST TYPE ZTCURR20-KURST,    " ####

        FCURR TYPE ZTCURR20-FCURR,    " ####

        TCURR TYPE ZTCURR20-TCURR,    " ####

        GDATU TYPE ZTCURR20-GDATU,    " ####

        ZUKURS TYPE DECFLOAT16,   " ## ### ##

        FFACT TYPE ZTCURR20-FFACT,    " ########

        TFACT TYPE ZTCURR20-TFACT,    " ########

        ZUNAME TYPE SY-UNAME,   " ### ### ##

        ZDATE TYPE SY-DATUM.    " ### ### ##

  DATA: END OF GS_EXCHANGE.

DATA: GT_EXCHANGE LIKE TABLE OF GS_EXCHANGE.



DATA: BEGIN OF GS_ZTCURR20.   " ZTCURR20 ### ### ###

  include structure
ZTCURR20
.

  DATA: END OF GS_ZTCURR20.

DATA: GT_ZTCURR20 LIKE TABLE OF GS_ZTCURR20.    " ZTCURR20 ### ### ###