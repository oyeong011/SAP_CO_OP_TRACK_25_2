
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_037_CLS

*&---------------------------------------------------------------------*






"### ###

CLASS EVENT DEFINITION.

  PUBLIC SECTION.



  "##

  METHODS HANDLER_TOOLBAR FOR EVENT TOOLBAR   "### ####

                          OF CL_GUI_ALV_GRID  "### ###

                          IMPORTING E_OBJECT

                                    E_INTERACTIVE.  "### #####



  "USER_COMMAND

  METHODS HANDLER_USER_COMMAND FOR EVENT USER_COMMAND

                             OF CL_GUI_ALV_GRID

                             IMPORTING E_UCOMM.



  "HOTSPOT_CLICK

  "####

  "E_ROW_ID : #### ### ALV# #(row) ## -> ex) 3## # == E_ROW_ID-INDEX = 3

  "E_COLUMN_ID : #### ### ALV# #(column) ## -> ex) ### # ### = E_COLUMN_ID-FIELDNAME = 'ZUSER'

  "ES_ROW_NO : ### ## ## ####### ROW ## -> ex) READ TABLE GT_DATA INDEX ES_ROW_NO-ROW_ID.

  METHODS HANDLER_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK

                                OF CL_GUI_ALV_GRID

                                IMPORTING E_ROW_ID

                                          E_COLUMN_ID

                                          ES_ROW_NO.

  "DOUBLE_CLICK

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

  "DATA_CHANGED_FINISHED

  METHODS HANDLER_DATA_CHANGED_FINISHED FOR EVENT DATA_CHANGED_FINISHED

                                        OF CL_GUI_ALV_GRID

                                        IMPORTING E_MODIFIED

                                                  ET_GOOD_CELLS.

ENDCLASS.





"### ###

CLASS EVENT IMPLEMENTATION.



  "##

  METHOD HANDLER_TOOLBAR.

    PERFORM ALV_HANDLER_TOOLBAR USING E_OBJECT

                                      E_INTERACTIVE. "### ### ### #### (f01#)

  ENDMETHOD.



  "USER_COMMAND

  METHOD HANDLER_USER_COMMAND.

    PERFORM ALV_HANDLER_USER_COMMAND USING E_UCOMM.

  ENDMETHOD.



  "HOTSPOT_CLICK

  METHOD HANDLER_HOTSPOT_CLICK.

    PERFORM ALV_HANDLER_HOTSPOT_CLICK USING E_ROW_ID

                                            E_COLUMN_ID

                                            ES_ROW_NO.

  ENDMETHOD.



  "DOUBLE_CLICK

  METHOD HANDLER_DOUBLE_CLICK.

    PERFORM ALV_HANDLER_DOUBLC_CLICK USING E_ROW

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



  "DATA_CHANGED_FINISHED

  METHOD HANDLER_DATA_CHANGED_FINISHED.

    PERFORM ALV_DATA_CHANGED_FINISHED USING E_MODIFIED

                                            ET_GOOD_CELLS.

  ENDMETHOD.

ENDCLASS.