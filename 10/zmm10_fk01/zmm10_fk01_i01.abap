
*&---------------------------------------------------------------------*

*&  Include           ZMM10_FK01_I01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA: LT_ANSWER TYPE C LENGTH 1.



  CASE OK_CODE.

    WHEN 'SAVE'.

      PERFORM CHECK_REQUIRED_FIELD.




*      IF SY-SUBRC NE 0.

*        MESSAGE '## ## ## ### #' TYPE 'E'.

*      ENDIF.






      CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

          TITLEBAR      = '####'




*         DIAGNOSE_OBJECT             = ' '




          TEXT_QUESTION = '######?'

          TEXT_BUTTON_1 = '#'(001)

          ICON_BUTTON_1 = 'ICON_CONFIRM'

          TEXT_BUTTON_2 = '###'(002)

          ICON_BUTTON_2 = 'ICON_CANCLE'




*         DEFAULT_BUTTON              = '1'

*         DISPLAY_CANCEL_BUTTON       = 'X'

*         USERDEFINED_F1_HELP         = ' '

*         START_COLUMN  = 25

*         START_ROW     = 6

*         POPUP_TYPE    =

*         IV_QUICKINFO_BUTTON_1       = ' '

*         IV_QUICKINFO_BUTTON_2       = ' '




        IMPORTING

          ANSWER        = LT_ANSWER




*       TABLES

*         PARAMETER     =

*       EXCEPTIONS

*         TEXT_NOT_FOUND              = 1

*         OTHERS        = 2




        .

      IF SY-SUBRC <> 0.




* Implement suitable error handling here




      ENDIF.

      IF LT_ANSWER = 1.



        PERFORM SAVE.

        IF SY-SUBRC = 0.

          CALL FUNCTION 'POPUP_TO_INFORM'

            EXPORTING

              TITEL = '####'

              TXT1  = '### ##### ##'

              TXT2  = '.'




*             TXT3  = ' '

*             TXT4  = ' '




            .

        ELSE.

          CALL FUNCTION 'POPUP_TO_INFORM'

            EXPORTING

              TITEL = '####'

              TXT1  = '##### ## ##'

              TXT2  = '.'




*             TXT3  = ' '

*             TXT4  = ' '




            .

        ENDIF.

      ELSE.

        CALL FUNCTION 'POPUP_TO_INFORM'

          EXPORTING

            TITEL = '#### ##'

            TXT1  = '## #######.'

            TXT2  = '.'




*           TXT3  = ' '

*           TXT4  = ' '




          .

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

    WHEN 'BACK' OR 'CANCLE'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN OTHERS.

  ENDCASE.

ENDMODULE.