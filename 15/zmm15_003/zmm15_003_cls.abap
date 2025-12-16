
*&---------------------------------------------------------------------*

*&  Include           ZMM15_003_CLS

*&---------------------------------------------------------------------*






CLASS EVENT DEFINITION.

  PUBLIC SECTION.

  METHODS HANDLER_DATA_CHANGED FOR EVENT DATA_CHANGED

                            OF CL_GUI_ALV_GRID

                            IMPORTING ER_DATA_CHANGED

                                      E_ONF4

                                      E_ONF4_BEFORE

                                      E_ONF4_AFTER

                                      E_UCOMM.



  METHODS HANDLER_DOUBLE_CLICK FOR EVENT DOUBLE_CLICK

                            OF CL_GUI_ALV_GRID

                            IMPORTING E_ROW

                                      E_COLUMN.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLER_DATA_CHANGED USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

  ENDMETHOD.



  METHOD HANDLER_DOUBLE_CLICK.

    PERFORM LV_HANDLER_DOUBLE_CLICK USING E_ROW

                                          E_COLUMN.

  ENDMETHOD.

ENDCLASS.