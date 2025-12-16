
*&---------------------------------------------------------------------*

*&  Include           ZMM22_003_CLS

*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*

* CLASS EVENT DEFINITION

*----------------------------------------------------------------------*






CLASS LCL_EVENT_HANDLER DEFINITION.

  PUBLIC SECTION.

    METHODS:

      HANDLE_DOUBLE_CLICK

        FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID

        IMPORTING E_ROW E_COLUMN.

ENDCLASS.



CLASS LCL_EVENT_HANDLER IMPLEMENTATION.

  METHOD HANDLE_DOUBLE_CLICK.

    PERFORM GET_DETAIL_DATA USING E_ROW-INDEX.

    CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

      EXPORTING NEW_CODE = 'REFRESH'.

  ENDMETHOD.

ENDCLASS.