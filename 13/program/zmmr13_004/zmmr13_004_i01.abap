
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_004_I01

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

    WHEN 'ENTR'.

      PERFORM CACULATE_BALANCE.

    WHEN 'CHECK'.

      IF GV_CHECK = 'X'.

        PERFORM CALCULATE_TAX.

      ELSE.

        PERFORM UNCALCULATE_TAX.

      ENDIF.

    WHEN 'INVO'.

      PERFORM INVOICE.

    WHEN 'CALL'.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE 'CINVO'.

    PERFORM CANCEL_INVOICE.

  ENDCASE.

ENDMODULE.