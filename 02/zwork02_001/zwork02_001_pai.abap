
*&---------------------------------------------------------------------*

*&  Include           ZWORK02_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  DATA: LV_ANSWER TYPE C LENGTH 3.

  CASE: OK_CODE.

    WHEN 'FXRT'.

      "## ## ## ### #

      CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

         TITLEBAR                    = '## ##'




*         DIAGNOSE_OBJECT             =




          TEXT_QUESTION               = '##### ## ########?'

         TEXT_BUTTON_1               = 'YES'




*         ICON_BUTTON_1               = ' '




         TEXT_BUTTON_2               = 'NO'




*         ICON_BUTTON_2               = ' '

*         DEFAULT_BUTTON              = '1'




         DISPLAY_CANCEL_BUTTON       = ''




*         USERDEFINED_F1_HELP         = ' '

*         START_COLUMN                = 25

*         START_ROW                   = 6

*         POPUP_TYPE                  =

*         IV_QUICKINFO_BUTTON_1       = ' '

*         IV_QUICKINFO_BUTTON_2       = ' '




       IMPORTING

         ANSWER                      = LV_ANSWER




*       TABLES

*         PARAMETER                   =

*       EXCEPTIONS

*         TEXT_NOT_FOUND              = 1

*         OTHERS                      = 2




                .



      IF SY-SUBRC = 0 AND LV_ANSWER = '1'.

        "## ##

        MODIFY ZTCURR02 FROM TABLE GT_TCURR.

        IF SY-SUBRC = 0.

          COMMIT WORK.

          MESSAGE '## ### #######.' TYPE 'S'.

          PERFORM REFRESH.

        ELSE.

          ROLLBACK WORK.

          MESSAGE '## ## ### ######.' TYPE 'E'.

        ENDIF.

      ELSE.

        MESSAGE '#######' TYPE 'I'.

      ENDIF.



      WHEN 'BACK' OR 'EXIT'.

        LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMANT  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMANT INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.