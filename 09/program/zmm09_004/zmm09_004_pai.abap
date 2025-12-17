
*&---------------------------------------------------------------------*

*&  Include           ZMM09_004_PAI

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

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  TABSTRIP-ACTIVETAB = OK_CODE.



  CASE OK_CODE.

    WHEN 'SIMU'. "#####

      PERFORM SIMULATION_BALANCE.

      CLEAR : OK_CODE.



    WHEN 'CREATE_IV'. "#### ##

      PERFORM SAVE_INVOICE.

      CLEAR : OK_CODE.





  ENDCASE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  HANDLE_TAXCODE_CHANGE  INPUT

*&---------------------------------------------------------------------*




MODULE HANDLE_TAXCODE_CHANGE INPUT.

  IF OK_CODE = 'CHTAX'.

    PERFORM RECALCULATE_ITEMS_BY_TAXCODE.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  HANDLE_ZTERM_CHANGE  INPUT

*&---------------------------------------------------------------------*




MODULE HANDLE_ZTERM_CHANGE INPUT.

  IF OK_CODE = 'CHTERM'.

    PERFORM RECALCULATE_DUE_DATE.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  TEST  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE CHANGE_RMWWR INPUT.

  DATA : LV_TOTAL_SUM TYPE P DECIMALS 2.





  IF GF_RMWWR >= 0. "## ##

    LV_TOTAL_SUM = 0.

    LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

      LV_TOTAL_SUM = LV_TOTAL_SUM + GS_ITEM_ALV-DBMTR.

    ENDLOOP.



    "### ###

    GF_BALANCE = GF_RMWWR - LV_TOTAL_SUM.



  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'CANCEL'.

      DATA : LV_CNT TYPE I.

      DATA : LT_DECISION LIKE TABLE OF GS_CANCEL_DEC.

      DATA : P_SUBRC TYPE I,

             P_MATNAME LIKE ZMARA09-ZMATNAME,

             P_REMAIN TYPE MENGE_D.





      "### ## # ##

      LOOP AT GT_ITEM_ALV_200 INTO GS_ITEM_ALV_200 WHERE LV_CHECK = 'X'.

         LV_CNT = LV_CNT + 1.

      ENDLOOP.



      IF LV_CNT EQ 0.

        MESSAGE '### #### ## ## ######.' TYPE 'I'.

        EXIT.

      ENDIF.



      "## ## BELNR# ##### ##

      PERFORM CHECK_BELNR CHANGING P_SUBRC.

      IF P_SUBRC = 1.

        MESSAGE '# ## ### ####(BELNR)# ### # ####.' TYPE 'I'.

        EXIT.

      ENDIF.



      PERFORM DELETE_DATA.






*      "###### ##

*      PERFORM VALIDATE_CANCEL USING P_MATNAME P_REMAIN

*                              CHANGING P_SUBRC.

*

*

*      CASE P_SUBRC.

*        WHEN 3.

*          MESSAGE |## { P_MATNAME } # ## ## #### # ## ### # ####.| TYPE 'I'.

*          RETURN.

*        WHEN 4.

*          MESSAGE |## { P_MATNAME } # ## { P_REMAIN }## ### # ####.| TYPE 'E'.

*          RETURN.

*        WHEN 0. "####

*          "##/## ## ##

*          PERFORM DETERMINE_CANCEL_TYPE

*          USING GT_ITEM_ALV_200

*          CHANGING LT_DECISION.

*

**        CLEAR : GS_CANCEL_DEC.

**        LOOP AT LT_DECISION INTO GS_CANCEL_DEC.

**          IF GS_CANCEL_DEC-IS_FULL = ABAP_TRUE. "####

**            PERFORM PROCESS_FULL_REVERSAL USING GS_CANCEL_DEC-BELNR GS_CANCEL_DEC-GJAHR.

**          ELSE. "####

**            PERFORM PROCESS_PART_REVERSAL USING GS_CANCEL_DEC-BELNR GS_CANCEL_DEC-GJAHR.

**          ENDIF.

**        ENDLOOP.

*      " LEAVE TO SCREEN 0.

*      ENDCASE. "P_SUBRC








  ENDCASE. "OK_CODE



ENDMODULE.