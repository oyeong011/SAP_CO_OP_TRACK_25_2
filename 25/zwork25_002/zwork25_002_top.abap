
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_002_TOP

*&---------------------------------------------------------------------*




TABLES: ZTCURR25.



DATA: OK_CODE      TYPE SY-UCOMM,

      SAVE_OK      TYPE SY-UCOMM,

      GV_DATE_SEARCH TYPE CHAR8.



INCLUDE OLE2INCL.



TYPES: BEGIN OF TY_DATA,

         MANDT      TYPE ZTCURR25-MANDT,

         KURST      TYPE ZTCURR25-KURST,

         FCURR      TYPE ZTCURR25-FCURR,

         TCURR      TYPE ZTCURR25-TCURR,

         GDATU      TYPE ZTCURR25-GDATU,

         UKURS      TYPE ZTCURR25-UKURS,

         FFACT      TYPE ZTCURR25-FFACT,

         TFACT      TYPE ZTCURR25-TFACT,

         ERNAM      TYPE ZTCURR25-ERNAM,   " ###

         ERDAT      TYPE ZTCURR25-ERDAT,   " ###

         VALID_FROM TYPE DATS,             " ### #####

       END OF TY_DATA.



DATA: GT_DATA TYPE TABLE OF TY_DATA,

      GS_DATA TYPE TY_DATA.



DATA: GO_EXCEL    TYPE OLE2_OBJECT,

      GO_WORKBOOK TYPE OLE2_OBJECT,

      GO_SHEET    TYPE OLE2_OBJECT,

      GO_CELL     TYPE OLE2_OBJECT,

      GO_RANGE    TYPE OLE2_OBJECT,

      GO_BORDER   TYPE OLE2_OBJECT.



DATA: GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_GRID      TYPE REF TO CL_GUI_ALV_GRID.



DATA: GS_LAYOUT TYPE LVC_S_LAYO,

      GT_FCAT   TYPE LVC_T_FCAT,

      GS_FCAT   TYPE LVC_S_FCAT.



DATA: GV_ALV_CREATED TYPE C.