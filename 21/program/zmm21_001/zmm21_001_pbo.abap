
*&---------------------------------------------------------------------*

*&  Include           ZMM21_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR '100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR '200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  MODI_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*&  ## ## # ##/## ## ## ##

*&  - ##/## ### ## ## ##

*&  - ### ####(KTOKK)# ## ## ## ##

*&---------------------------------------------------------------------*




MODULE MODI_SCREEN OUTPUT.



  "------------------------------------------------------------

  " Selection Screen # # ## ### ##

  "------------------------------------------------------------

  gv_ktokk = p_ktokk.    "### ####

  gv_bukrs = p_bukrs.    "####



  "### ## ## ##

  PERFORM auto_calculate_max_lifnr.





  "------------------------------------------------------------

  " ## ## ## ##

  "------------------------------------------------------------

  LOOP AT SCREEN.



    "----------------------------------------------------------

    " ##### ## ## ### ###

    "----------------------------------------------------------

    IF screen-name = 'GV_NAME1' OR screen-name = 'GV_LAND1' OR

       screen-name = 'GV_STCD1' OR screen-name = 'GV_STCD2' OR

       screen-name = 'GV_STRAS' OR screen-name = 'GV_LOEVM' OR

       screen-name = 'GV_AKONT' OR screen-name = 'GV_ZTERM' OR

       screen-name = 'GV_EKORG' OR screen-name = 'GV_EKGRP' OR

       screen-name = 'GV_WAERS' OR screen-name = 'GV_MWSKZ'.



      screen-input = 0.   "### ## ##



    ENDIF.



    "----------------------------------------------------------

    " ## ## #### ##

    "----------------------------------------------------------

    IF screen-name = 'GV_KTOKK' OR

       screen-name = 'GV_BUKRS' OR

       screen-name = 'GV_LIFNR'.



      screen-input = 0.   "#### / #### / ##### ##



    ENDIF.



    "----------------------------------------------------------

    " ## ##(E)# ## ## ## ##

    "----------------------------------------------------------

    IF gv_mode = 'E'.     "Edit Mode



      IF screen-name = 'GV_NAME1' OR screen-name = 'GV_LAND1' OR

         screen-name = 'GV_STCD1' OR screen-name = 'GV_STCD2' OR

         screen-name = 'GV_STRAS' OR screen-name = 'GV_LOEVM' OR

         screen-name = 'GV_AKONT' OR screen-name = 'GV_ZTERM' OR

         screen-name = 'GV_EKORG' OR screen-name = 'GV_EKGRP' OR

         screen-name = 'GV_WAERS' OR screen-name = 'GV_MWSKZ'.



        screen-input = 1.   "## ##



      ENDIF.

    ENDIF.



    "----------------------------------------------------------

    " ####(STCD1) ## ## ##

    "----------------------------------------------------------

    IF screen-name = 'STCD1'

    OR screen-name = 'GV_STCD1'.



      screen-active = 0.   "## ##



    ENDIF.



    "----------------------------------------------------------

    " ##### ###/#### ## ##

    "----------------------------------------------------------

    IF p_ktokk = '3000'.          "## + ##### ##

      IF screen-name = 'STCD1'

      OR screen-name = 'STCD2'

      OR screen-name = 'GV_STCD1'

      OR screen-name = 'GV_STCD2'.



        screen-active = 1.        "## ##



      ENDIF.



    ELSEIF p_ktokk = '2000'.      "####/##### ###

      IF screen-name = 'STCD1'        "### ##

      OR screen-name = 'STCD2'

      OR screen-name = 'GV_STCD1'     "## ##

      OR screen-name = 'GV_STCD2'.



        screen-active = 0.        "## ##



      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.