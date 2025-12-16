
FORM SELECT_DATA .

  SELECT *

  FROM ZEDT09_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE

  AND ZPERNR IN S_ZPERNR.

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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_STUDENT

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




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

  "####, ####, ##, ####

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'. "##TEXT

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-COLTEXT = '####'. "##TEXT

  GS_FIELDCAT-KEY = 'X'. "#### ##

  GS_FIELDCAT-HOTSPOT = 'X'.    "HOTSPOT ## #### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'. "##TEXT

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-COLTEXT = '##'. "##TEXT

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-COLTEXT = '####'. "##TEXT

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-COLTEXT = '##'. "##TEXT

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZTEL'.

  GS_FIELDCAT-COLTEXT = '####'. "##TEXT

  GS_FIELDCAT-OUTPUTLEN = '20'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

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

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

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

  GS_SORT-SPOS = 1. "## ##

  GS_SORT-FIELDNAME = 'ZCODE'. "### ### ###

  GS_SORT-UP = 'X'. "####

  APPEND GS_SORT TO GT_SORT.

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



  LS_STABLE-ROW = 'X'. "#### usercommand ## ### #, ## ## ##

  LS_STABLE-COL = 'X'.

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY "gc_grid #### # refresh #### ##### ### #### ##

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

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  CLEAR : S_ZCODE.



  S_ZCODE-SIGN = 'I'.

  S_ZCODE-OPTION = 'EQ'.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.



  APPEND S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_TOOLBAR  USING    P_E_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_E_INTERACTIVE.



  DATA : LS_TOOLBAR TYPE STB_BUTTON.



  LS_TOOLBAR-FUNCTION = 'TEXT'. "function code

  LS_TOOLBAR-ICON = ICON_CHECKED. "se16N## icon #### #### ##

  LS_TOOLBAR-QUICKINFO = 'INFOMATION'. "Quickinfo for an icon



  "P_E_OBJECT# cl_gui_alv_grid ### ## ### # ####

  "e_object ### cl_alv_event_toolbar_set #### ### mt_toolbar# #### ##, #### ###

  APPEND LS_TOOLBAR TO P_E_OBJECT->MT_TOOLBAR.



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

  CREATE OBJECT GO_EVENT. "### ## ###



  "### ### -> # ## ### ##(### ##, ##, #..)# #### ####,

  "data_changed #### ###### alv# ##

  "cl_gui_alv_grid ### ## register_edit_event #### ### mc_evt_modified ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED "#####=>####/#####, ##### =>




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

  "ALV ### ##(gc_grid)# TOOLBAR #### ### #,

  "# ### ##(go_event)# #### handler_toolbar# ###### ### - ###### ## ###

  "### ###



  SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID.



  SET HANDLER GO_EVENT->HANDLER_HOTSPOT_CLICK FOR GC_GRID.



  SET HANDLER GO_EVENT->HANDLER_DOUBLE_CLICK FOR GC_GRID.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

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

*      -->P_E_ROW_ID  text

*      -->P_E_COLUMN_ID  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_HOTSPOT_CLICK  USING    P_E_ROW_ID TYPE LVC_S_ROW

                                         P_E_COLUMN_ID TYPE LVC_S_COL

                                         P_ES_ROW_NO TYPE LVC_S_ROID.

  "alv #### ##(SSU-01 ## ##)# ####,

  "#### SU01(### ## ####) #### ## ##

  "alv # ## -> #### #### HOTSPOT ### ## -> ## ## ## (SU01)



  CASE P_E_COLUMN_ID-FIELDNAME. "### ## ##

    "##### #

    WHEN 'ZCODE'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ES_ROW_NO-ROW_ID. "ROW ## (### #?)



      "XUS == SU01 ##### User ### ### SAP ## #### ID

      "SET PARAMETER ID### SAP #### #### ID(parameter ID)# ## ###,

      "### #### ##### # ##### #### ### ## ####

      "##) SU01 #### -> User ## ## -> F1 ### -> technical information ## ## -> parameter-id ## !

      SET PARAMETER ID 'XUS' FIELD GS_STUDENT-ZCODE.

      CALL TRANSACTION 'SU01'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLC_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW  text

*      -->P_E_COLUMN  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DOUBLC_CLICK  USING    P_E_ROW TYPE LVC_S_ROW

                                        P_E_COLUMN TYPE LVC_S_COL "#(column) ## ##

                                        P_ES_ROW_NO TYPE LVC_S_ROID.  "#(row) ## ##

  "DOUBLC CLICK ## ##

  DATA : LV_INDEX TYPE C LENGTH 2,

         LV_MESSAGE TYPE C LENGTH 20.



 "## #### ## ### ## #####, # ## ####




*  CASE P_E_COLUMN-FIELDNAME.

*

*    WHEN 'ZCODE'. "## ##### ##




      CLEAR : GS_STUDENT.

      LV_INDEX = P_ES_ROW_NO-ROW_ID.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LV_INDEX.



      IF SY-SUBRC = 0.

        CONCATENATE LV_INDEX ' ## ######' INTO LV_MESSAGE.

        MESSAGE LV_MESSAGE TYPE 'I'.

      ENDIF.




*  ENDCASE.








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

  "CL_ALV_CHANGED_DATA_PROTOCOL #### ### MT_GOOD_CELLS# ### LVC_T_MODI -> LVC_S_MODI # ### #..

  "ROW_ID, FIELDNAME, VALUE ##! ##, ### ##, ## ##, # ###





  "# ##### ztel ###### ## ####, ### ## ##!

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN TYPE C LENGTH 2.

  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI. "####=>##/####/#####

                                                         "#####->######/#####



    break-point.

    READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_MODI-ROW_ID.



    IF LS_MODI-VALUE IS INITIAL. "#### ### red

      GS_STUDENT-ZCOLOR = ICON_LED_RED.

    ELSE.

       LV_LEN = STRLEN( LS_MODI-VALUE ).

       IF LV_LEN = '11'.

         GS_STUDENT-ZCOLOR = ICON_LED_GREEN. "11## ### green

       ELSE.

         GS_STUDENT-ZCOLOR = ICON_LED_YELLOW. "11## ### yellow

       ENDIF.

    ENDIF.

    MODIFY GT_STUDENT FROM GS_STUDENT INDEX LS_MODI-ROW_ID.

    CLEAR : GS_STUDENT.

  ENDLOOP.



  PERFORM REFRESH. "## #### ## !!

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS TYPE LVC_T_MODI.

  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT P_ET_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_MODI-ROW_ID.



      "### ### ## green# ### ## #### ##

      IF GS_STUDENT-ZCOLOR NE ICON_LED_GREEN.

        DELETE TABLE GT_STUDENT FROM GS_STUDENT.

      ENDIF.



      CLEAR : GS_STUDENT.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.

ENDFORM.