
*&---------------------------------------------------------------------*

*&  Include           ZEDR03_017_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'APND'.

      CLEAR GS_STUDENT.

      GS_STUDENT-ZCODE = 'SSU-100'.

      GS_STUDENT-ZPERNR = '0000000100'.

      GS_STUDENT-ZKNAME = '#####'.

      GS_STUDENT-ZENAME = 'GOOD'.

      GS_STUDENT-ZGENDER = 'F'.

      APPEND GS_STUDENT TO GT_STUDENT.

     WHEN 'SAVE'.

       LOOP AT GT_STUDENT INTO GS_STUDENT.

         MOVE-CORRESPONDING GS_STUDENT TO GS_SAVE.

         APPEND GS_SAVE TO GT_SAVE.

       ENDLOOP.



       MODIFY ZEDT03_001 FROM TABLE GT_SAVE.



       IF SY-SUBRC = 0.

         MESSAGE '####' TYPE 'I'.

       ELSE.

         MESSAGE '####' TYPE 'I'.

       ENDIF.

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