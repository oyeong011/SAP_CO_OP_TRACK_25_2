
*&---------------------------------------------------------------------*

*&  Include           ZWORK04_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA LV_ANSWER.



  CASE OK_CODE.

    WHEN 'SAVE'.

      " ### ###

      CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

          TEXT_QUESTION               = '##### ## ########?'

         TEXT_BUTTON_1               = 'YES'

         ICON_BUTTON_1               = '##'

         TEXT_BUTTON_2               = 'NO'

         ICON_BUTTON_2               = '##'

         DISPLAY_CANCEL_BUTTON       = 'X'

       IMPORTING

         ANSWER                      = LV_ANSWER.



      IF LV_ANSWER = '1'.

        MODIFY ZTCURR04 FROM TABLE GT_ZTCURR04.



        IF SY-SUBRC = 0.

          MESSAGE '####' TYPE 'I'.

        ELSE.

          MESSAGE '####' TYPE 'I'.

        ENDIF.

      ELSE.

        MESSAGE '#######.' TYPE 'I'.

      ENDIF.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.