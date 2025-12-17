
*&---------------------------------------------------------------------*

*&  Include           ZCLASS_EVENT10_I01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA: LS_SAVE TYPE ZEDT10_001.

  DATA: LT_SAVE LIKE TABLE OF LS_SAVE.



  CASE OK_CODE.

    WHEN 'SAVE'.

      LOOP AT GT_STUDENT INTO GS_STUDENT.

        MOVE-CORRESPONDING GS_STUDENT TO LS_SAVE.

        APPEND LS_SAVE TO LT_SAVE.

      ENDLOOP.



      MODIFY ZEDT10_001 FROM TABLE LT_SAVE.



      IF SY-SUBRC = 0.

        MESSAGE '####' TYPE 'I'.

      ELSE.

        MESSAGE '####' TYPE 'E'.

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

    WHEN 'EXIT'.

      LEAVE SCREEN.

    WHEN 'CANCLE' OR 'BACK'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.