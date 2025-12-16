
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_020_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE GV_OKCODE.

    WHEN 'ENTR'.

      PERFORM CHECK_SCREEN_VALDATION.

      PERFORM UPDATE_SCREEN.

    WHEN 'POST'.

      PERFORM CHECK_MANDOTORY.

      IF GV_CHECK_FLAG = ABAP_FALSE.

        MESSAGE '### #### ## ### ## ###' TYPE 'S' DISPLAY LIKE 'E'.

      ELSE.

        PERFORM POST_GOODS_RECEIPT.

        PERFORM POST_FI_DOCUMENT.

      ENDIF.

    WHEN 'NEXT'.

      PERFORM GET_NEXT_ITEM.

    WHEN 'PREV'.

      PERFORM GET_PERV_ITEM.

    WHEN 'DELE'.

      PERFORM DELETE_ALV_ITEMS.

    WHEN 'SORT_UP'.

       PERFORM SORT_LINE_UP.

    WHEN 'SORT_DOWN'.

       PERFORM SORT_LINE_DOWN.

    WHEN 'ITEM_OK'.

      PERFORM SET_ITEM_OK_TO_GREEN.

  ENDCASE.



ENDMODULE.




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




MODULE GET_ACTIVE_TAB_0200 INPUT.



  " HEADER # ##

  IF GV_OKCODE CP 'FC_TAB*'.

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

    WHEN 'FIDC'.

      IF GS_HEADER_100-MBLNR IS INITIAL.

        MESSAGE 'MY DOCUMENT## ##### ### ## # ###' TYPE 'S' DISPLAY LIKE 'E'.

      ELSE.

        PERFORM GET_FI_DATA.

        PERFORM MODIFY_FI_DATA.

        CALL SCREEN 0500.

      ENDIF.

    WHEN 'NEXT'.

      PERFORM GET_NEXT_ITEM.

    WHEN 'PREV'.

      PERFORM GET_PERV_ITEM.

    WHEN 'CACL'.

      PERFORM CANCEL_GOODS_ITEMS.

      PERFORM CANCEL_FI_DOCUMENT.

    WHEN 'DELE'.

      PERFORM DELETE_ALV_ITEMS.

    WHEN 'SORT_UP'.

       PERFORM SORT_LINE_UP.

    WHEN 'SORT_DOWN'.

       PERFORM SORT_LINE_DOWN.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  GET_ACTIVE_TAB_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE GET_ACTIVE_TAB_0100 INPUT.

  " HEADER # ##

  IF GV_OKCODE CP 'FC_TAB*'.

    GC_TABSTRIP_HEADER-ACTIVETAB = GV_OKCODE.

  ENDIF.



  " ITEM # ##

  IF GV_OKCODE CP 'FC_ITEM_TAB*'.

    GC_TABSTRIP_ITEM-ACTIVETAB = GV_OKCODE.

  ENDIF.

ENDMODULE.