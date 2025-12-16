
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_037_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND_0100 INPUT.

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

    WHEN 'APND'.

      CLEAR : GS_STUDENT.

      GS_STUDENT-ZCODE = 'SSU-30'.

      GS_STUDENT-ZPERNR = '0000000030'.

      GS_STUDENT-ZKNAME = '###'.

      GS_STUDENT-ZENAME = 'DO'.

      GS_STUDENT-ZGENDER = 'F'.

      GS_STUDENT-ZTEL = '01012345678'.

      GS_STUDENT-ZCOLOR = ICON_LED_GREEN.

      APPEND GS_STUDENT TO GT_STUDENT.

    WHEN 'SAVE'.

     " MODIFY ZEDT09_001 FROM TABLE GT_STUDENT.

      LOOP AT GT_STUDENT INTO GS_STUDENT.

        MOVE-CORRESPONDING GS_STUDENT TO GS_SAVE.

        APPEND GS_SAVE TO GT_SAVE.

      ENDLOOP.



      MODIFY ZEDT09_001 FROM TABLE GT_SAVE.



      IF SY-SUBRC = 0.

        MESSAGE '####' TYPE 'I'.

      ELSE.

        MESSAGE '####' TYPE 'I'.

      ENDIF.

  ENDCASE.



ENDMODULE.