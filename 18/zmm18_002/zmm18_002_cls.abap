
*&---------------------------------------------------------------------*

*&  Include           ZMM18_002_CLS

*&---------------------------------------------------------------------*




CLASS EVENT DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLER_DATA_CHANGED FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

      IMPORTING ER_DATA_CHANGED.

ENDCLASS.

CLASS EVENT IMPLEMENTATION.

  METHOD HANDLER_DATA_CHANGED.

    PERFORM HANDLE_DATA_CHANGED USING ER_DATA_CHANGED.

  ENDMETHOD.

ENDCLASS.