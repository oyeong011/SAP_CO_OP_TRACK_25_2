
*&---------------------------------------------------------------------*

*&  Include           ZMM02_004_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA: LV_VALID TYPE C. "### ## ### ##

  CASE OK_CODE.

    WHEN 'POST'.

      CALL METHOD GC_GRID->CHECK_CHANGED_DATA "ALV# ## # ### #### ##

        IMPORTING

          E_VALID = LV_VALID.

      READ TABLE GT_PO WITH KEY ZCHECK = 'X' TRANSPORTING NO FIELDS.

      IF SY-SUBRC = 0.

        GV_SIMUL = 0.

        PERFORM SIMULATION.

        IF GV_SIMUL = 0.

          PERFORM POST_PO.

          MODIFY ZRBKP_02 FROM TABLE GT_RBKP.

          MODIFY ZRSEG_02 FROM TABLE GT_RSEG.

          IF SY-SUBRC = 0.

            MESSAGE '####' TYPE 'S'.

            DELETE GT_PO WHERE ZCHECK = 'X'.

            PERFORM GET_PO.

            PERFORM REFRESH USING GC_GRID.

          ELSE.

            MESSAGE '####' TYPE 'I' DISPLAY LIKE 'E'.

            EXIT.

          ENDIF.

        ENDIF.

      ENDIF.

    WHEN 'MDMW'.

      IF G_MWSKZ IS NOT INITIAL AND G_MWSKZ <> G_MWSKZ_OLD.



        LOOP AT GT_PO INTO GS_PO.

          GS_PO-MWSKZ = G_MWSKZ.   " ## ### ### ####

          PERFORM CALCULATE_TAX CHANGING GS_PO.

          MODIFY GT_PO FROM GS_PO.

        ENDLOOP.



        PERFORM REFRESH USING GC_GRID.

        G_MWSKZ_OLD = G_MWSKZ.

        IF G_CALTAX = 'X'.

          PERFORM CAL_ALL_TAX CHANGING G_WMWST.

        ENDIF.

        PERFORM CAL_SUM.

      ENDIF.

    WHEN 'ENTER' OR ''. "## ###, ## ## # ###



      IF GC_GRID IS NOT INITIAL.

        CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

      ENDIF.

      IF G_CALTAX = 'X'.

        PERFORM CAL_ALL_TAX CHANGING G_WMWST.

      ENDIF.

      PERFORM CAL_SUM.

    WHEN 'SIMUL'.

      GV_SIMUL = 0.

      PERFORM SIMULATION.

      IF GV_SIMUL = 0.

        MESSAGE '##### ##! ### ### # ####.' TYPE 'I' DISPLAY LIKE 'S'.

      ENDIF.

  ENDCASE.

  CLEAR: OK_CODE, SY-UCOMM.

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




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0300 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.






*&SPWIZARD: INPUT MODULE FOR TS 'TS_HEAD'. DO NOT CHANGE THIS LINE!

*&SPWIZARD: GETS ACTIVE TAB




MODULE TS_HEAD_ACTIVE_TAB_GET INPUT.

  OK_CODE = SY-UCOMM.

  CASE OK_CODE.

    WHEN C_TS_HEAD-TAB1.

      G_TS_HEAD-PRESSED_TAB = C_TS_HEAD-TAB1.

    WHEN C_TS_HEAD-TAB2.

      G_TS_HEAD-PRESSED_TAB = C_TS_HEAD-TAB2.

    WHEN OTHERS.




*&SPWIZARD:      DO NOTHING




  ENDCASE.

ENDMODULE.