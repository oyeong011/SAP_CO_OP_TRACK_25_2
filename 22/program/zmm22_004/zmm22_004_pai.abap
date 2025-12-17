
*&---------------------------------------------------------------------*

*&  Include           ZMM22_004_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



DATA: lv_result TYPE c.



  " 1. ##### #(110)# ## # -> ## ## ##

  IF GV_SUB_DYNNR = '0110'.

    GS_RBKP-RMWWR = ZRBKP_22-RMWWR.

    GS_RBKP-MWSKZ = ZRBKP_22-MWSKZ.

    GS_RBKP-WMWST = ZRBKP_22-WMWST.

    GS_RBKP-BLDAT = ZRBKP_22-BLDAT.

    GS_RBKP-ZTERM = ZRBKP_22-ZTERM.



  " 2. ## #(120)# ## # -> ##### ##

  ELSEIF GV_SUB_DYNNR = '0120'.

    ZRBKP_22-RMWWR = GS_RBKP-RMWWR.

    ZRBKP_22-MWSKZ = GS_RBKP-MWSKZ.

    ZRBKP_22-WMWST = GS_RBKP-WMWST.

    ZRBKP_22-BLDAT = GS_RBKP-BLDAT.

    ZRBKP_22-ZTERM = GS_RBKP-ZTERM.

  ENDIF.

  " ====================================================================



  " 3. ## ## ###

  GV_CALC_FLAG = 'X'.



  CASE OK_CODE.



    WHEN 'TAB1'. " [#####] # ##

      GV_SUB_DYNNR = '0110'.

      TS_INFO-ACTIVETAB = 'TAB1'.



      " ## ## ### #### ##### ### #### ###

      PERFORM CALCULATE_BALANCE.



    WHEN 'TAB2'. " [##] # ##

      GV_SUB_DYNNR = '0120'.

      TS_INFO-ACTIVETAB = 'TAB2'.



      " [## ##] ## #### ### ### 0## ##!

      BALANCE = 0.

      " (##### #### ###### ##)

      " ICON = '@0A@'.



    " -----------------------------------------------------------

    " [##] (## ### #### ##)

    " -----------------------------------------------------------

    WHEN '' OR 'ENTER'.

      IF GV_SUB_DYNNR = '0110'.

        IF ZRBKP_22-MWSKZ IS NOT INITIAL.

          PERFORM APPLY_HEADER_TAX.

        ENDIF.

        IF ZRBKP_22-ZTERM IS NOT INITIAL.

          PERFORM CALC_DUEDATE.

        ENDIF.

        " ## ## ## ## ##

        PERFORM CALCULATE_BALANCE.

      ENDIF.



    " -----------------------------------------------------------

    " [#####] (## ##)

    " -----------------------------------------------------------

    WHEN 'SIMU'.

      PERFORM CALCULATE_BALANCE. " ## # ###

      PERFORM CHECK_BASIC_DATA CHANGING lv_result.

      IF lv_result = 'S'.

        MESSAGE '##### ##: ### 0###.' TYPE 'S'.

      ELSE.

        MESSAGE '##### ##: ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.



    " -----------------------------------------------------------

    " [## ##] (## ##)

    " -----------------------------------------------------------

    WHEN 'CREATE'.

      PERFORM CALCULATE_BALANCE. " ## # ###

      PERFORM CHECK_BASIC_DATA CHANGING lv_result.

      IF lv_result = 'S'.

        PERFORM CHECK_STRICT_DATA CHANGING lv_result.

        IF lv_result = 'S'.

          PERFORM SAVE_DATA.

        ELSE.

          MESSAGE '## ##: ## ###(##,####,##)# #####.' TYPE 'S' DISPLAY LIKE 'E'.

        ENDIF.

      ELSE.

        MESSAGE '## ##: ### ## ####.' TYPE 'S' DISPLAY LIKE 'E'.

      ENDIF.



  ENDCASE.



  CLEAR OK_CODE.

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




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'CANCEL'.

      PERFORM CANCEL_LINE.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND2  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND2 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.