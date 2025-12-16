
MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      " ALV Grid ##

      IF GC_GRID IS BOUND.

        CALL METHOD GC_GRID->FREE

          EXCEPTIONS

            CNTL_ERROR        = 1

            CNTL_SYSTEM_ERROR = 2

            OTHERS            = 3.

        FREE GC_GRID.

      ENDIF.



      " Docking Container ##

      IF GC_DOCKING IS BOUND.

        CALL METHOD GC_DOCKING->FREE

          EXCEPTIONS

            CNTL_ERROR        = 1

            CNTL_SYSTEM_ERROR = 2

            OTHERS            = 3.

        FREE GC_DOCKING.

      ENDIF.



      " ## ##

      IF OK_CODE = 'EXIT'.

        LEAVE PROGRAM.

      ELSE.

        LEAVE TO SCREEN 0.

      ENDIF.

  ENDCASE.



  CLEAR OK_CODE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module USER_COMMAND_0100 input.

  CASE OK_CODE.

    WHEN 'SAVE'.

      PERFORM SAVE_DATA.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      " ALV Grid ##

      IF GC_GRID IS BOUND.

        CALL METHOD GC_GRID->FREE

          EXCEPTIONS

            CNTL_ERROR        = 1

            CNTL_SYSTEM_ERROR = 2

            OTHERS            = 3.

        FREE GC_GRID.

      ENDIF.



      " Docking Container ##

      IF GC_DOCKING IS BOUND.

        CALL METHOD GC_DOCKING->FREE

          EXCEPTIONS

            CNTL_ERROR        = 1

            CNTL_SYSTEM_ERROR = 2

            OTHERS            = 3.

        FREE GC_DOCKING.

      ENDIF.



      " ## ##

      IF OK_CODE = 'EXIT'.

        LEAVE PROGRAM.

      ELSE.

        LEAVE TO SCREEN 0.

      ENDIF.

  ENDCASE.



  CLEAR OK_CODE.

endmodule.