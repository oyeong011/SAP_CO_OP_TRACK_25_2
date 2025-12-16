
*&---------------------------------------------------------------------*

*&  Include           ZMM22_002_CLS

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



    METHODS HANDLER_DATA_CHANGED_FINISHED FOR EVENT DATA_CHANGED_FINISHED

                                          OF CL_GUI_ALV_GRID

                                          IMPORTING E_MODIFIED

                                                    ET_GOOD_CELLS.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.



  METHOD handler_data_changed.

    PERFORM alv_handler_data_changed USING er_data_changed

                                           e_onf4

                                           e_onf4_before

                                           e_onf4_after

                                           e_ucomm.

  ENDMETHOD.



  METHOD handler_data_changed_finished.

    PERFORM alv_data_changed_finished USING e_modified

                                             et_good_cells.

  ENDMETHOD.



ENDCLASS.