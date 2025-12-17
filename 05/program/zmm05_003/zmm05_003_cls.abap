
*&---------------------------------------------------------------------*

*&  Include           ZMM05_003_CLS

*&---------------------------------------------------------------------*






CLASS LCL_EVENT_HANDLER DEFINITION.



  PUBLIC SECTION.

    " 1. ALV ### ##

    METHODS : HANDLER_DATA_CHANGED

                  FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

      IMPORTING ER_DATA_CHANGED

                  E_ONF4

                  E_ONF4_BEFORE

                  E_ONF4_AFTER

                  E_UCOMM.



    " 2. ALV ### ## ##

    METHODS : HANDLER_DATA_CHANGED_FINISHED

                  FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID

      IMPORTING E_MODIFIED

                  ET_GOOD_CELLS.



    " 3. Tree ## ## ##

    METHODS : HANDLE_NODE_DOUBLE_CLICK

                  FOR EVENT NODE_DOUBLE_CLICK OF CL_GUI_SIMPLE_TREE

      IMPORTING NODE_KEY

                  SENDER.

ENDCLASS.



CLASS LCL_EVENT_HANDLER IMPLEMENTATION.



  " 1. ### ## # -> F01# FORM ##

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLER_DATA_CHANGED USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

  ENDMETHOD.



  " 2. ### ## ## # -> F01# FORM ## (#####)

  METHOD HANDLER_DATA_CHANGED_FINISHED.

    PERFORM ALV_DATA_CHANGED_FINISHED USING E_MODIFIED

                                            ET_GOOD_CELLS.

  ENDMETHOD.



  " 3. ## ## ## -> [##] F02# FORM ### ##

  METHOD HANDLE_NODE_DOUBLE_CLICK.

    PERFORM HANDLE_NODE_DOUBLE_CLICK USING NODE_KEY.

  ENDMETHOD.



ENDCLASS.