
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_022_PAI

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

      gs_student-zcode = 'SSU-30'.

      gs_student-zpernr = '0000000030'.

      gs_student-zkname = '###'.

      gs_student-zename = 'SIU'.

      gs_student-zgender = 'M'.

      APPEND gs_student TO gt_student.



    WHEN 'SAVE'.

      DATA : gs_save LIKE zedt07_001.

      DATA : gt_save LIKE TABLE OF gs_save.



      LOOP AT gt_student INTO gs_student.

        MOVE-CORRESPONDING gs_student TO gs_save.

        APPEND gs_save TO gt_save.

      ENDLOOP.



      MODIFY zedt07_001 FROM TABLE gt_save.



      IF  sy-subrc = 0.

        MESSAGE '####' TYPE 'I'.

      ELSE.

        MESSAGE '####' TYPE 'I'.

      ENDIF.

  ENDCASE.



ENDMODULE.