
*&---------------------------------------------------------------------*

*&  Include           ZWORK16_001_CLS

*&---------------------------------------------------------------------*






" ALV ### ### ### ##

CLASS EVENT DEFINITION.

  PUBLIC SECTION.



    " ALV ### ## ### ###

    METHODS HANDLER_DATA_CHANGED FOR EVENT DATA_CHANGED

                  OF CL_GUI_ALV_GRID

      IMPORTING ER_DATA_CHANGED.



ENDCLASS.



CLASS EVENT IMPLEMENTATION.



  METHOD HANDLER_DATA_CHANGED.

    " ### ## # ### # ##

    PERFORM ALV_HANDLER_DATA_CHANGED USING ER_DATA_CHANGED.

  ENDMETHOD.



ENDCLASS.