
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_001_PAI

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  GV_OKCODE = SY-UCOMM.



  CASE GV_OKCODE.

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.

      LEAVE TO SCREEN 0.

  ENDCASE.



  CLEAR GV_OKCODE.

ENDMODULE.










*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE GV_OKCODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.