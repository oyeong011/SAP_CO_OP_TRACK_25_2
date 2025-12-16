
*&---------------------------------------------------------------------*

*&  Include           ZCLASS_EVENT10_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_INTERACTIVE.

  DATA: LS_TOOLBAR TYPE STB_BUTTON.



  LS_TOOLBAR-FUNCTION = 'TEXT'.

  LS_TOOLBAR-ICON = ICON_CHECKED.

  LS_TOOLBAR-QUICKINFO = 'INFOMATION'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USERCOMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_USERCOMMAND  USING    P_UCOMM.

  CASE P_UCOMM.

    WHEN 'TEXT'.

      MESSAGE '#######' TYPE 'I'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_HOTSPOT_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW_ID  text

*      -->P_E_COLUMN_ID  text

*      -->P_ES_ROW_NO  text

*      -->P_ENDMETHOD  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_HOTSPOT_CLICK  USING    P_ROW_ID TYPE LVC_S_ROW

                                         P_COLUMN_ID TYPE LVC_S_COL

                                         P_ROW_NO TYPE LVC_S_ROID.

  CASE P_COLUMN_ID-FIELDNAME.

    WHEN 'ZCODE'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ROW_NO-ROW_ID.

      SET PARAMETER ID 'XUS' FIELD GS_STUDENT-ZCODE.

      CALL TRANSACTION 'SU01'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_AFTER

                                        P_ONF4_BEFORE

                                        P_UCOMM TYPE SY-UCOMM.

  DATA: LS_MODI TYPE LVC_S_MODI.

  DATA: LV_LEN(02).

  DATA: LV_ROW_ID TYPE INT4.

  DATA: LV_ICON LIKE ICON_LED_GREEN.



  CLEAR: LS_MODI, LV_LEN.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL'.

      CLEAR GS_STUDENT.

      LV_ROW_ID = LS_MODI-ROW_ID.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LV_ROW_ID.






*      IF LS_MODI-VALUE IS INITIAL.

*        GS_STUDENT-ICON = ICON_LED_RED.

*      ELSE.

*        LV_LEN = STRLEN( LS_MODI-VALUE ).

*        IF LV_LEN = '11'.

*          GS_STUDENT-ICON = ICON_LED_GREEN.

*        ELSE.

*          GS_STUDENT-ICON = ICON_LED_YELLOW.

*        ENDIF.

*      ENDIF.






      IF LS_MODI-VALUE IS INITIAL.

        LV_ICON = ICON_LED_RED.

      ELSE.

        LV_LEN = STRLEN( LS_MODI-VALUE ).

        IF LV_LEN = '11'.

          LV_ICON = ICON_LED_GREEN.

        ELSE.

          LV_ICON = ICON_LED_YELLOW.

        ENDIF.

      ENDIF.

      CALL METHOD P_DATA_CHANGED->MODIFY_CELL

        EXPORTING

          I_ROW_ID    = LV_ROW_ID




*         I_TABIX     =




          I_FIELDNAME = 'ICON'

          I_VALUE     = LV_ICON.



      MODIFY GT_STUDENT FROM GS_STUDENT INDEX LS_MODI-ROW_ID.

      CLEAR GS_STUDENT.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_D_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*      -->P_SENDER  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_D_CHANGED_FINISHED  USING    P_MODIFIED

                                              PT_GOOD_CELLS TYPE LVC_T_MODI.



  " #### ### ##

  DATA: LS_MODI TYPE LVC_S_MODI.

  DATA: LS_ROW_ID TYPE INT4.



  CLEAR: LS_MODI, PT_GOOD_CELLS.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL'.

      CLEAR GS_STUDENT.

      LS_ROW_ID = LS_MODI-ROW_ID.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_ROW_ID.



      IF GS_STUDENT-ICON NE ICON_LED_GREEN.

        DELETE TABLE GT_STUDENT FROM GS_STUDENT.

      ENDIF.



      CLEAR GS_STUDENT.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INIT

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

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT10_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJ

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJ .

  CREATE OBJECT GC_DOCKING

    EXPORTING




*     PARENT    =




      REPID     = SY-REPID

      DYNNR     = SY-DYNNR




*     SIDE      = DOCK_AT_LEFT




      EXTENSION = 50000000




*     STYLE     =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO     =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME      =

*    EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_DOCKING




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FCAT .

  CLEAR: GS_FCAT, GT_FCAT.



  GS_FCAT-COL_POS = 010.

  GS_FCAT-FIELDNAME = 'ICON'.

  GS_FCAT-COLTEXT = '#'.

  GS_FCAT-ICON = 'X'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 100.

  GS_FCAT-FIELDNAME = 'ZCODE'.

  GS_FCAT-COLTEXT = '####'.

  GS_FCAT-HOTSPOT = 'X'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 101.

  GS_FCAT-FIELDNAME = 'ZPERNR'.

  GS_FCAT-COLTEXT = '####'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 102.

  GS_FCAT-FIELDNAME = 'ZKNAME'.

  GS_FCAT-COLTEXT = '##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 103.

  GS_FCAT-FIELDNAME = 'ZENAME'.

  GS_FCAT-COLTEXT = '####'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 104.

  GS_FCAT-FIELDNAME = 'ZGENDER'.

  GS_FCAT-COLTEXT = '##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 105.

  GS_FCAT-FIELDNAME = 'ZTEL'.

  GS_FCAT-COLTEXT = '####'.

  GS_FCAT-EDIT = 'X'.

  GS_FCAT-INTLEN = 16.

  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYO .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =

*     IS_VARIANT      =

*     I_SAVE          =

*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYO




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = GT_STUDENT

      IT_FIELDCATALOG = GT_FCAT

      IT_SORT         = GT_SORT




*     IT_FILTER       =

*  EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.



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

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE




*     I_SOFT_REFRESH =

*    EXCEPTIONS

*     FINISHED  = 1

*     OTHERS    = 2




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



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

  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_HOTSPOT_CLICK FOR GC_GRID.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*     ERROR      = 1

*     OTHERS     = 2




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.



ENDFORM.