
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  DATA: LV_ANSWER TYPE C.



  CASE OK_CODE.

    WHEN 'SAVE'.



      " 1. ## ## ## ##

      CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

          TITLEBAR              = '### ##'              " ### ##

          TEXT_QUESTION         = '### ### ########?' " ## ##

          TEXT_BUTTON_1         = '#'

          TEXT_BUTTON_2         = '###'

          DEFAULT_BUTTON        = '1'                       " ## ## # ## ##

          DISPLAY_CANCEL_BUTTON = ' '                       " ## ## ##

        IMPORTING

          ANSWER                = LV_ANSWER.                " ### ## # ##



      " 2. #### '#(1)'# ### ## ## ## ##

      IF LV_ANSWER = '1'.

        PERFORM SAVE_DATA.

      ELSE.

        " '###'# ### ## ## # ## ### ###

        MESSAGE '### #######.' TYPE 'S'.

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

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.