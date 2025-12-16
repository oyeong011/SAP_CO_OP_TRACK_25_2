
*&---------------------------------------------------------------------*

*& Include ZMMR25_002_CLS

*&---------------------------------------------------------------------*






CLASS LCL_EVENT_RECEIVER DEFINITION.

  PUBLIC SECTION.

    METHODS : HANDLER_DATA_CHANGED

              FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

              IMPORTING ER_DATA_CHANGED.

ENDCLASS.



CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED.

  ENDMETHOD.

ENDCLASS.