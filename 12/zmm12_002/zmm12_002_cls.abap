
*&---------------------------------------------------------------------*

*&  Include           ZMM12_002_CLS

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

  METHODS HANDLE_TOOLBAR FOR EVENT TOOLBAR

                          OF CL_GUI_ALV_GRID

                          IMPORTING E_OBJECT

                                    E_INTERACTIVE.

  METHODS HANDLE_USER_COMMAND FOR EVENT USER_COMMAND

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_UCOMM.




*  https://only10.tistory.com/entry/ABAP-ALV-GRID-EVENT-CLASS-METHOD-%EA%B5%AC%EB%AC%B8#google_vignette




ENDCLASS.

CLASS EVENT IMPLEMENTATION.

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLER_DATA_CHANGED USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

  ENDMETHOD.

  METHOD HANDLER_DATA_CHANGED_FINISHED.

    PERFORM ALV_DATA_CHANGED_FINISHED USING E_MODIFIED

                                            ET_GOOD_CELLS.

  ENDMETHOD.

  METHOD HANDLE_TOOLBAR.

    PERFORM ALV_HANDLER_TOOLBAR USING E_OBJECT

                                      E_INTERACTIVE.

  ENDMETHOD.

  METHOD HANDLE_USER_COMMAND.

    PERFORM ALV_HANDLER_USER_COMMAND USING E_UCOMM.

  ENDMETHOD.

ENDCLASS.