
*&---------------------------------------------------------------------*

*&  Include           ZWORK05_001_TOP

*&---------------------------------------------------------------------*

*&  ## ### ##

*&---------------------------------------------------------------------*






" Selection Screen ## ##

TABLES: SSCRFIELDS.



" ## ### ## ##

DATA: BEGIN OF GS_TEMPLATE,

        KURST(20)  VALUE '####',

        FCURR(20)  VALUE '####',

        TCURR(20)  VALUE '####',

        GDATU(20)  VALUE '####',

        UKURS(20)  VALUE '##',

        FFACT(30)  VALUE '########',

        TFACT(30)  VALUE '########',

      END OF GS_TEMPLATE.

" ### ### ### ###

DATA: GT_TEMPLATE LIKE TABLE OF GS_TEMPLATE.



" ## ### Raw ###

DATA: GT_EXCEL_RAW TYPE TABLE OF ALSMEX_TABLINE,

      GS_EXCEL_RAW TYPE ALSMEX_TABLINE.



" ## ## ### # ### ##

DATA: GS_EXCEL TYPE SMP_DYNTXT.



" ALV #### # ### ##

DATA: GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA: GC_GRID    TYPE REF TO CL_GUI_ALV_GRID.



" ### ### #

DATA: OK_CODE TYPE SY-UCOMM.



" ALV ###### # #### ##

DATA: GS_FIELDCAT TYPE LVC_S_FCAT.

DATA: GT_FIELDCAT TYPE LVC_T_FCAT.

DATA: GT_SORT     TYPE LVC_T_SORT.

DATA: GS_SORT     TYPE LVC_S_SORT.

DATA: GS_LAYOUT   TYPE LVC_S_LAYO.

DATA: GS_VARIANT  TYPE DISVARIANT.



" ##### ## ## ##

DATA: GC_FILE TYPE REF TO CL_GUI_FRONTEND_SERVICES.



" ## ## ## ###

DATA: BEGIN OF GS_EXCHANGE.

  include structure
ZTCURR05
.         " DB ### ## ##

  DATA: ZUKURS TYPE DECFLOAT16,  " ## ### ##

        ZUNAME TYPE SY-UNAME,    " ###

        ZDATE  TYPE SY-DATUM.    " ###

DATA: END OF GS_EXCHANGE.



" ## ## ## ###

DATA: GT_EXCHANGE LIKE TABLE OF GS_EXCHANGE.





" ALV ## ## ##

DATA: GT_TOOLBAR TYPE TTB_BUTTON,

      GS_TOOLBAR TYPE STB_BUTTON.



" ## ### ### ### ##

DATA: GO_EVENT_HANDLER TYPE REF TO LCL_EVENT_HANDLER.