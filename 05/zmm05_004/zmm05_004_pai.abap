
*&---------------------------------------------------------------------*

*&  Include           ZMM05_004_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

  ENDCASE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  DROPDOWN_CHANGE  INPUT

*&---------------------------------------------------------------------*

*       #### ## # ## ## (## ##)

*----------------------------------------------------------------------*




MODULE DROPDOWN_CHANGE INPUT.

  " #### ## ## ### ##

  IF GV_SEL_TYPE = 'GR' AND GT_ITEM_GR IS NOT INITIAL.

    GT_ITEM = GT_ITEM_GR.

    PERFORM REFRESH_ALV.

  ELSEIF GV_SEL_TYPE = 'PO' AND GT_ITEM_PO IS NOT INITIAL.

    GT_ITEM = GT_ITEM_PO.

    PERFORM REFRESH_ALV.

  ENDIF.



  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING

      NEW_CODE = 'DUMMY'.



  " ### ## #### ## ##

  CALL METHOD CL_GUI_CFW=>FLUSH.

ENDMODULE.



MODULE USER_COMMAND_0100 INPUT.

  DATA: GV_OK_CODE TYPE SY-UCOMM.



  IF GS_AMOUNT_HEADER-ZAMOUNT IS NOT INITIAL.

    GV_SAVED_ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

  ENDIF.



  GV_OK_CODE = SY-UCOMM.

  CLEAR SY-UCOMM.



  CASE GV_OK_CODE.

    WHEN 'TAB1'.

      TS_INFO-ACTIVETAB = 'TAB1'.

      GV_SUB_DYNNR      = '0101'.

    WHEN 'TAB2'.

      TS_INFO-ACTIVETAB = 'TAB2'.

      GV_SUB_DYNNR      = '0102'.

    WHEN 'SAVE'.

      IF SY-SUBRC = 0.

        PERFORM SAVE_DATA.

        MESSAGE '#######.' TYPE 'S'.

      ENDIF.

    WHEN 'SIMULATE'.

      PERFORM SIMULATE_POSTING.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'DUMMY' OR ''.




*      IF GS_AMOUNT_HEADER-ZAMOUNT IS NOT INITIAL.




        GV_SAVED_ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

        PERFORM CALCULATE_TOTAL_BALANCE.




*      ENDIF.




      PERFORM APPLY_TAX_CHANGE.

      PERFORM UPDATE_TAX_CHANGE.

    WHEN OTHERS.

      " ## ###### ZAMOUNT # ##

      IF GS_AMOUNT_HEADER-ZAMOUNT IS NOT INITIAL.

        GV_SAVED_ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

      ENDIF.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0101  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0101 INPUT.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0102  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0102 INPUT.

  GV_SAVED_ZAMOUNT = GS_AMOUNT_HEADER-ZAMOUNT.

  PERFORM CALCULATE_TOTAL_BALANCE.

ENDMODULE.








*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.



    WHEN 'DELETE'. " [##] ## ## ##

      PERFORM DELETE_INVOICE_DATA.



    WHEN OTHERS.

  ENDCASE.

ENDMODULE.