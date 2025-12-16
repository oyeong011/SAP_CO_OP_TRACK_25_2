
*&---------------------------------------------------------------------*

*&  Include           ZTEST01_003_CLS

*&---------------------------------------------------------------------*






CLASS LCL_EVENT_RECEIVER DEFINITION.



  PUBLIC SECTION.



    DATA : MV_OBJECT_TEXT TYPE CHAR30.



    METHODS :




*CONSTRUCTOR




      CONSTRUCTOR    IMPORTING  IV_OBJECT_TEXT TYPE C,






*TOP-OF-PAGE




      HANDLE_TOP_OF_PAGE

                    FOR EVENT TOP_OF_PAGE   OF CL_GUI_ALV_GRID

        IMPORTING E_DYNDOC_ID,






*DATA CHANGED




      HANDLE_DATA_CHANGED

                    FOR EVENT DATA_CHANGED  OF CL_GUI_ALV_GRID

        IMPORTING SENDER ER_DATA_CHANGED,






*Data change finishe




      HANDLE_DATA_CHANGED_FINISHED

                    FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID

        IMPORTING SENDER E_MODIFIED ET_GOOD_CELLS,






*Toolbar create




      HANDLE_TOOLBAR

                    FOR EVENT TOOLBAR       OF CL_GUI_ALV_GRID

        IMPORTING SENDER E_OBJECT E_INTERACTIVE,






*User command




      HANDLE_USER_COMMAND

                    FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID

        IMPORTING SENDER E_UCOMM,






*Hot spot




      HANDLE_HOTSPOT_CLICK

                    FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID

        IMPORTING SENDER E_ROW_ID E_COLUMN_ID,






*Double click

*HANDLE_DOUBLE_CLICK




      HANDLE_DOUBLE_CLICK

                    FOR EVENT DOUBLE_CLICK            OF CL_GUI_ALV_GRID

        IMPORTING SENDER

                    E_ROW

                    E_COLUMN

                    ES_ROW_NO,






*F4 search help




      HANDLE_ON_F4

                    FOR EVENT ONF4 OF CL_GUI_ALV_GRID

        IMPORTING SENDER

                    E_FIELDNAME

                    E_FIELDVALUE

                    ES_ROW_NO

                    ER_EVENT_DATA

                    ET_BAD_CELLS

                    E_DISPLAY.



ENDCLASS.                    "lcl_event_receiver DEFINITION




*----------------------------------------------------------------------*

*       CLASS lcl_event_receiver IMPLEMENTATION

*----------------------------------------------------------------------*




CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.




*CONSTRUCTOR




  METHOD  CONSTRUCTOR.

    CALL METHOD SUPER->CONSTRUCTOR.

    MV_OBJECT_TEXT = IV_OBJECT_TEXT.

  ENDMETHOD.                    "lcl_event_receiver






*TOP-OF-PAGE




  METHOD HANDLE_TOP_OF_PAGE.




*    PERFORM GRID110_TO_OF_PAGE.




  ENDMETHOD.                    "HANDLE_TOP_OF_PAGE






*DATA CHANGED




  METHOD HANDLE_DATA_CHANGED.

    PERFORM DATA_CHANGED USING SENDER ER_DATA_CHANGED.

  ENDMETHOD.                    "handle_data_changed






*Data changed finished




  METHOD HANDLE_DATA_CHANGED_FINISHED.

    PERFORM DATA_CHANGED_FINISHED USING SENDER E_MODIFIED ET_GOOD_CELLS.

  ENDMETHOD.                    "handle_data_changed_finished






*Toolbar create




  METHOD HANDLE_TOOLBAR.




*    PERFORM HANDLE_TOOLBAR_PART  USING SENDER E_OBJECT E_INTERACTIVE.




  ENDMETHOD.                     "HANDLE_TOOLBAR






*User command




  METHOD HANDLE_USER_COMMAND .




*    PERFORM HANDLE_USER_COMMAND  USING SENDER E_UCOMM .




  ENDMETHOD.                      "HANDLE_USER_COMMAND






*Hot spot




  METHOD HANDLE_HOTSPOT_CLICK.




*    PERFORM HOTSPOT_CLICK USING SENDER E_ROW_ID E_COLUMN_ID.




  ENDMETHOD.                    "HANDLE_HOTSPOT_CLICK



  METHOD HANDLE_DOUBLE_CLICK.

    PERFORM HANDLE_DOUBLE_CLICK  USING SENDER E_ROW E_COLUMN .

  ENDMETHOD.                                        "HANDLE_DOUBLE_CLICK



  METHOD HANDLE_ON_F4.




