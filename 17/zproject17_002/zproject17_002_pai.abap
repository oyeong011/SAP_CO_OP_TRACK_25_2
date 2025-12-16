
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_002_PAI

*&---------------------------------------------------------------------*






MODULE exit_command INPUT.



  ok_code = sy-ucomm.



  CASE ok_code.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



  CLEAR ok_code.



ENDMODULE.



MODULE user_command_0100 INPUT.



   case sy-ucomm.

    WHEN 'ADD'.

      PERFORM add_item_line.



    WHEN 'DEL'.

      PERFORM delete_item_line.



    WHEN 'SAVE'.

      PERFORM save_po.



    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.



  ENDCASE.

ENDMODULE.