
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_001_PAI

*&---------------------------------------------------------------------*






MODULE user_command_0100 INPUT.




*  PERFORM pai_0100.




ENDMODULE.



MODULE exit_command INPUT.

  ok_code = sy-ucomm.

  CASE ok_code.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      leave program.

  ENDCASE.



  CLEAR ok_code.



ENDMODULE.