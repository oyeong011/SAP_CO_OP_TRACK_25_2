
"====================================================================="

include structure
ZWORK11_001_PAI
.

"====================================================================="

MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'SAVE'.

      DATA LV_ANSWER TYPE C.

      CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

          TITLEBAR             = '## ##'

          TEXT_QUESTION        = '### ## # ######?'

          TEXT_BUTTON_1        = '#'(001)

          ICON_BUTTON_1        = 'ICON_SAVE'

          TEXT_BUTTON_2        = '###'(002)

          ICON_BUTTON_2        = 'ICON_CANCEL'

          DEFAULT_BUTTON       = '1'

          DISPLAY_CANCEL_BUTTON = ' '

        IMPORTING

          ANSWER               = LV_ANSWER.



      CASE LV_ANSWER.

        WHEN '1'.

          PERFORM SAVE_DATA.

          MESSAGE '#######.' TYPE 'S'.

        WHEN '2'.

          MESSAGE '######.' TYPE 'E'.

      ENDCASE.



    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.



    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.