
*&---------------------------------------------------------------------*

*&  Include           ZWORK03_001_PAI

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

    WHEN 'SAVE'. "#### ##

      "1. ALV## ## ## ## #### ### DATA_CHANGED ##

      IF GC_GRID IS BOUND.

        CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

      ENDIF.



      "2. ### DB ##

      PERFORM SAVE_CURR.

  ENDCASE.

ENDMODULE.