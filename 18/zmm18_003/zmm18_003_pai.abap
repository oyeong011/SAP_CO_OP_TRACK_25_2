
*&---------------------------------------------------------------------*

*&  Include           ZMM18_003_PAI

*&---------------------------------------------------------------------*

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

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  "ALV ### ITAB ##(### # ##)

  IF GO_GRID_100 IS NOT INITIAL.

    CALL METHOD GO_GRID_100->CHECK_CHANGED_DATA.

  ENDIF.



  CASE OK_CODE.



    WHEN 'POST'.   "## ##

      IF GF_BUDAT IS INITIAL.

        GF_BUDAT = P_BUDAT.

      ENDIF.

      IF GF_MJAHR IS INITIAL AND GF_BUDAT IS NOT INITIAL.

        GF_MJAHR = GF_BUDAT+0(4). "YYYY

      ENDIF.

      IF GF_BLART IS INITIAL.

        GF_BLART = 'WE'.

      ENDIF.

      PERFORM POST_GR_0100 .

    WHEN 'REFRESH'.

      PERFORM GET_PO_ITEMS.

      PERFORM REFRESH_GRID USING GO_GRID_100.



    WHEN OTHERS.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.



  CASE OK_CODE.



    WHEN 'REFRESH'.

      PERFORM BUILD_GOODS_LIST_0200.

      PERFORM REFRESH_GRID USING GO_GRID_200_L.

    WHEN  'CANCEL'.

      PERFORM CANCEL_GR_0200.



    WHEN OTHERS.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  CHECK_GR_NOW  INPUT   (0100## GR_NOW #####)

*&---------------------------------------------------------------------*




MODULE CHECK_GR_NOW INPUT.



  "TableControl# ### ALV##, ### DATA_CHANGED ##### ### # ######

  "## ## #### ## ### ## # ####.



  IF GS_ITEM-GR_NOW IS NOT INITIAL.



    IF GS_ITEM-GR_NOW <= 0.

      MESSAGE '## ## ### 0## ## ###.' TYPE 'E'.

    ENDIF.



    IF GS_ITEM-GR_NOW > GS_ITEM-GR_REM.

      MESSAGE '#### ##(##)# ######.' TYPE 'E'.

    ENDIF.



  ENDIF.



ENDMODULE.