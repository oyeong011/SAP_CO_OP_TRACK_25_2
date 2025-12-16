
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_020_CLS

*&---------------------------------------------------------------------*






CLASS LCL_EVENT_RECEIVER DEFINITION.



  PUBLIC SECTION.

  METHODS HANDLER_TOOLBAR FOR EVENT TOOLBAR

                          OF CL_GUI_ALV_GRID

                          IMPORTING E_OBJECT

                                    E_INTERACTIVE.

  METHODS HANDLER_BUTTON_CLICK FOR EVENT BUTTON_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING ES_COL_ID

                                         ES_ROW_NO.



  METHODS HANDLER_USER_COMMAND FOR EVENT USER_COMMAND

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_UCOMM.

  METHODS HANDLER_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_ROW_ID

                                         E_COLUMN_ID

                                         ES_ROW_NO.

  METHODS HANDLER_DOUBLE_CLICK FOR EVENT DOUBLE_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.

  METHODS HANDLER_DATA_CHANGED FOR EVENT DATA_CHANGED

                               OF CL_GUI_ALV_GRID

                               IMPORTING ER_DATA_CHANGED

                                         E_ONF4

                                         E_ONF4_BEFORE

                                         E_ONF4_AFTER

                                         E_UCOMM.

  METHODS HANDLER_DATA_CHANGED_FINISHED FOR EVENT DATA_CHANGED_FINISHED

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_MODIFIED

                                         ET_GOOD_CELLS.



ENDCLASS.



CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.



  METHOD HANDLER_TOOLBAR.



  ENDMETHOD.

  METHOD HANDLER_USER_COMMAND.



  ENDMETHOD.

  METHOD HANDLER_HOTSPOT_CLICK.



  ENDMETHOD.

  METHOD HANDLER_BUTTON_CLICK.

    PERFORM ALV_BUTTON_CLICK   USING ES_COL_ID

                                     ES_ROW_NO.

  ENDMETHOD.

  METHOD HANDLER_DOUBLE_CLICK.




*    PERFORM ALV_HANDLER_DOUBLE_CLICK USING E_ROW

*                                           E_COLUMN

*                                           ES_ROW_NO.




  ENDMETHOD.

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLER_DATA_CHANGED USING  ER_DATA_CHANGED

                                    E_ONF4

                                    E_ONF4_BEFORE

                                    E_ONF4_AFTER

                                    E_UCOMM.

  ENDMETHOD.

  METHOD HANDLER_DATA_CHANGED_FINISHED.

    PERFORM ALV_DATA_CHANGED_FINISHED USING E_MODIFIED

                                            ET_GOOD_CELLS.

  ENDMETHOD.

ENDCLASS.



CLASS LCL_TREE_HANDLER DEFINITION.

  PUBLIC SECTION.

    METHODS ON_ITEM_DOUBLE_CLICK

      FOR EVENT ITEM_DOUBLE_CLICK OF CL_GUI_COLUMN_TREE

      IMPORTING NODE_KEY ITEM_NAME.

ENDCLASS.



CLASS LCL_TREE_HANDLER IMPLEMENTATION.



  METHOD ON_ITEM_DOUBLE_CLICK.

    PERFORM TREE_HANDLER_ITEM_DOUBLE_CLICK USING NODE_KEY ITEM_NAME.

  ENDMETHOD.

ENDCLASS.