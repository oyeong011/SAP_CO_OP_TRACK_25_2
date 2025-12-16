
*&---------------------------------------------------------------------*

*&  Include           ZMM09_003_CLS

*&---------------------------------------------------------------------*






CLASS EVENT DEFINITION.

  PUBLIC SECTION.



  "#### ###

  METHODS HANDLER_DOUBLE_CLICK FOR EVENT DOUBLE_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.



  "DATA_CHANDGED

  METHODS HANDLER_DATA_CHANGED FOR EVENT DATA_CHANGED

                               OF CL_GUI_ALV_GRID

                               IMPORTING ER_DATA_CHANGED "data change object

                                         E_ONF4

                                         E_ONF4_BEFORE

                                         E_ONF4_AFTER

                                         E_UCOMM.



  "#### ### - 300 ###

  METHODS HANDLER_DOUBLE_CLICK_300 FOR EVENT DOUBLE_CLICK

                                   OF CL_GUI_ALV_GRID

                                   IMPORTING  E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.



  "#### ### - 410 ###

  METHODS HANDLER_DOUBLE_CLICK_410 FOR EVENT DOUBLE_CLICK

                                   OF CL_GUI_ALV_GRID

                                   IMPORTING  E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.



  "#### ###

  METHOD HANDLER_DOUBLE_CLICK.

    PERFORM ALV_HANDLER_DOUBLE_CLICK USING  E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.



  ENDMETHOD.



  "DATA_CHANGED

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLER_DATA_CHANGED USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

  ENDMETHOD.



  "#### ### - 300 ###

  METHOD HANDLER_DOUBLE_CLICK_300.

    PERFORM ALV_HANDLER_DOUBLE_CLICK_300 USING  E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.

  ENDMETHOD.



  "#### ### - 410 ###

  METHOD HANDLER_DOUBLE_CLICK_410.

    PERFORM ALV_HANDLER_DOUBLE_CLICK_410 USING  E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.

  ENDMETHOD.





ENDCLASS.