
*&---------------------------------------------------------------------*

*&  Include           ZEDR25_024_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  SELECT * FROM ZEDT25_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.



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

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





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

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.









ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

   " 1) ICON

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-ICON      = ABAP_TRUE.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2) ZCODE

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-JUST      = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3) ZPERNR

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4) ZKNAME

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5) ZENAME

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6) ZGENDER

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7) ZTEL

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'ZTEL'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

   GS_FIELDCAT-EDIT      = ABAP_TRUE.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





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

   GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYOUT_SET .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



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

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'




*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = GT_STUDENT

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT         = GT_SORT




*     IT_FILTER       =

*    EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.









ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERAVTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_INTERACTIVE.



  DATA : LS_TOOLBAR TYPE STB_BUTTON.



  LS_TOOLBAR-FUNCTION = 'TEXT'.

  LS_TOOLBAR-ICON = ICON_CHECKED.

  LS_TOOLBAR-QUICKINFO = 'INFOMATION'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_EVENT .

  CREATE OBJECT GO_EVENT.



 SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DOUBLE_CLICK FOR GC_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_USER_COMMAND  USING    P_E_UCOMM.

  CASE P_E_UCOMM.

    WHEN 'TEXT'.

      MESSAGE '##########' TYPE 'I'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_HOTSPOT_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW  text

*      -->P_E_COLUMN  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*

*FORM ALV_HANDLER_HOTSPOT_CLICK  USING   P_E_ROW     TYPE LVC_S_ROW

*                                        P_E_COLUMN  TYPE LVC_S_COL

*                                        P_ES_ROW_NO TYPE LVC_S_ROID.

*

*  CASE P_E_COLUMN-FIELDNAME.

*    WHEN 'ZCODE'.

*      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ES_ROW_NO-ROW_ID.

*      SET PARAMETER ID 'XUS' FIELD GS_STUDENT-ZCODE.

*      CALL TRANSACTION 'SU01'.

*   ENDCASE.

*

*ENDFORM.

*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW  text

*      -->P_E_COLUMN  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DOUBLE_CLICK  USING    P_E_ROW     TYPE LVC_S_ROW

                                       P_E_COLUMN  TYPE LVC_S_COL

                                       P_ES_ROW_NO TYPE LVC_S_ROID.

  DATA: LV_CHAR(2).

  DATA: LV_MESSAGE(20).



  CASE P_E_COLUMN-FIELDNAME.

    WHEN 'ZCODE'.

      CLEAR GS_STUDENT.

      LV_CHAR = P_ES_ROW_NO-ROW_ID.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ES_ROW_NO-ROW_ID.

      IF SY-SUBRC = 0.

        LV_CHAR = P_ES_ROW_NO-ROW_ID.

        CONCATENATE LV_CHAR '########' INTO LV_MESSAGE.

        MESSAGE LV_MESSAGE TYPE 'I'.

      ENDIF.

  ENDCASE.

ENDFORM.



FORM CLASS_EVENT.

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.





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




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN(02).



  CLEAR : LS_MODI, LV_LEN.



  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL'.

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




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.



  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_MODI-ROW_ID.



      IF GS_STUDENT-ICON NE ICON_LED_GREEN.

        DELETE TABLE GT_STUDENT FROM GS_STUDENT.

      ENDIF.



      CLEAR GS_STUDENT.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.



ENDFORM.