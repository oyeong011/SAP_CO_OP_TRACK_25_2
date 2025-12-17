
*&---------------------------------------------------------------------*

*&  Include           ZSPLITTER_CONTAINER05_I01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.




*  BREAK-POINT. " back(E) ## ## #, ## ### #### exit_command# ###




  CASE OK_CODE.

    WHEN 'APND'.

      CLEAR : GS_STUDENT.

      GS_STUDENT-ZCODE = 'SSU-30'.

      GS_STUDENT-ZPERNR = '0000000030'.

      GS_STUDENT-ZKNAME = '###'.

      GS_STUDENT-ZENAME = 'M1'.

      GS_STUDENT-ZGENDER = 'F'.

      APPEND GS_STUDENT TO GT_STUDENT.

    WHEN 'SAVE'.

      DATA: LT_DB_STUDENT TYPE TABLE OF ZEDT05_001,

            LS_DB_STUDENT TYPE ZEDT05_001.

      LOOP AT GT_STUDENT INTO GS_STUDENT.

        MOVE-CORRESPONDING GS_STUDENT TO LS_DB_STUDENT.

        APPEND LS_DB_STUDENT TO LT_DB_STUDENT.

      ENDLOOP.

      IF LT_DB_STUDENT IS NOT INITIAL.

        MODIFY ZEDT05_001 FROM TABLE LT_DB_STUDENT.



        IF SY-SUBRC = 0.

          MESSAGE '####' TYPE 'I'.

        ELSE.

          MESSAGE '####' TYPE 'I'.

        ENDIF.

      ENDIF.



  ENDCASE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       #### ##/## ## ## ##

*       back, exit, cancle # ##/## ##

*       ## #### ## ## ##

*       ok_code # ## ## ### ##

*       #### ####/## ## ## ##

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.




*  BREAK-POINT. " Exit command# PAI ## ## #### ## ## ### ##.




  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'. " #### or ##

      LEAVE TO SCREEN 0. " ## #### ##

    WHEN 'EXIT'.        " #### ##

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.