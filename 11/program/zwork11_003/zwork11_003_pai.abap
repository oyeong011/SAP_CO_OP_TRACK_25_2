
MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'SAVE_PDF'.

      PERFORM SAVE_DATA.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'BACK'.

      LEAVE SCREEN.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.