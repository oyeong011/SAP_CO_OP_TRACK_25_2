
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER19_PAI

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

      GS_STUDENT-ZPERNR = '0000000030'.

      GS_STUDENT-ZKNAME = '###'.

      GS_STUDENT-ZENAME = 'MI'.

      GS_STUDENT-ZGENDER = 'F'.

      APPEND GS_STUDENT TO GT_STUDENT.

    WHEN 'SAVE'.

      MODIFY ZEDT19_0001 FROM TABLE GT_STUDENT. "ZEDT19_0001# #### ##

    WHEN 'BACK' OR 'EXIT' OR 'CANC'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.