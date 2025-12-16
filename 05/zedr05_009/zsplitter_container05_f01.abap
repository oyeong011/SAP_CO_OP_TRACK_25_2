
*&---------------------------------------------------------------------*

*&  Include           ZSPLITTER_CONTAINER05_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA.

  SELECT * FROM ZEDT05_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT.

  " 1. DOCKING CONTAINER ##

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID      = SY-REPID

      DYNNR      = SY-DYNNR

      EXTENSION  = 2000.



  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  " 2. SPLITTER CONTAINER ##

  CREATE OBJECT GC_SPLITTER

    EXPORTING

      PARENT  = GC_DOCKING

      ROWS    = 2

      COLUMNS = 1.



  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  " 3. CONTAINER1 #### (##)

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  " 4. CONTAINER2 #### (##)

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  " 5. GRID1 ##

  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT = GC_CONTAINER1.



  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  " 6. GRID2 ##

  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT = GC_CONTAINER2.



  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG.

  PERFORM CONTAINER1_FIELD.

  PERFORM CONTAINER2_FIELD.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'. " ## ### ## ###



  " variant# #### ## ##

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT.

  PERFORM CONTAINER1_SORT.

  PERFORM CONTAINER2_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY.

  " GRID1 ##

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_STUDENT

      IT_FIELDCATALOG = GT_FIELDCAT1

      IT_SORT         = GT_SORT1.



  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.



  " GRID2 ##

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_STUDENT

      IT_FIELDCATALOG = GT_FIELDCAT2

      IT_SORT         = GT_SORT2.



  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FIELD (## ####)

*&---------------------------------------------------------------------*




FORM CONTAINER1_FIELD.

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-HOTSPOT = 'X'.

  GS_FIELDCAT-JUST = 'L'. " ## ## (L#, R#, C##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-HOTSPOT = 'X'.



  GS_FIELDCAT-JUST = 'L'. " ## ## (L#, R#, C##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'C'. " ## ## (L#, R#, C##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZTEL'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-INTTYPE   = 'C'.

  GS_FIELDCAT-OUTPUTLEN = 16.       " 2. ## ### 16## ##

  GS_FIELDCAT-DD_OUTLEN = 16.       " 3. Dictionary ## ### 16## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD (## ####)

*&---------------------------------------------------------------------*




FORM CONTAINER2_FIELD.

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'L'. " ## ## (L#, R#, C##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'C'. " ## ## (L#, R#, C##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER1_SORT.

  GS_SORT-SPOS = 1. " ## ####

  GS_SORT-FIELDNAME = 'ZCODE'. " ### ### ### ##

  GS_SORT-UP = 'X'. " #### #### ##

  GS_SORT-SUBTOT = 'X'. " ####

  APPEND GS_SORT TO GT_SORT1.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER2_SORT.

  GS_SORT-SPOS = 1. " ## ####

  GS_SORT-FIELDNAME = 'ZCODE'. " ### ### ### ##

  GS_SORT-UP = 'X'. " #### #### ##

  GS_SORT-SUBTOT = 'X'. " ####

  APPEND GS_SORT TO GT_SORT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.





IF GC_GRID1 IS BOUND.

    CALL METHOD GC_GRID1->REFRESH_TABLE_DISPLAY

      EXPORTING

        IS_STABLE = LS_STABLE.

  ENDIF.





  IF GC_GRID2 IS BOUND.

    CALL METHOD GC_GRID2->REFRESH_TABLE_DISPLAY

      EXPORTING

        IS_STABLE = LS_STABLE.

  ENDIF.



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




form ALV_HANDLER_TOOLBAR  using    P_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET

                                   P_INTERACTIVE.





  DATA : LS_TOOLBAR TYPE STB_BUTTON.

  LS_TOOLBAR-FUNCTION = 'TEXT'.

  LS_TOOLBAR-ICON = ICON_CHECKED.

  LS_TOOLBAR-QUICKINFO = 'INFORMATION'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.

endform.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CLASS_EVENT .

  CREATE OBJECT GO_EVENT.





  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID1.

  SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID1.



  call method GC_GRID1->REGISTER_EDIT_EVENT

    exporting

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  SET HANDLER GO_EVENT->HANDLE_HOTSPOT_CLICK FOR GC_GRID1.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID1.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID1.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




form ALV_HANDLER_USER_COMMAND  using    P_UCOMM.

  CASE P_UCOMM.

    WHEN 'TEXT'.

      MESSAGE '##########' TYPE 'I'.

    ENDCASE.

endform.




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




form ALV_HANDLER_DATA_CHANGED  using    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN TYPE I.



  CLEAR : LS_MODI, LV_LEN.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_MODI-ROW_ID.



      IF LS_MODI-VALUE IS INITIAL.

        GS_STUDENT-ZCOLOR = ICON_LED_RED.

      ELSE.

        LV_LEN = STRLEN( LS_MODI-VALUE ).

        IF LV_LEN = 13.

          GS_STUDENT-ZCOLOR = ICON_LED_GREEN.

        ELSE.

          GS_STUDENT-ZCOLOR = ICON_LED_YELLOW.

        ENDIF.

      ENDIF.

      MODIFY GT_STUDENT FROM GS_STUDENT INDEX LS_MODI-ROW_ID.

      CLEAR : GS_STUDENT.

    ENDIF.

  ENDLOOP.










*  PERFORM REFRESH.




endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_HOTSPOT_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW_ID  text

*      -->P_E_COLUMN_ID  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




form ALV_HANDLE_HOTSPOT_CLICK  using    P_ROW_ID TYPE LVC_S_ROW

                                        P_COLUMN_ID TYPE LVC_S_COL

                                        P_ROW_NO TYPE LVC_S_ROID.

  CASE P_COLUMN_ID-FIELDNAME.

    WHEN 'ZCODE'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ROW_NO-ROW_ID.

      SET PARAMETER ID 'XUS' FIELD GS_STUDENT-ZCODE.

      CALL TRANSACTION 'SU01'.

  ENDCASE.



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




form ALV_DATA_CHANGED_FINISHED  using    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : LS_MODI.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZTEL'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX LS_MODI-ROW_ID.



      IF GS_STUDENT-ZCOLOR NE ICON_LED_GREEN.

        DELETE TABLE GT_STUDENT FROM GS_STUDENT.

      ENDIF.



      CLEAR GS_STUDENT.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.

endform.