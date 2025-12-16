
*&---------------------------------------------------------------------*

*&  Include           ZMM05_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module EXIT_COMMAND input.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

endmodule.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  GV_OKCODE = OK_CODE.

  CLEAR OK_CODE.



  CASE GV_OKCODE.

    WHEN 'ADD'.  " GUI Status## ## ####

      PERFORM BTN_ADD_ROW.



    WHEN 'REMOVE'.

      PERFORM BTN_REMOVE_ROW.

    WHEN GC_SAVE.    " ## (### ##)

       PERFORM SAVE_DATA.



  ENDCASE.



ENDMODULE.