*    PERFORM ON_F4 USING SENDER

*                        E_FIELDNAME

*                        E_FIELDVALUE

*                        ES_ROW_NO

*                        ER_EVENT_DATA

*                        ET_BAD_CELLS

*                        E_DISPLAY.




  ENDMETHOD.

ENDCLASS.                    "lcl_event_receiver IMPLEMENTATION









CLASS LCL_ALV_GRID DEFINITION INHERITING FROM CL_GUI_ALV_GRID.

  PUBLIC SECTION.

    METHODS: SET_OPTIMIZE_ALL_COLS,

      SET_CURSOR

        IMPORTING

          ROW TYPE I

          COL TYPE I,

      SET_FIXED_COLUMN,

      SET_ROW_RESIZE.



ENDCLASS.                    "lcl_alv_grid DEFINITION



CLASS LCL_ALV_GRID IMPLEMENTATION.

  METHOD SET_OPTIMIZE_ALL_COLS.

    CALL METHOD ME->OPTIMIZE_ALL_COLS

      EXPORTING

        INCLUDE_HEADER = 1.

  ENDMETHOD.                 " set_optimize_all_cols



  METHOD SET_CURSOR.

    CALL METHOD ME->SET_CURRENT_CELL_BASE

      EXPORTING

        ROW = ROW

        COL = COL.

  ENDMETHOD.                    " SET_CURSOR



  METHOD SET_FIXED_COLUMN.

    CALL METHOD ME->SET_FIXED_COLS

      EXPORTING

        COLS = 3.

  ENDMETHOD.                    " SET_FIXED_COLUMN



  METHOD SET_ROW_RESIZE.

    CALL METHOD ME->SET_RESIZE_ROWS

      EXPORTING

        ENABLE = 1.

  ENDMETHOD.                    " SET_ROW_RESIZE



ENDCLASS.                    " lcl_alv_grid IMPLEMENTATION




*&---------------------------------------------------------------------*

*& Form HANDLE_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*& text

*&---------------------------------------------------------------------*

*&      --> SENDER

*&      --> E_ROW

*&      --> E_COLUMN

*&---------------------------------------------------------------------*




FORM HANDLE_DOUBLE_CLICK  USING   PO_SENDER

                                   PV_ROW      TYPE LVC_S_ROW

                                   PV_COLUMN   TYPE LVC_S_COL.



  CASE PO_SENDER.

    WHEN GO_100-O_GRID.

      PERFORM HANDLE_DOUBLECLICK_100 USING PV_ROW PV_COLUMN.



  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form HANDLE_DOUBLECLICK_100

*&---------------------------------------------------------------------*

*& text

*&---------------------------------------------------------------------*

*&      --> PV_ROW

*&      --> PV_COLUMN

*&---------------------------------------------------------------------*




FORM HANDLE_DOUBLECLICK_100  USING   PV_ROW      TYPE LVC_S_ROW

                                     PV_COLUMN   TYPE LVC_S_COL.





  DATA : LV_STRING TYPE STRING.

  READ TABLE GT_DISP_100 INDEX PV_ROW-INDEX.

  CHECK SY-SUBRC EQ 0.

  CASE PV_COLUMN.

    WHEN 'MATNR'. "####

      CHECK GT_DISP_100-MATNR IS NOT INITIAL AND

            GT_DISP_100-WERKS IS NOT INITIAL.

      SET PARAMETER ID 'MAT' FIELD GT_DISP_100-MATNR.

      SET PARAMETER ID 'WRK' FIELD GT_DISP_100-WERKS.

      SET PARAMETER ID 'MXX' FIELD 'E'."## View

      CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.



    WHEN 'MATNR2'. "####

      CHECK GT_DISP_100-MATNR2 IS NOT INITIAL AND

            GT_DISP_100-WERKS IS NOT INITIAL.

      SET PARAMETER ID 'MAT' FIELD GT_DISP_100-MATNR2.

      SET PARAMETER ID 'WRK' FIELD GT_DISP_100-WERKS.

      SET PARAMETER ID 'MXX' FIELD 'E'."## View

      CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.



    WHEN 'BANFN'. "####

      CHECK GT_DISP_100-BANFN IS NOT INITIAL.

      SET PARAMETER ID 'BAN' FIELD GT_DISP_100-BANFN.

      CALL TRANSACTION 'ME53N' AND SKIP FIRST SCREEN.



    WHEN 'EBELN'. "####

      CHECK GT_DISP_100-EBELN IS NOT INITIAL.

      SET PARAMETER ID 'BES' FIELD GT_DISP_100-EBELN.

      CALL TRANSACTION 'ME23N' AND SKIP FIRST SCREEN.



  ENDCASE.





