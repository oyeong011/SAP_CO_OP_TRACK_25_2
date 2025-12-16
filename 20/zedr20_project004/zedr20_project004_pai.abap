
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT004_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'FC_TAB1'.

      PACKAGE1-ACTIVETAB = 'FC_TAB1'.   " 1. # ### '## ##'## ##

      GV_SUBSCREEN       = '0101'.   " 2. ### ## ### 101### ##

    WHEN 'FC_TAB2'.

      PACKAGE1-ACTIVETAB = 'FC_TAB2'.   " 1. # ### '## ##'## ##

      GV_SUBSCREEN       = '0102'.   " 2. ### ## ### 102### ##

    WHEN 'SIML'.

      PERFORM SIMULATE.

    ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  MODIFY_AMOUNT  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_AMOUNT INPUT.

  GS_AMOUNT_HEADER-ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

  PERFORM CALCLUATE_ZBALANCE.

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




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0110  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0110 INPUT.

  CASE OK_CODE.

    WHEN 'FC_SAVE'.

      PERFORM INVOICE.

    WHEN 'FC_BACK'.

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

    WHEN 'DLTE'.

      PERFORM DELETE_INVOICED.

      PERFORM REVERSAL_ENTRY.

      PERFORM REFRESH.

    ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  MODIFY_MWSKZ_MEMO  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_MWSKZ_MEMO INPUT.

  PERFORM GET_TAX_RATE USING GS_AMOUNT_HEADER-MWSKZ.

  PERFORM MODIFY_BY_CHANGED_TAX_RATE.

  PERFORM CALCLUATE_ZBALANCE.

  PERFORM REFRESH.

ENDMODULE.