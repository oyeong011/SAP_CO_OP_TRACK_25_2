
*&---------------------------------------------------------------------*

*&  Include           ZMM03_002_CLS

*&---------------------------------------------------------------------*



* ### ##




CLASS LCL_EVENT DEFINITION.

  PUBLIC SECTION.

    " ### ## ### (#### ## # ##)

    METHODS HANDLE_DATA_CHANGED

      FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

      IMPORTING ER_DATA_CHANGED.



    " ### ## ## # ### (### ##)

    METHODS HANDLE_DATA_CHANGED_FINISHED

      FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID

      IMPORTING E_MODIFIED ET_GOOD_CELLS.

ENDCLASS.






* ### ##




CLASS LCL_EVENT IMPLEMENTATION.



  " ### ## # ## ##

  METHOD HANDLE_DATA_CHANGED.

    PERFORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED.

  ENDMETHOD.



  " ### ## ## # ## ##

  METHOD HANDLE_DATA_CHANGED_FINISHED.

    " #### ## #

  ENDMETHOD.

ENDCLASS.