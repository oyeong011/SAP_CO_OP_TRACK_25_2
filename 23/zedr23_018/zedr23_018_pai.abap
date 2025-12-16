
*&---------------------------------------------------------------------*

*&  Include           ZEDR23_018_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'APND'.

      CLEAR : GS_STUDENT.

      "APPEND ## ##.

      "GS_STUDENT-ZCODE = 'SSU-30'.

      APPEND GS_STUDENT TO GT_STUDENT.



    WHEN 'SAVE'.

      MODIFY ZEDT23_001 FROM TABLE GT_STUDENT.

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