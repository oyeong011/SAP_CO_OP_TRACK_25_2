
*&---------------------------------------------------------------------*

*&  Include           ZMM10_IV_MGT_PAI

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'EXIT' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN OTHERS.

      " ## ## ## # ##

  ENDCASE.

ENDMODULE.