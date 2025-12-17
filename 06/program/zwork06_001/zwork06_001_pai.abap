
*&---------------------------------------------------------------------*

*&  Include           ZWORK06_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  CASE OK_CODE.

    WHEN 'UKURS'.

      " ### ## ## ###.

      DATA: LV_ANSWER TYPE c.



      CALL FUNCTION 'POPUP_TO_CONFIRM'

        EXPORTING

         TITLEBAR                    = '## ##'




*         DIAGNOSE_OBJECT             = ' '




          TEXT_QUESTION               = '## ### ########?'

         TEXT_BUTTON_1               = 'YES'(001)




*         ICON_BUTTON_1               = ' '




         TEXT_BUTTON_2               = 'NO'(002)




*         ICON_BUTTON_2               = ' '




         DEFAULT_BUTTON              = '1'




*         DISPLAY_CANCEL_BUTTON       = 'X'

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

      IF LV_ANSWER = '1'.

        PERFORM SAVE_CHANGED_UKURS.

        MESSAGE '### #######.' TYPE 'S'.

     ELSE.

        MESSAGE '### #######.' TYPE 'S'.

      ENDIF.

    WHEN 'DOWNLOAD'.

      PERFORM DOWNLOAD_TEMPLATE.

      MESSAGE '## #### #######.' TYPE 'S'.

    WHEN 'BACK' OR 'CANCEL' OR 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.