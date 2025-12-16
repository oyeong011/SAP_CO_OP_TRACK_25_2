
*&---------------------------------------------------------------------*

*&  Include           ZMM10_MIGO_I01

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  IF OK_CODE = 'SAVE'.

    IF R_CREA IS INITIAL. " ## ### ####(#, ######)

      MESSAGE '## ##### ### # ####.' TYPE 'S' DISPLAY LIKE 'E'.

      CLEAR OK_CODE.

      RETURN.

    ENDIF.

  ENDIF.



  CASE OK_CODE.

    WHEN 'SAVE'.

      PERFORM SAVE_DATA. " ## ## (F01# ###)

  ENDCASE.

ENDMODULE.



MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANCEL'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.