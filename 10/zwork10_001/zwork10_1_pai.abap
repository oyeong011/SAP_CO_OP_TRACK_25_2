
*&---------------------------------------------------------------------*

*&  Include           ZWORK10_1_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA: LV_VALID TYPE C.



  " ALV Grid #### ### ##

  CALL METHOD GC_GRID->CHECK_CHANGED_DATA

    IMPORTING

      E_VALID = LV_VALID.

  IF LV_VALID IS NOT INITIAL.

    CASE OK_CODE.

      WHEN 'SAVE'.

        DATA: LV_ANSWER TYPE C LENGTH 1.

        CALL FUNCTION 'POPUP_TO_CONFIRM'

          EXPORTING

            TITLEBAR      = '## # # ######'




*           DIAGNOSE_OBJECT             = ' '




            TEXT_QUESTION = '## #####?'

            TEXT_BUTTON_1 = '#(##)'(001)

            ICON_BUTTON_1 = 'ICON_SYSTEM_SAVE'

            TEXT_BUTTON_2 = '##(##)'(002)

            ICON_BUTTON_2 = 'ICON_SYSTEM_CANCEL'




*           DEFAULT_BUTTON              = '1'

*           DISPLAY_CANCEL_BUTTON       = 'X'

*           USERDEFINED_F1_HELP         = ' '

*           START_COLUMN  = 25

*           START_ROW     = 6

*           POPUP_TYPE    =

*           IV_QUICKINFO_BUTTON_1       = ' '

*           IV_QUICKINFO_BUTTON_2       = ' '




          IMPORTING

            ANSWER        = LV_ANSWER




*       TABLES

*           PARAMETER     =

*       EXCEPTIONS

*           TEXT_NOT_FOUND              = 1

*           OTHERS        = 2




          .

        IF SY-SUBRC <> 0.




* Implement suitable error handling here




        ENDIF.

        CASE LV_ANSWER.

          WHEN 1.

            " ## ##

            PERFORM SAVE.

          WHEN 2.

            EXIT.

          WHEN OTHERS.

        ENDCASE.



    ENDCASE.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'CANCLE' OR 'BACK'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'SAVE'.

      PERFORM SAVE.

  ENDCASE.

ENDMODULE.