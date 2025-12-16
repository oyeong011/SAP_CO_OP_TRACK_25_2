
*&---------------------------------------------------------------------*

*&  Include           ZEDR21_022_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE ok_code.

    WHEN 'BACK' or 'CANC'.

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

  CASE ok_code.

    WHEN 'APND'.

      CLEAR gs_student.

      gs_student-zPERNR21 = 'SSU-30'.

      gs_student-zCODE21 = '0000000030'.

      gs_student-zkname21 = '###'.

      gs_student-zename21 = 'SIU'.

      gs_student-zgUBUN21 = 'M'.

      APPEND gs_student TO gt_student.



    WHEN 'SAVE'.

      DATA : GS_DB LIKE ZEDT21_001.

      DATA : GT_DB LIKE TABLE OF GS_DB.



      MOVE-CORRESPONDING GS_STUDENT TO GS_DB.



      MODIFY zedt21_001 FROM TABLE gt_DB.

  ENDCASE.



ENDMODULE.