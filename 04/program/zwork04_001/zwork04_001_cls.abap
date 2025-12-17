
*&---------------------------------------------------------------------*

*&  Include           ZWORK04_001_CLS

*&---------------------------------------------------------------------*




CLASS EVENT DEFINITION. " ###

  PUBLIC SECTION.

  METHODS HANDLER_DATA_CHANGED_FINISHED  FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID

                                IMPORTING E_MODIFIED

                                          ET_GOOD_CELLS.

ENDCLASS.

CLASS EVENT IMPLEMENTATION. " ###

  METHOD HANDLER_DATA_CHANGED_FINISHED.

    PERFORM ALV_DATA_CHANGED_FINISHED  USING E_MODIFIED

                                          ET_GOOD_CELLS.

  ENDMETHOD.

ENDCLASS.