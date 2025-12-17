
*&---------------------------------------------------------------------*

*&  Include           ZWORK07_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE ok_code.

    WHEN 'DOWN'.

      DATA lv_answer TYPE c.



    CALL FUNCTION 'POPUP_TO_CONFIRM'

      EXPORTING

        titlebar              = '## ## ##'

        text_question          = '########?'

        text_button_1          = '#'(001)

        icon_button_1          = 'ICON_OKAY'

        text_button_2          = '###'(002)

        icon_button_2          = 'ICON_CANCEL'

        default_button         = '1'

        display_cancel_button  = ' '

      IMPORTING

        answer                 = lv_answer.



    CASE lv_answer.

      WHEN '1'.  " # ##

        PERFORM save_data. " PDF ## ##

        MESSAGE '#######.' TYPE 'S'.

      WHEN '2'.  " ### ##

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

  CASE ok_code.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.



    WHEN 'EXIT'.

      LEAVE PROGRAM.



  ENDCASE.

ENDMODULE.