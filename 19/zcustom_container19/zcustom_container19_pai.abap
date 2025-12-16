
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER19_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'SAVE'.

      LOOP AT GT_STUDENT INTO GS_STUDENT.

        MOVE-CORRESPONDING GS_STUDENT TO GS_SAVE.

        APPEND GS_SAVE TO GT_SAVE.

      ENDLOOP.



      MODIFY ZEDT19_0001 FROM TABLE GT_SAVE.



      IF SY-SUBRC = 0.

        MESSAGE '####' TYPE 'I'.

      ELSE.

        MESSAGE '####' TYPE 'I'.

      ENDIF.

    ENDCASE.

ENDMODULE.