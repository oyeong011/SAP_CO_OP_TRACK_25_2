
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT004_CLS

*&---------------------------------------------------------------------*




CLASS EVENT DEFINITION.

  PUBLIC SECTION.

  METHODS HANDLE_DATA_CHANGED FOR EVENT DATA_CHANGED    " ALV## ### #### ## ##

                              OF CL_GUI_ALV_GRID

                              IMPORTING ER_DATA_CHANGED

                                        E_ONF4

                                        E_ONF4_BEFORE

                                        E_ONF4_AFTER

                                        E_UCOMM.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.

  METHOD HANDLE_DATA_CHANGED.

    PERFORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED E_ONF4 E_ONF4_BEFORE E_ONF4_AFTER E_UCOMM.

  ENDMETHOD.

ENDCLASS.