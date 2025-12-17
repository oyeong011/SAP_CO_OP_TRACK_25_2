
*&---------------------------------------------------------------------*

*&  Include           ZEDT20_030_CLS

*&---------------------------------------------------------------------*






CLASS EVENT DEFINITION.

  PUBLIC SECTION.

  METHODS HANDLE_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_ROW_ID

                                         E_COLUMN_ID

                                         ES_ROW_NO.

  METHODS HANDLE_DATA_CHANGED FOR EVENT DATA_CHANGED

                              OF CL_GUI_ALV_GRID

                              IMPORTING ER_DATA_CHANGED

                                        E_ONF4

                                        E_ONF4_BEFORE

                                        E_ONF4_AFTER

                                        E_UCOMM.

  METHODS HANDLE_DATA_CHANGED_FINISHED FOR EVENT DATA_CHANGED_FINISHED

                                       OF CL_GUI_ALV_GRID

                                       IMPORTING E_MODIFIED

                                                 ET_GOOD_CELLS.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK.

    PERFORM ALV_HANDLE_HOTSPOT_CLICK USING E_ROW_ID E_COLUMN_ID ES_ROW_NO.

  ENDMETHOD.

  METHOD HANDLE_DATA_CHANGED.

    PERFORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED E_ONF4 E_ONF4_BEFORE E_ONF4_AFTER E_UCOMM.

  ENDMETHOD.

  METHOD HANDLE_DATA_CHANGED_FINISHED.

    PERFORM ALV_DATA_CHANGED_FINISHED USING E_MODIFIED ET_GOOD_CELLS.

  ENDMETHOD.

ENDCLASS.