
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  MODI_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODI_SCREEN OUTPUT.



    gv_ktokk = p_ktokk. "##### ### ## ## ## #### ##

    gv_bukrs = p_bukrs.



    PERFORM auto_calculate_max_lifnr.



  LOOP AT SCREEN.

    "#### ## ## ## ## # ## #####.

    IF screen-name = 'GV_NAME1' or screen-name = 'GV_LAND1' or

       screen-name = 'GV_STCD1' or screen-name = 'GV_STCD2' or screen-name = 'GV_STRAS' or

       screen-name = 'GV_LOEVM' or screen-name = 'GV_AKONT' or screen-name = 'GV_ZTERM' or

       screen-name = 'GV_EKORG' or screen-name = 'GV_EKGRP' or screen-name = 'GV_WAERS' or

       screen-name = 'GV_MWSKZ'.



      screen-input = 0.



    ENDIF.



    "### ### ## ###

    IF screen-name = 'GV_KTOKK' or screen-name = 'GV_BUKRS' or screen-name = 'GV_LIFNR'.

      screen-input = 0. "## ###

    ENDIF.



    "ALV# ADD### ### ## ## #### ####.

    IF gv_mode = 'E'.



      IF screen-name = 'GV_NAME1' or screen-name = 'GV_LAND1' or

         screen-name = 'GV_STCD1' or screen-name = 'GV_STCD2' or screen-name = 'GV_STRAS' or

         screen-name = 'GV_LOEVM' or screen-name = 'GV_AKONT' or screen-name = 'GV_ZTERM' or

         screen-name = 'GV_EKORG' or screen-name = 'GV_EKGRP' or screen-name = 'GV_WAERS' or

         screen-name = 'GV_MWSKZ'.



      screen-input = 1.

      ENDIF.

    ENDIF.



    "#### ### (##)

    IF screen-name = 'STCD1'     "###1

    OR screen-name = 'GV_STCD1'.    "IO ## 1



      screen-active = 0. "##



    ENDIF.



    "###### 3000# ## ####, ##### ###

    IF p_ktokk = '3000'.

      IF screen-name = 'STCD1'      "###1

      OR screen-name = 'STCD2'     "###2

      OR screen-name = 'GV_STCD1'    "IO ## 1

      OR screen-name = 'GV_STCD2'.   "IO ## 2



        screen-active = 1. "###



      ENDIF.

    "###### 2000## ####, ##### ## ### ##.

    ELSEIF p_ktokk = '2000'.

      IF screen-name = 'STCD1'      "###1

      OR screen-name = 'STCD2'     "###2

      OR screen-name = 'GV_STCD1'    "IO ## 1

      OR screen-name = 'GV_STCD2'.   "IO ## 2



        screen-active = 0. "# ###

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.