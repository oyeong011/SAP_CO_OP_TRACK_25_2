
*&---------------------------------------------------------------------*

*&  Include           ZMM14_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  CASE OK_CODE.

    WHEN 'ADD'.

      GV_MODE = 'I'.

      CLEAR GS_DATA.

    WHEN 'SAVE'.

      IF GV_MODE <> 'I'.

        MESSAGE '## ### ## #####.' TYPE 'S' DISPLAY LIKE 'W'.

      ELSE.

        PERFORM CHECK_SAVE_DATA.

        IF SY-SUBRC = 0.

          PERFORM SAVE_DATA.

        ENDIF.

      ENDIF.

    WHEN 'EXIT' OR 'CANC'.

      LEAVE TO SCREEN 0.

  ENDCASE.



  CLEAR OK_CODE.



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

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.



ENDMODULE.