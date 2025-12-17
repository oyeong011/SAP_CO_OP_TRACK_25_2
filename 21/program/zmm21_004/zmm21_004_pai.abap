
*&---------------------------------------------------------------------*

*&  Include           ZMM21_004_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'CREATE'.

    PERFORM CREATE_SONGJANG.

    LEAVE TO SCREEN 0.

    ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE TO SCREEN 0.

    WHEN 'CANCEL'.

    PERFORM CANCEL_inv.

    ENDCASE.

ENDMODULE.