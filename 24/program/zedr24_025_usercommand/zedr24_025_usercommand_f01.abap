
*&---------------------------------------------------------------------*

*&  Include           ZEDR24_025_USERCOMMAND_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT24_002

    INTO CORRESPONDING FIELDS OF TABLE GT_002.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CRATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CRATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID = SY-REPID

      DYNNR = SY-DYNNR

      EXTENSION = 2000

      NAME = '# # # #'.

  .



  IF SY-SUBRC <> 0.

  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_DOCKING

  .



  IF SY-SUBRC <> 0.

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

  CLEAR : GS_FC, GT_FC.



  GS_FC-COL_POS = 1.

  GS_FC-FIELDNAME = 'ICON'.

  GS_FC-COLTEXT = '###'.

  GS_FC-ICON = 'X'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 2.

  GS_FC-FIELDNAME = 'ZCODE'.

  GS_FC-COLTEXT = '####'.

  GS_FC-HOTSPOT = 'X'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 3.

  GS_FC-FIELDNAME = 'ZMNAME'.

  GS_FC-COLTEXT = '###'.

  GS_FC-EDIT = 'X'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 4.

  GS_FC-FIELDNAME = 'ZPERNR'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.

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

    CHANGING

      IT_OUTTAB = GT_002

      IT_FIELDCATALOG = GT_FC

  .



  IF SY-SUBRC <> 0.

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

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

  EXPORTING

    IS_STABLE      = LS_STABLE




*    I_SOFT_REFRESH =

*  EXCEPTIONS

*    FINISHED       = 1

*    others         = 2




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.




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

"TOOLBAR ##

"E_OBJECT TYPE CL_ALV_EVENT_TOOLBAR_SET

"CL_ALV_EVENT_TOOLBAR_SET -> MT_TOOLBAR ##

"MT_TOOLBAR->TTB_BUTTON

"TTB_BUTTON->STB_BUTTON #### TOOLBAR ## ##



  DATA : LS_TOOLBAR TYPE STB_BUTTON.



  LS_TOOLBAR-FUNCTION = 'TEXT'.

  LS_TOOLBAR-ICON = ICON_CHECKED.

  LS_TOOLBAR-QUICKINFO = 'INFORMATION'.



  APPEND LS_TOOLBAR TO P_OBJECT->MT_TOOLBAR.

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



  "REGISTER EDIT : SCREEN# ITAB ###

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

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




FORM ALV_HANDLER_USER_COMMAND  USING    P_UCOMM.

  CASE P_UCOMM.

    WHEN 'TEXT'.

      MESSAGE '##########' TYPE 'I'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_HOTSPOT_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW_ID  text

*      -->P_E_COLUMN_ID  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_HOTSPOT_CLICK  USING    P_ROW_ID TYPE LVC_S_ROW

                                        P_COLUMN_ID TYPE LVC_S_COL

                                        P_ROW_NO TYPE LVC_S_ROID.

  CASE P_COLUMN_ID-FIELDNAME. "COLUMN ##

    WHEN 'ZCODE'.

      READ TABLE GT_002 INTO GS_002 INDEX P_ROW_NO-ROW_ID. "ROW ##

      SET PARAMETER ID 'XUS' FIELD GS_002-ZCODE. "F1# ## ## ### #### # ##

      CALL TRANSACTION 'SU01'. "### #### ## ##### # ## ##

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW  text

*      -->P_E_COLUMN  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DOUBLE_CLICK  USING    P_ROW TYPE LVC_S_ROW

                                       P_COLUMN TYPE LVC_S_COL

                                       P_ROW_NO TYPE LVC_S_ROID.

  DATA : LV_CHAR(2).

  DATA : LV_MESSAGE(20).



  CASE P_COLUMN-FIELDNAME.

    WHEN 'ZPERNR'.

      CLEAR GS_002.

      LV_CHAR = P_ROW_NO-ROW_ID.

      READ TABLE GT_002 INTO GS_002 INDEX P_ROW_NO-ROW_ID.

      IF SY-SUBRC = 0.

        LV_CHAR = P_ROW_NO-ROW_ID.

        CONCATENATE LV_CHAR '## ######' INTO LV_MESSAGE.

        MESSAGE LV_MESSAGE TYPE 'I'.

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




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN(02).



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZMNAME'.

      READ TABLE GT_002 INTO GS_002 INDEX LS_MODI-ROW_ID.



      IF LS_MODI-VALUE IS INITIAL.

        GS_002-ICON = ICON_LED_RED.

      ELSE.

        GS_002-ICON = ICON_LED_GREEN.

      ENDIF.



      MODIFY GT_002 FROM GS_002 INDEX LS_MODI-ROW_ID.

      CLEAR GS_002.

    ENDIF.

  ENDLOOP.




*

*  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

*    IF LS_MODI-FIELDNAME = 'ZMNAME'.

*      READ TABLE GT_002 INTO GS_002 INDEX LS_MODI-ROW_ID.

*

*      IF LS_MODI-VALUE IS INITIAL.

*        GS_002-ICON = ICON_LED_RED.

*      ELSE.

*        LV_LEN = STRLEN( LS_MODI-VALUE ).

*        IF LV_LEN = '11'.

*          GS_002-ICON = ICON_LED_GREEN.

*        ELSE.

*          GS_002-ICON = ICON_LED_YELLOW.

*        ENDIF.

*

*        MODIFY GT_002 FROM GS_002 INDEX LS_MODI-ROW_ID.

*        CLEAR GS_002.

*      ENDIF.

*    ENDIF.

*  ENDLOOP.




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

    IF LS_MODI-FIELDNAME = 'ZMNAME'.

      READ TABLE GT_002 INTO GS_002 INDEX LS_MODI-ROW_ID.



      IF GS_002-ICON NE ICON_LED_GREEN.

        DELETE TABLE GT_002 FROM GS_002.

      ENDIF.



      CLEAR GS_002.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.

ENDFORM.