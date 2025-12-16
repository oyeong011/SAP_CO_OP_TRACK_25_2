
*&---------------------------------------------------------------------*

*&  Include           ZWORK21_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'SAVE'.

    "SAVE ## ##

    CALL FUNCTION 'POPUP_TO_CONFIRM'

      EXPORTING

        TITLEBAR              = '## ## ##'

        TEXT_QUESTION          = '##### ## ########?'

        TEXT_BUTTON_1          = 'YES'(001)

        ICON_BUTTON_1          = 'ICON_OKAY'

        TEXT_BUTTON_2          = 'NO'(002)

        ICON_BUTTON_2          = 'ICON_CANCEL'

        DEFAULT_BUTTON         = '1'

        DISPLAY_CANCEL_BUTTON  = ' '

      IMPORTING

        ANSWER                 = LV_ANSWER.



    CASE LV_ANSWER.

      WHEN '1'.  "IF ### '#' ## #,

        "#### FUNCTION ##

        PERFORM SAVE_DATA.

        MESSAGE '#######.' TYPE 'E'.

      WHEN '2'.  " IF ### '##' ## #,

        MESSAGE '## #######.' TYPE 'E'.

    ENDCASE.

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