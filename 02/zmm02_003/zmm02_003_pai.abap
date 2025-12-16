
*&---------------------------------------------------------------------*

*&  Include           ZMM02_003_PAI

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

      READ TABLE GT_PO WITH KEY ZCHECK = 'X' TRANSPORTING NO FIELDS. "### ## ## # ##

      IF SY-SUBRC = 0.

        PERFORM POST_PO.

        MODIFY ZMKPF_02 FROM TABLE GT_MKPF.

        MODIFY ZMSEG_02 FROM TABLE GT_MSEG.

        IF SY-SUBRC = 0.

          MESSAGE '####' TYPE 'I'.

          LOOP AT GT_PO INTO GS_PO WHERE ZCHECK = 'X'.



            GS_PO-OPEN_QTY = GS_PO-OPEN_QTY - GS_PO-MENGE. "## ## - ## ### ##

            GS_PO-MENGE = GS_PO-OPEN_QTY. "## ## ### ###

            GS_PO-ZCHECK = ' '. "#### ##



            IF GS_PO-OPEN_QTY <= 0.

              DELETE GT_PO INDEX SY-TABIX. "## ### #### ##

            ELSE.

              MODIFY GT_PO FROM GS_PO INDEX SY-TABIX. "## #### # #### ##

            ENDIF.

          ENDLOOP.

          PERFORM REFRESH.

        ELSE.

          MESSAGE '####' TYPE 'I' DISPLAY LIKE 'E'.

          EXIT.

        ENDIF.

      ENDIF.

    WHEN ''.

      IF G_BLDAT > G_BUDAT.

        MESSAGE '#### ##### ### # ####.' TYPE 'I' DISPLAY LIKE 'E'.

      ENDIF.

  ENDCASE.

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