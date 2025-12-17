
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_001_PBO

*&---------------------------------------------------------------------*

*& PBO (Process Before Output) ## ##

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       Screen 100 GUI ## # ### ##

*----------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'ST_100'.

  SET TITLEBAR  'TT_100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       Screen 200 GUI ## # ### ##

*----------------------------------------------------------------------*




MODULE status_0200 OUTPUT.

  SET PF-STATUS 'ST_200'.

  SET TITLEBAR  'TT_200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  INIT_SCREEN_100  OUTPUT

*&---------------------------------------------------------------------*

*       Screen 100 ### # ## ##

*----------------------------------------------------------------------*




MODULE init_screen_100 OUTPUT.

  "## ## # ##

  gv_ktokk = pa_ktokk.

  gv_bukrs = pa_bukrs.



  "## ##### ## ##

  PERFORM calculate_next_lifnr.



  LOOP AT SCREEN.

    "#### ## ## #### (## ## ##)

    CASE screen-name.

      WHEN 'GV_NAME1' OR 'GV_LAND1' OR

           'GV_STCD1' OR 'GV_STCD2' OR 'GV_STRAS' OR

           'GV_LOEVM' OR 'GV_AKONT' OR 'GV_ZTERM' OR

           'GV_EKORG' OR 'GV_EKGRP' OR 'GV_WAERS' OR 'GV_MWSKZ'.

        screen-input = 0.

    ENDCASE.



    "## ## ### ## ## ##

    CASE screen-name.

      WHEN 'GV_KTOKK' OR 'GV_BUKRS' OR 'GV_LIFNR'.

        screen-input = 0.

    ENDCASE.



    "ADD ## ## # ## ### ##

    IF gv_edit_mode EQ 'E'.

      CASE screen-name.

        WHEN 'GV_NAME1' OR 'GV_LAND1' OR

             'GV_STCD1' OR 'GV_STCD2' OR 'GV_STRAS' OR

             'GV_LOEVM' OR 'GV_AKONT' OR 'GV_ZTERM' OR

             'GV_EKORG' OR 'GV_EKGRP' OR 'GV_WAERS' OR 'GV_MWSKZ'.

          screen-input = 1.

      ENDCASE.

    ENDIF.



    "#### ## ##

    CASE screen-name.

      WHEN 'STCD1' OR 'GV_STCD1'.

        screen-active = 0.

    ENDCASE.



    "###### ## ## ##

    CASE pa_ktokk.

      WHEN '3000'.

        "####, ##### ## ##

        CASE screen-name.

          WHEN 'STCD1' OR 'STCD2' OR 'GV_STCD1' OR 'GV_STCD2'.

            screen-active = 1.

        ENDCASE.



      WHEN '2000'.

        "####, ##### ## ##

        CASE screen-name.

          WHEN 'STCD1' OR 'STCD2' OR 'GV_STCD1' OR 'GV_STCD2'.

            screen-active = 0.

        ENDCASE.

    ENDCASE.



    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.