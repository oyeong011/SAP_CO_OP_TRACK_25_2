
*&---------------------------------------------------------------------*

*& Include ZWORK11_002_PAI

*&---------------------------------------------------------------------*




MODULE exit_command INPUT.

  CASE ok_code.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.



MODULE user_command_0100 INPUT.

  CASE ok_code.

    " PDF ## ##

    WHEN 'SAVE_PDF'.

      PERFORM process_download.



    " [##] ####, ##, ## ## ## (####)

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.