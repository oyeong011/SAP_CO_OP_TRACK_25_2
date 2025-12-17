
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER10_I01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANCLE'.

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

    BREAK-POINT.

    WHEN 'APPEND'.

      CLEAR GS_STUDENT.

      GS_STUDENT-ZCODE = 'SSU-30'.

      GS_STUDENT-ZPERNR = '0000000030'.

      GS_STUDENT-ZKNAME = '###'.

      GS_STUDENT-ZENAME = 'MI'.

      GS_STUDENT-ZGENDER = 'F'.

      APPEND GS_STUDENT TO GT_STUDENT.

    WHEN 'SAVE'.

      MODIFY ZEDT10_001 FROM TABLE GT_STUDENT .

  ENDCASE.



ENDMODULE.