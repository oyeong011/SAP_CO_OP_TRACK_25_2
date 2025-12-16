
*&---------------------------------------------------------------------*

*&  Include           ZMM12_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*MODULE USER_COMMAND_0100 INPUT.

*  CASE OK_CODE.

*    WHEN 'APPEND'.

**      PERFORM ADD_ITEM.

*    WHEN 'DELETE'.

**    PERFORM DELETE_ITEM.

*    WHEN 'CREATE'.

**      PERFORM SAVE_PO.

*  ENDCASE.

*ENDMODULE.

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANCLE'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.