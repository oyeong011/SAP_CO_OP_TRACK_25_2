
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_005_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE GV_OKCODE.

    WHEN 'SAVE'.

      IF GV_MODE = 'CREATE'.

        PERFORM CHECK_MANDATORY_PURCHASE.

      ENDIF.

      PERFORM SAVE_DATA.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE GV_OKCODE.

    WHEN C_BACK OR C_CANC.

      LEAVE TO SCREEN 0.

    WHEN C_EXIT.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.