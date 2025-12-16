
*&---------------------------------------------------------------------*

*&  Include           ZWORK23_002_PAI

*&---------------------------------------------------------------------*






MODULE USER_COMMAND_0100.

  CASE OK_CODE.

    WHEN 'SAVEPDF'.

      PERFORM SAVE_PDF.

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