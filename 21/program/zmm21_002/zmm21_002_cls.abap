
*&---------------------------------------------------------------------*

*&  Include           ZMM21_002_CLS

*&---------------------------------------------------------------------*




"### ### ##

CLASS EVENT DEFINITION.

  PUBLIC SECTION.

    METHODS ON_F4 FOR EVENT ONF4 OF CL_GUI_ALV_GRID

      IMPORTING

        E_FIELDNAME

        ES_ROW_NO

        ER_EVENT_DATA

        ET_BAD_CELLS

        E_DISPLAY.

ENDCLASS.

"### ### ##

CLASS EVENT IMPLEMENTATION.

  METHOD ON_F4.

    PERFORM ALV_ON_F4 USING E_FIELDNAME

                             ES_ROW_NO-ROW_ID

                             ER_EVENT_DATA

                             ET_BAD_CELLS

                             E_DISPLAY.

  ENDMETHOD.

ENDCLASS.