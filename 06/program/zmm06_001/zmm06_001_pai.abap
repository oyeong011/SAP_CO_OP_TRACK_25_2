
*&---------------------------------------------------------------------*

*&  Include           ZMM06_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'SAVE'.

      PERFORM CHECK_INPUT_VALID.

      PERFORM MM_SAVE.

    WHEN 'ADD'.

      PERFORM SAVE_TEST.

      PERFORM CHECK_ADD_BUTTON.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0300 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'CHANGE'.

      PERFORM CHANGE_LFA1_STCD2.

  ENDCASE.

ENDMODULE.