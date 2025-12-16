
*&---------------------------------------------------------------------*

*&  Include           ZEDR06_035_EVENT_HOTSPOT_F01

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

  SELECT * FROM ZEDT06_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

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

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.

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

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*  EXPORTING

*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =

*    IS_VARIANT                    =

*    I_SAVE                        =

*    I_DEFAULT                     = 'X'

*    IS_LAYOUT                     =

*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_STUDENT

    IT_FIELDCATALOG               = GT_FIELDCAT.




*    IT_SORT                       =

*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-HOTSPOT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZTEL'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = '13'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

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




FORM ALV_HANDLE_HOTSPOT_CLICK  USING    P_E_ROW_ID TYPE LVC_S_ROW

                                        P_E_COLUMN_ID TYPE LVC_S_COL

                                        P_ES_ROW_NO TYPE LVC_S_ROID.





  CASE P_E_COLUMN_ID.

    WHEN 'ZCODE'.

      READ TABLE GT_STUDENT INTO GS_STUDENT INDEX P_ES_ROW_NO-ROW_ID.

      SET PARAMETER ID 'XUS' FIELD GS_STUDENT-ZCODE.

      CALL TRANSACTION 'SU01'.

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



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLE_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_USER_COMMAND FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_HOTSPOT_CLICK FOR GC_GRID.



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



  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED_FINISHED FOR GC_GRID.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH.

  DATA : LS_STABLE TYPE LVC_S_STBL.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONE4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONE4_AFTER

                                        P_UCOMM.

    DATA : LS_MODI TYPE LVC_S_MODI.

    DATA : LV_LEN(02).



    CLEAR : LS_MODI, LV_LEN.



    LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

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

*      -->P_ET_GOOD_CELL  text

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

      CLEAR : GS_STUDENT.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.



ENDFORM.