
*&---------------------------------------------------------------------*

*&  Include           ZWORK05_002_TOP

*&---------------------------------------------------------------------*




TABLES : ZTCURR05.



DATA: BEGIN OF GS_200.

  include structure
ZTCURR05
.

DATA : END OF GS_200.





DATA: GT_200 LIKE TABLE OF GS_200,

      OK_CODE TYPE SY-UCOMM.



DATA :GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GO_ALV_GRID      TYPE REF TO CL_GUI_ALV_GRID,

      GS_LAYOUT        TYPE LVC_S_LAYO,

      GT_FIELDCAT      TYPE LVC_T_FCAT,

      GS_FIELDCAT      TYPE LVC_S_FCAT.



DATA: GV_PDF_PATH      TYPE STRING,

      GV_TEMPLATE_PATH TYPE STRING.



" PDF/Excel ## ## ###

DATA: GV_DIRECTORY     TYPE STRING,

      GV_FILENAME      TYPE STRING,

      GV_FULLPATH      TYPE STRING,

      GV_TEMPLATE_NAME TYPE STRING VALUE 'EXCHANGE_RATE_TEMPLATE.XLS'.



" OLE2 ###

DATA: GO_EXCEL         TYPE OLE2_OBJECT,

      GO_WORKBOOK      TYPE OLE2_OBJECT,

      GO_WORKSHEET     TYPE OLE2_OBJECT,

      GO_CELLS         TYPE OLE2_OBJECT.



" WWWDATA ##

DATA: GT_WWWDATA       TYPE TABLE OF W3MIME,

      GS_WWWDATA       TYPE W3MIME.





" ## ### ### ##

DATA: go_event_handler TYPE REF TO lcl_event_handler.