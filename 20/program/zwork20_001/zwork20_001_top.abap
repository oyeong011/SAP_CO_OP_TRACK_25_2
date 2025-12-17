
*&---------------------------------------------------------------------*

*&  Include           ZWORK20_001_TOP

*&---------------------------------------------------------------------*




TABLES: SSCRFIELDS.



DATA: GV_ANSWER TYPE C.   " ### ## ## ##



DATA: GS_EXCEL TYPE SMP_DYNTXT.   " ### #### ### ## ##



DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.    " ALV### DOCKING CONTAINER #### ##

DATA: GC_GRID TYPE REF TO CL_GUI_ALV_GRID.    " ALV ### ALV GRID #### ##



DATA: OK_CODE TYPE SY-UCOMM.    " TOOLBAR ## ##



DATA: GS_FIELDCAT TYPE LVC_S_FCAT.    " ###### ###

DATA: GT_FIELDCAT TYPE LVC_T_FCAT.    " ###### ###



DATA: GT_SORT TYPE LVC_T_SORT.    " SORT ###

DATA: GS_SORT TYPE LVC_S_SORT.    " SORT ###



DATA: GS_LAYOUT TYPE LVC_S_LAYO.    " LAYOUT ###



DATA: GS_VARIANT TYPE DISVARIANT.   " LAYOUT #### ###



DATA: GC_FILE TYPE REF TO CL_GUI_FRONTEND_SERVICES.   " FRONTEND SERVICES ## ## ##



DATA: GO_EVENT TYPE REF TO EVENT.   " EVENT ## ## ##



DATA: BEGIN OF GS_EXCHANGE.   " ## ### ### ###

  include structure
ZTCURR20
.

  DATA: ZUKURS TYPE DECFLOAT16.   " ## ### ##

  DATA: END OF GS_EXCHANGE.

DATA: GT_EXCHANGE LIKE TABLE OF GS_EXCHANGE.



DATA: BEGIN OF GS_ZTCURR20.   " ZTCURR20 ### ### ###

  include structure
ZTCURR20
.

  DATA: END OF GS_ZTCURR20.

DATA: GT_ZTCURR20 LIKE TABLE OF GS_ZTCURR20.    " ZTCURR20 ### ### ###



DATA: BEGIN OF GS_TEMPLATE,   " ### ### ###

    KURST(20)  VALUE '####',

    FCURR(20)  VALUE '####',

    TCURR(30)  VALUE '####',

    GDATU(30)  VALUE '####',

    UKURS(30)  VALUE '##',

    FFACT(30)  VALUE '########',

    TFACT(30)  VALUE '########',

    END OF GS_TEMPLATE.

DATA: GT_TEMPLATE LIKE TABLE OF GS_TEMPLATE.    " ### ### ###



DATA: GT_EXCEL_RAW TYPE TABLE OF ALSMEX_TABLINE,  " ## ## #### ### ######

      GS_EXCEL_RAW       TYPE ALSMEX_TABLINE.           " ## ## #### ## ## #### ##