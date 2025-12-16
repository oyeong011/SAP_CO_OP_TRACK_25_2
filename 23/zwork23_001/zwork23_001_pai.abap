
*&---------------------------------------------------------------------*

*&  Include           ZWORK23_001_PAI

*&---------------------------------------------------------------------*






MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'SAVE_CURR'.

      PERFORM SAVE_CURR.

  ENDCASE.



ENDMODULE.



MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.