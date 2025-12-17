
*&---------------------------------------------------------------------*

*&  Include           ZEDR06_033_USER_COMMAND_PAI

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

      GS_STUDENT-ZCODE = 'SSU-30'.

      GS_STUDENT-ZPERNR = '000000003'.

      GS_STUDENT-ZKNAME = '###'.

      GS_STUDENT-ZENAME = 'MI'.

      GS_STUDENT-ZGENDER = 'F'.

      APPEND GS_STUDENT TO GT_STUDENT.

    WHEN 'SAVE'.

      MODIFY ZEDT06_001 FROM GS_STUDENT.

  ENDCASE.



ENDMODULE.