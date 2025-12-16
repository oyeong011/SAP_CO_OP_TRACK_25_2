
*&---------------------------------------------------------------------*

*&  Include           ZEDR11_PRACTICE008_PAI

*&---------------------------------------------------------------------*




MODULE exit_command INPUT.

  CASE ok_code.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.