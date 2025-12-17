
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_030_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE GV_OKCODE.

    WHEN C_BACK OR C_CANC.

      LEAVE TO SCREEN 0.

    WHEN C_EXIT.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  GET_ACTIVE_TAB_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE GET_ACTIVE_TAB_0100 INPUT.

  " HEADER # ##

  IF GV_OKCODE CP 'FC_HEADER_TAB*'.

    GC_TABSTRIP_HEADER-ACTIVETAB = GV_OKCODE.

  ENDIF.



  " ITEM # ##

  IF GV_OKCODE CP 'FC_ITEM_TAB*'.

    GC_TABSTRIP_ITEM-ACTIVETAB = GV_OKCODE.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE GV_OKCODE.

    WHEN 'SIMU'.

      PERFORM GET_SIMU_DATA.

    WHEN 'REFR'.

    WHEN 'CLER'.

      PERFORM CLEAR_ALV.

    WHEN 'TAX'.

      IF GV_TAX_CHECK = 'X'.

        PERFORM CALCULATE_WITH_TAX.

      ELSEIF GV_TAX_CHECK = ' '.

        PERFORM CALCULATE_WITHOUT_TAX.

      ENDIF.

    WHEN 'ENTR'.

      PERFORM REFRESH_BALANCE_DATA.

    WHEN 'POST'.

      PERFORM POST_DATA.

      PERFORM POST_FI_DATA.

    WHEN 'CACL'.

      PERFORM POST_CANCEL_DATA.

      PERFORM POST_CANCEL_FI_DATA.

    WHEN 'FIDC'.

      IF GS_HEADER_100-BELNR IS INITIAL.

        MESSAGE 'MY DOCUMENT## ##### ### ## # ###' TYPE 'S' DISPLAY LIKE 'E'.

        EXIT.

      ELSE.

        PERFORM GET_FI_DATA.

        PERFORM MODIFY_FI_DATA.

        CALL SCREEN 0500.

      ENDIF.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  PAI_TABLE_CONTROL_0400  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE PAI_TABLE_CONTROL_0400 INPUT.

  MODIFY GT_SIMU FROM GS_SIMU INDEX TC_SIMU-CURRENT_LINE.

ENDMODULE.