
*&---------------------------------------------------------------------*

*&  Include           ZMM05_002_CLS

*&---------------------------------------------------------------------*






CLASS LCL_EVENT_RECEIVER DEFINITION.

  PUBLIC SECTION.

    METHODS : HANDLE_DATA_CHANGED

              FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

              IMPORTING ER_DATA_CHANGED.

ENDCLASS.



CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.

  METHOD HANDLE_DATA_CHANGED.

    PERFORM CHECK_ALV_DATA_CHANGED USING ER_DATA_CHANGED.

  ENDMETHOD.

ENDCLASS.