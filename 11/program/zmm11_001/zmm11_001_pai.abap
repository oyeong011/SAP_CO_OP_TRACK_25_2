
*&---------------------------------------------------------------------*

*&  Include           ZMM11_001_PAI

*&---------------------------------------------------------------------*






MODULE EXIT_COMMAND INPUT.

  CASE ok_code.

    WHEN 'BACK' or 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.



MODULE USER_COMMAND_0100 INPUT.

  CASE ok_code.

    WHEN 'ADD'.

      gv_mode = 'E'. "## ###

    WHEN 'CREATE'.

      gv_mode = 'S'. "##

      PERFORM create_data.

  ENDCASE.

ENDMODULE.



MODULE USER_COMMAND_0200 INPUT.

  CASE ok_code.

    WHEN 'SAVE'.

      PERFORM save_data.

  ENDCASE.

ENDMODULE.