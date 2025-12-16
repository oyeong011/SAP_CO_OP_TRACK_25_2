
*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_CLS

*&---------------------------------------------------------------------*






CLASS EVT_200 DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLER_DATA_CHANGED

      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

      IMPORTING

        ER_DATA_CHANGED

        E_ONF4

        E_ONF4_BEFORE

        E_ONF4_AFTER

        E_UCOMM.

ENDCLASS.



CLASS EVT_200 IMPLEMENTATION.



  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLE_DATA_CHANGED

      USING ER_DATA_CHANGED

            E_ONF4

            E_ONF4_BEFORE

            E_ONF4_AFTER

            E_UCOMM.

  ENDMETHOD.



ENDCLASS.



CLASS EVT_300 DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLER_DATA_CHANGED

      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

      IMPORTING

        ER_DATA_CHANGED

        E_ONF4

        E_ONF4_BEFORE

        E_ONF4_AFTER

        E_UCOMM.

ENDCLASS.



CLASS EVT_300 IMPLEMENTATION.



  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLE_DATA_CHANGED_300

      USING ER_DATA_CHANGED

            E_ONF4

            E_ONF4_BEFORE

            E_ONF4_AFTER

            E_UCOMM.

  ENDMETHOD.



ENDCLASS.