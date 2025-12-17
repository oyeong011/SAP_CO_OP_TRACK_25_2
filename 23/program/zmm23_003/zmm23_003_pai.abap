
*&---------------------------------------------------------------------*

*&  Include           ZMM23_003_PAI

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

    WHEN 'CREATE'.       "##

      GV_DYNNR = '0101'.

    WHEN 'SEARCH'.       "##

      GV_DYNNR = '0102'.

    WHEN 'ADD'.

       PERFORM GET_PO.

       OK_CODE = ''.

       CHECK GV_FLAG EQ '0'.

         CALL SCREEN 200.

    WHEN 'SCH'.

      PERFORM GET_MIGO.

      OK_CODE = ''.

      CHECK GV_FLAG EQ '0'.

        CALL SCREEN 300.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  PAI_TABLE_CONTROL  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE PAI_TABLE_CONTROL INPUT.

  MODIFY GT_EKPO FROM GS_EKPO INDEX CTR_200-CURRENT_LINE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  DATA : LV_FLAG TYPE C.



  CASE : OK_CODE.

    WHEN 'CREA'.  " ## : ## ##



      CLEAR : LV_FLAG.

      LOOP AT GT_EKPO INTO DATA(LINE).

        IF LINE-MENGE_I > LINE-MENGE_R.

          MESSAGE '##### ######.(##### ###### #### ###.)' TYPE 'I'.

          LV_FLAG = 'X'.

          EXIT.

        ENDIF.

      ENDLOOP.



      IF LV_FLAG NE 'X'.

        PERFORM SAVE_MIGO.

        OK_CODE = ''.

        PERFORM GET_PO.

      ENDIF.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  PAI_TABLE_CONTROL_300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE PAI_TABLE_CONTROL_300 INPUT.

  MODIFY GT_MSEG FROM GS_MSEG INDEX CTR_300-CURRENT_LINE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0300 INPUT.

  CASE OK_CODE.

    WHEN 'DEL'.  "######

      PERFORM REMOVE_MIGO.

  ENDCASE.

ENDMODULE.