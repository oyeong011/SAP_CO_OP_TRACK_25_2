
*&---------------------------------------------------------------------*

*& Include ZMM11_002_PAI

*&---------------------------------------------------------------------*




MODULE exit_command INPUT.

  CASE gv_ok_code.

    WHEN 'BACK' OR 'CANC'. LEAVE TO SCREEN 0.

    WHEN 'EXIT'. LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.



MODULE user_command_0100 INPUT.

  gv_ucomm = gv_ok_code.

  CLEAR gv_ok_code.



  CASE gv_ucomm.

    WHEN 'ADD_ROW'. PERFORM append_empty_line.

    WHEN 'DEL_ROW'. PERFORM delete_selected_lines.

    WHEN 'SAVE'.    PERFORM validate_lines.

                    PERFORM save_to_database.

  ENDCASE.

ENDMODULE.