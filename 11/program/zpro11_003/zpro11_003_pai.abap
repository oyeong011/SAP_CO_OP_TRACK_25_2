
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_003_PAI

*&---------------------------------------------------------------------*

*& Process After Input ##

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Module  EXIT_CMD  INPUT

*&---------------------------------------------------------------------*




MODULE exit_cmd INPUT.

  CASE gv_okcode.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_CMD_100  INPUT

*&---------------------------------------------------------------------*




MODULE user_cmd_100 INPUT.

  CASE gv_okcode.

    WHEN 'CREATE'.

      PERFORM process_goods_receipt.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_CMD_200  INPUT

*&---------------------------------------------------------------------*




MODULE user_cmd_200 INPUT.

  CASE gv_okcode.

    WHEN 'CANCEL'.

      PERFORM process_gr_reversal.

  ENDCASE.

ENDMODULE.