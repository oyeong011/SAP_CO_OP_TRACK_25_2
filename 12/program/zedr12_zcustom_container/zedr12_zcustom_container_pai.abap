
*&---------------------------------------------------------------------*

*&  Include           ZEDR12_ZCUSTOM_CONTAINER_PAI

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



ENDMODULE.




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