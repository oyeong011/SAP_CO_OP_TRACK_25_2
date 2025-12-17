
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_003_CLS

*&---------------------------------------------------------------------*




CLASS EVENT DEFINITION.     "###"

  PUBLIC SECTION.

  METHODS HANDLE_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_ROW_ID

                                         E_COLUMN_ID

                                         ES_ROW_NO.

ENDCLASS.

CLASS EVENT IMPLEMENTATION. "###"

  METHOD HANDLE_HOTSPOT_CLICK.

    PERFORM ALV_HANDLE_HOTSPOT_CLICK USING E_ROW_ID

                                           E_COLUMN_ID

                                           ES_ROW_NO.

  ENDMETHOD.

ENDCLASS.