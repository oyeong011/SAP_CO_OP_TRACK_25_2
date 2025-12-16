
*&---------------------------------------------------------------------*

*&  Include           ZEDR24_025_USERCOMMAND_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  "APPEND ## ##

  CASE OK_CODE.

    WHEN 'APND'.

      CLEAR GS_002.

      GS_002-ZCODE = 'SSU-99'.

      GS_002-ZPERNR = '00000059'.

      GS_002-ZMNAME = '##'.

      APPEND GS_002 TO GT_002.

    WHEN 'SAVE'.

      MODIFY ZEDT24_002 FROM TABLE GT_002.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'BACK'.

      LEAVE SCREEN.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.