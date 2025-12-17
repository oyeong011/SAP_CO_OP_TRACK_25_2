
*&---------------------------------------------------------------------*

*&  Include           ZEDR23_018_CLS

*&---------------------------------------------------------------------*




CLASS EVENT DEFINITION.

  PUBLIC SECTION.

  METHODS HANDLER_TOOLBAR

  FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID

  IMPORTING E_OBJECT E_INTERACTIVE.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.

  METHOD HANDLER_TOOLBAR.

    PERFORM ALV_HANDLER_TOOLBAR USING E_OBJECT E_INTERACTIVE.

  ENDMETHOD.

ENDCLASS.