
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_022_F01

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



  SELECT * FROM zedt07_001

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

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-hotspot = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-coltext = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZGENDER'.

  gs_fieldcat-coltext = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZTEL'.

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

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT go_event.



  SET HANDLER go_event->handler_toolbar FOR gc_grid.

  SET HANDLER go_event->handler_user_command FOR gc_grid.

  SET HANDLER go_event->handler_hotspot_click FOR gc_grid.

  SET HANDLER go_event->handler_double_click FOR gc_grid.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = cl_gui_alv_grid=>mc_evt_modified




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .



  SET HANDLER go_event->handler_data_changed FOR gc_grid.

  SET HANDLER go_event->handler_data_changed_finished FOR gc_grid.



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

*&      Form  ALV_HANDLER_HOTSPOT_CLISK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW_ID  text

*      -->P_E_COLUMN_ID  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_HOTSPOT_CLISK  USING    P_E_ROW_ID TYPE lvc_s_row

                                         P_COLUMN_ID TYPE lvc_s_col

                                         P_ROW_NO TYPE lvc_s_roid.



  CASE p_column_id-fieldname.

    WHEN 'ZCODE'.

      READ TABLE gt_student INTO gs_student INDEX p_row_no-row_id.

      SET PARAMETER ID 'XUS' FIELD gs_student-zcode.

      CALL TRANSACTION 'SU01'.



  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW  text

*      -->P_E_COLUMN  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DOUBLE_CLICK  USING    P_ROW TYPE lvc_s_row

                                        P_COLUMN TYPE lvc_s_col

                                        P_ROW_NO TYPE lvc_s_roid.



  DATA : lv_char(2).

  DATA : lv_message(20).



  CASE p_column-fieldname.

    WHEN 'ZPERNR'.

      CLEAR gs_student.

      lv_char = p_row_no-row_id.

      READ TABLE gt_student INTO gs_student INDEX p_row_no-row_id.

      IF sy-subrc = 0.

        lv_char = p_row_no-row_id.

        CONCATENATE lv_char '########' INTO lv_message.

        MESSAGE lv_message TYPE 'I'.

      ENDIF.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO cl_alv_changed_data_protocol

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.



  DATA : ls_modi TYPE lvc_s_modi.

  DATA : lv_len(02).



  CLEAR : ls_modi, lv_len.



  LOOP AT p_data_changed->mt_good_cells INTO ls_modi.

    IF ls_modi-fieldname = 'ZTEL'.



      READ TABLE gt_student INTO gs_student INDEX ls_modi-row_id.



      IF  ls_modi-value IS INITIAL.

        gs_student-icon = icon_led_red.



      ELSE.

        lv_len = strlen( ls_modi-value ).

        IF  lv_len = '11'.

          gs_student-icon = icon_led_green.

        ELSE.

          gs_student-icon = icon_led_yellow.

        ENDIF.

      ENDIF.



      MODIFY gt_student FROM gs_student INDEX ls_modi-row_id.

      CLEAR gs_student.

    ENDIF.

  ENDLOOP.



  PERFORM refresh.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         P_GOOD_CELLS TYPE lvc_t_modi.



  DATA : ls_modi TYPE lvc_s_modi.



  CLEAR : ls_modi.



  LOOP AT p_good_cells INTO ls_modi.

    IF ls_modi-fieldname = 'ZTEL'.

      READ TABLE gt_student INTO gs_student INDEX ls_modi-row_id.



      IF  gs_student-icon NE icon_led_green.

        DELETE TABLE gt_student FROM gs_student.

      ENDIF.



      CLEAR gs_student.

    ENDIF.

  ENDLOOP.



  PERFORM refresh.

ENDFORM.