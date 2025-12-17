
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'APND'.

      PERFORM APPEND_LINE.

    WHEN 'DELT'.

      PERFORM DELETE_LINE.

    WHEN 'GNRT'.

      PERFORM CHECK_BLANK.

      PERFORM GENERATE_PO.

    ENDCASE.

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