
*&---------------------------------------------------------------------*

*&  Include           ZEDR21_022_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .




*  s_zcode-low = 'SSU-01'.

*  s_zcode-high = 'SSU-99'.




ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .



  SELECT * FROM zedt21_001

    INTO CORRESPONDING FIELDS OF TABLE gt_student.




*    WHERE zcode IN s_zcode.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = sy-repid

    DYNNR                       = sy-dynnr




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .



CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = gc_docking




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT .

  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ICON'.

  gs_fieldcat-coltext = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZCODE21'.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-hotspot = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZPERNR21'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZKNAME21'.

  gs_fieldcat-coltext = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZENAME21'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZGENDER21'.

  gs_fieldcat-coltext = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZTEL21'.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-outputlen = '20'.

  gs_fieldcat-edit = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : gs_layout.



  gs_layout-zebra = 'X'.



  CLEAR : gs_variant.



  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*    EXPORTING

*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*       I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'

*      IS_LAYOUT                     =

*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = gt_student

      IT_FIELDCATALOG               = gt_fieldcat




*      IT_SORT                       =

*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODITY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODITY_DATA .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .

  DATA : ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = ls_stable




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_OBJECT TYPE REF TO cl_alv_event_toolbar_set

                                   P_INTERACTIVE.



  DATA : ls_toolbar TYPE stb_button.



  ls_toolbar-function = 'TEXT'.

  ls_toolbar-icon = icon_checked.

  ls_toolbar-quickinfo = 'INFOMATION'.



  APPEND ls_toolbar to p_object->mt_toolbar.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_USER_COMMAND  USING    P_UCOMM.

  CASE p_ucomm.

    WHEN 'TEXT'.

      MESSAGE '##########' TYPE 'I'.

  ENDCASE.

ENDFORM.










*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT go_event.



   CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

   EXPORTING

     I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*   EXCEPTIONS

*     ERROR      = 1

*     others     = 2




         .

 IF SY-SUBRC <> 0.




*  Implement suitable error handling here




 ENDIF.

  SET HANDLER go_event->handler_toolbar FOR gc_grid.

  SET HANDLER go_event->handler_user_command FOR gc_grid.

  SET HANDLER go_event->handle_hotspot_click FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_DOUBLE_CLICK FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_HOTSPOT_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->P_E_ROW_ID  text

*  -->P_E_COLUMN_ID text

*  -->P_ES_ROW_NO text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_HOTSPOT_CLICK USING P_ROW_ID TYPE LVC_S_ROW

                                    P_COLUMN_ID TYPE LVC_S_COL

                                    P_ROW_NO TYPE LVC_S_ROID.





CASE P_COLUMN_ID-FIELDNAME.

  WHEN 'ZPERNR21'.

  READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ROW_NO-ROW_ID.

  SET PARAMETER ID 'XUS' FIELD GS_STUDENT-ZCODE21.

  CALL TRANSACTION 'SU01'.

  ENDCASE.

 ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->P_E_ROW  text

*  -->P_E_COLUMN text

*  -->P_ES_ROW_NO text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DOUBLE_CLICK USING P_ROW TYPE LVC_S_ROW

                                   P_COLUMN TYPE LVC_S_COL

                                   P_ROW_NO TYPE LVC_S_ROID.

 DATA : LV_CHAR(2).

 DATA : LV_MESSAGE(20).



 CASE P_COLUMN-FIELDNAME.

   WHEN 'ZCODE21'.

     CLEAR GS_STUDENT.

     LV_CHAR = P_ROW_NO-ROW_ID.

     READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ROW_NO-ROW_ID.

     IF SY-SUBRC = 0.

       LV_CHAR = P_ROW_NO-ROW_ID.

       CONCATENATE LV_CHAR '########' INTO LV_MESSAGE.

       MESSAGE LV_MESSAGE TYPE 'I'.

       ENDIF.

       ENDCASE.





 ENDFORM.



FORM ALV_HANDLER_DATA_CHANGED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                    P_ONF4

                                    P_ONF4_BEFORE

                                    P_ONF4_AFTER

                                    P_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN(02).

  CLEAR : LS_MODI , LV_LEN.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL21'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_MODI-ROW_ID.



    IF LS_MODI-VALUE IS INITIAL.

      GS_STUDENT-ICON = ICON_LED_RED.

    ELSE.

      LV_LEN = STRLEN( LS_MODI-VALUE ).

      IF LV_LEN = '11'.

        GS_STUDENT-ICON = ICON_LED_GREEN.

      ELSE.

        GS_STUDENT-ICON = ICON_LED_YELLOW.

     ENDIF.

     ENDIF.



     MODIFY GT_STUDENT FROM GS_STUDENT INDEX LS_MODI-ROW_ID.

     CLEAR GS_STUDENT.

     ENDIF.

     ENDLOOP.



     PERFORM REFRESH.



     ENDFORM.