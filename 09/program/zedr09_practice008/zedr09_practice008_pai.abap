
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_PRACTICE008_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.



    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*




MODULE EXIT_COMMAND_0200 INPUT.

  CASE OK_CODE.

  WHEN 'BACK' OR 'CANC'.

    LEAVE TO SCREEN 0.



  WHEN 'EXIT'.

    LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.