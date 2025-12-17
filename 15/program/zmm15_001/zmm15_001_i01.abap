
*&---------------------------------------------------------------------*

*&  Include           ZMM15_001_I01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'APND'.

      GV_APND_MODE = 'X'.

    WHEN 'SAVE'.

      PERFORM SAVE_DATA.

   ENDCASE.

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

  CASE OK_CODE.

      WHEN 'SAVE'.

        CLEAR : GS_ALV, GS_ZLFA1.



        LOOP AT GT_ALV INTO GS_ALV.

          MOVE-CORRESPONDING GS_ALV TO GS_ZLFA1.

          GS_ZLFA1-MANDT = SY-MANDT.

          APPEND GS_ZLFA1 TO GT_ZLFA1.

        ENDLOOP.



       MODIFY ZLFA1_15 FROM TABLE GT_ZLFA1.



       IF SY-SUBRC = 0.

          MESSAGE '####' TYPE 'I'.

       ELSE.

          MESSAGE '####' TYPE 'I'.

       ENDIF.

  ENDCASE.

ENDMODULE.