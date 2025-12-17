
*&---------------------------------------------------------------------*

*&  Include           ZMM09_004_CLS

*&---------------------------------------------------------------------*






CLASS EVENT DEFINITION.

  PUBLIC SECTION.



  "DATA_CHANDGED

  METHODS HANDLER_DATA_CHANGED FOR EVENT DATA_CHANGED

                               OF CL_GUI_ALV_GRID

                               IMPORTING ER_DATA_CHANGED "data change object

                                         E_ONF4

                                         E_ONF4_BEFORE

                                         E_ONF4_AFTER

                                         E_UCOMM.



  "DATA_CHANDGED_200

  METHODS HANDLER_DATA_CHANGED_200 FOR EVENT DATA_CHANGED

                               OF CL_GUI_ALV_GRID

                               IMPORTING ER_DATA_CHANGED "data change object

                                         E_ONF4

                                         E_ONF4_BEFORE

                                         E_ONF4_AFTER

                                         E_UCOMM.



  "DATA_CHANGED_FINISHED

  METHODS HANDLER_DATA_CHANGED_FINISHED FOR EVENT DATA_CHANGED_FINISHED

                                        OF CL_GUI_ALV_GRID

                                        IMPORTING E_MODIFIED

                                                  ET_GOOD_CELLS.





  "#### ### - MIRO ###

  METHODS HANDLER_DOUBLE_CLICK_MIRO FOR EVENT DOUBLE_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.

  "DATA_CHANGED

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLER_DATA_CHANGED USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

  ENDMETHOD.



  "DATA_CHANGED_200

  METHOD HANDLER_DATA_CHANGED_200.

    PERFORM ALV_HANDLER_DATA_CHANGED_200 USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

  ENDMETHOD.



  "DATA_CHANGED_FINISHED

  METHOD HANDLER_DATA_CHANGED_FINISHED.

    PERFORM ALV_DATA_CHANGED_FINISHED USING E_MODIFIED

                                            ET_GOOD_CELLS.

  ENDMETHOD.



  "#### ###  - MIRO ###

  METHOD HANDLER_DOUBLE_CLICK_MIRO.

    PERFORM ALV_HANDLER_DOUBLE_CLICK_MIRO USING  E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.



  ENDMETHOD.



ENDCLASS.