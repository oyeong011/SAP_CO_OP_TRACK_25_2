
*&---------------------------------------------------------------------*

*& Include ZEDR11_PRACTICE009_PAI

*&---------------------------------------------------------------------*




MODULE exit_command INPUT.

  CASE ok_code.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.