ENDFORM.




*&---------------------------------------------------------------------*

*& Form DATA_CHANGED

*&---------------------------------------------------------------------*

*& text

*&---------------------------------------------------------------------*

*&      --> SENDER

*&      --> ER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM DATA_CHANGED  USING PO_SENDER

                           PO_DATA_CHANGED

                            TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.







  CASE PO_SENDER.

    WHEN GO_100-O_GRID.

      PERFORM HANDLE_CHANGED_100 USING PO_DATA_CHANGED.



  ENDCASE.





ENDFORM.




*&---------------------------------------------------------------------*

*& Form HANDLE_CHANGED_100

*&---------------------------------------------------------------------*

*& text

*&---------------------------------------------------------------------*

*&      --> PO_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM HANDLE_CHANGED_100  USING PO_DATA_CHANGED

                            TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.





  DATA : LS_MOD_CELLS TYPE LVC_S_MODI.

  DATA : LS_DEL_ROWS  TYPE LVC_S_MOCE.



  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : OREF TYPE REF TO CX_ROOT.

  DATA : LV_CHG.

  DATA : LV_MANDT LIKE SY-MANDT.



  LOOP AT PO_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELLS.



    GV_CHG = ABAP_TRUE.



    READ TABLE GT_DISP_100 INDEX LS_MOD_CELLS-ROW_ID.

    CHECK SY-SUBRC EQ 0.





    CASE LS_MOD_CELLS-FIELDNAME.

      WHEN 'ZGRMQTY' OR 'ZGRSQTY' OR 'ZGRVQTY' OR 'ZGRDIFFQTY'.




*        PERFORM SET_CHANGED_STATUS USING PO_DATA_CHANGED LS_MOD_CELLS.






        MODIFY GT_DISP_100 INDEX LS_MOD_CELLS-ROW_ID TRANSPORTING STATUS ICON.



    ENDCASE.





  ENDLOOP.



  IF NOT PO_DATA_CHANGED->MT_PROTOCOL[] IS INITIAL.

    PO_DATA_CHANGED->DISPLAY_PROTOCOL( ).

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*& Form DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*& text

*&---------------------------------------------------------------------*

*&      --> SENDER

*&      --> E_MODIFIED

*&      --> ET_GOOD_CELLS

*&---------------------------------------------------------------------*




FORM DATA_CHANGED_FINISHED  USING    PO_SENDER

                                     PV_MODIFIED   TYPE CHAR01

                                     PT_GOOD_CELLS TYPE LVC_T_MODI.





  CASE PO_SENDER.

    WHEN GO_100-O_GRID.



      PERFORM DATA_CHANGED_FINISHED_100 USING PV_MODIFIED PT_GOOD_CELLS.



  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*& Form DATA_CHANGED_FINISHED_100

*&---------------------------------------------------------------------*

*& text

*&---------------------------------------------------------------------*

*&      --> PV_MODIFIED

*&      --> PT_GOOD_CELLS

*&---------------------------------------------------------------------*




FORM DATA_CHANGED_FINISHED_100  USING PV_MODIFIED   TYPE CHAR01

                                      PT_GOOD_CELLS TYPE LVC_T_MODI.



  DATA : LS_GOOD_CELLS LIKE LINE OF  PT_GOOD_CELLS.





  LOOP AT PT_GOOD_CELLS INTO LS_GOOD_CELLS.



    CASE LS_GOOD_CELLS-FIELDNAME.

      WHEN 'ZGRMQTY' OR 'ZGRSQTY' OR 'ZGRVQTY' OR 'ZGRDIFFQTY'.






*        READ TABLE GT_DISP_100 INDEX LS_GOOD_CELLS-ROW_ID.

*        CHECK SY-SUBRC EQ 0.

*

*        PERFORM CHECK_QTY USING GT_DISP_100 CHANGING GT_DISP_100-STATUS

*                                                     GT_DISP_100-ICON.

*

*        _MODI_CELL PO_DATA_CHANGED LS_GOOD_CELLS-ROW_ID 'STATUS' GT_DISP_100-STATUS.

*        _MODI_CELL PO_DATA_CHANGED LS_GOOD_CELLS-ROW_ID 'ICON' GT_DISP_100-ICON.

*

*        MODIFY GT_DISP_100 INDEX LS_GOOD_CELLS-ROW_ID TRANSPORTING STATUS ICON.








    ENDCASE.



  ENDLOOP.





ENDFORM.