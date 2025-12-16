
*&---------------------------------------------------------------------*

*&  Include           ZMM09_003_PAI

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

*&      Module  HANDLE_CLICK  INPUT

*&---------------------------------------------------------------------*




MODULE HANDLE_CLICK INPUT.



  DATA LV_LINE TYPE I.

  LV_LINE = LINES( GT_ITEM ).



  " #### ### ###### row ##

  DATA LV_ROW TYPE I.

  LV_ROW = TC_ITEMS-CURRENT_LINE.



  IF LV_ROW > LV_LINE.

    MESSAGE '## #### ## ## ## #####.' TYPE 'I'.

    LEAVE TO SCREEN 100.

  ENDIF.



  MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  CHECK_GR_NOW  INPUT

*&---------------------------------------------------------------------*




MODULE CHECK_GR_NOW INPUT.



  IF GS_ITEM-GR_NOW > GS_ITEM-GR_REM.

    MESSAGE '#### ### ######. ## ## ### ######.' TYPE 'E'.

  ENDIF.



  IF GS_ITEM-GR_NOW <= 0.

    MESSAGE '#### ### #### ###' TYPE 'E'.

  ENDIF.



  IF SY-SUBRC = 0.

    MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA : LV_SUBRC TYPE I.



  CASE OK_CODE.

    WHEN 'POST'. "## ##

      CLEAR : LV_SUBRC.

      PERFORM CHECK_INPUT CHANGING LV_SUBRC.



      IF LV_SUBRC <> 2.

        PERFORM SAVE_DATA.

        LEAVE TO SCREEN 0.

      ENDIF.

  ENDCASE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  DATA : P_SUBRC TYPE I,

         P_MBLNR_NEW TYPE ZMKPF09-MBLNR, "## #### ##

         P_BELNR_NEW TYPE ZBKPF09-BELNR, "## #### ##

         P_AVAIL TYPE MENGE_D,

         P_CURR TYPE MENGE_D,

         LV_CANCELED TYPE C,

         LV_HAS_CANCELED TYPE ABAP_BOOL.



  CASE OK_CODE.

    WHEN 'CANCEL'.

       CLEAR : LV_HAS_CANCELED.



       "## ## ## -> ### ##

       LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

         SELECT SINGLE ZCANCEL_FLAG

         FROM ZMSEG09

         INTO LV_CANCELED

         WHERE MBLNR = GS_HEADER_ALV-MBLNR

         AND   ZEILE = GS_ITEM_ALV-ZEILE

         AND   BWART = '101'.



        IF LV_CANCELED = 'X'.

          LV_HAS_CANCELED = ABAP_TRUE.

          EXIT. "### ### ##

        ENDIF.

       ENDLOOP.



       IF LV_HAS_CANCELED = ABAP_TRUE.

         MESSAGE '## ### ### #### #####.' TYPE 'I'.

         RETURN.

       ENDIF.



       "###### ## ## ## (###)

       PERFORM CANCEL_GOODS  USING    P_MBLNR_NEW P_BELNR_NEW

                             CHANGING P_SUBRC P_AVAIL P_CURR.



       CASE P_SUBRC.

         WHEN 3.

          MESSAGE '### ### ######.' TYPE 'I'.

          RETURN.

         WHEN 4.

          MESSAGE |## ###### { P_CURR } # ### ## { P_AVAIL } # ####, ### #####. | TYPE 'E'.

          RETURN.

         WHEN 0.

        " MESSAGE |#### { P_MBLNR_NEW } (102) ##### #######.| TYPE 'S'.

           MESSAGE |#### { P_MBLNR_NEW } / #### { P_BELNR_NEW } #######| TYPE 'S'.

        " LEAVE TO SCREEN 0.

          SET USER-COMMAND 'REFRESH'.

       ENDCASE.



    WHEN 'BTN_FI'. "FI ##

      DATA : LT_FI_LIST TYPE STANDARD TABLE OF TY_FI_LIST.



      DATA: LV_HAS_CANCELED_2     TYPE ABAP_BOOL VALUE ABAP_FALSE,

            LV_HAS_NOT_CANCELED_2 TYPE ABAP_BOOL VALUE ABAP_FALSE,

            LV_FLAG             TYPE ZMSEG09-ZCANCEL_FLAG.



      CLEAR : LV_HAS_CANCELED_2, LV_HAS_NOT_CANCELED_2, LV_FLAG.



      " ### ### #### ## ##, ## ## ##

      LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

        SELECT SINGLE ZCANCEL_FLAG

        FROM ZMSEG09

        INTO LV_FLAG

        WHERE MBLNR = GS_HEADER_ALV-MBLNR

        AND   ZEILE = GS_ITEM_ALV-ZEILE

        AND   BWART = '101'.



        IF LV_FLAG = 'X'.

          LV_HAS_CANCELED_2 = ABAP_TRUE.

        ELSE.

          LV_HAS_NOT_CANCELED_2 = ABAP_TRUE.

        ENDIF.

      ENDLOOP.



      IF LV_HAS_CANCELED_2 = ABAP_TRUE

     AND LV_HAS_NOT_CANCELED_2 = ABAP_TRUE.

        MESSAGE '### ### #### ## ### ### ### # ####.' TYPE 'I'.

        RETURN.

      ENDIF.





      PERFORM GET_FI_LIST USING GS_HEADER_ALV-MBLNR

                          CHANGING LT_FI_LIST.



      IF LT_FI_LIST IS INITIAL.

         MESSAGE '### ## ### ####.' TYPE 'I'.

         RETURN.

      ENDIF.



      GT_FI_LIST = LT_FI_LIST.



      CALL SCREEN 300 STARTING AT 20 5 ENDING AT 70 10.  "### 300 ##

        "starting at : ### ####(### ###)

        "ending at   : ### ####(### ###)





  ENDCASE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0300  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0300 INPUT.

  CASE OK_CODE.

    WHEN 'EXIT'.

      LEAVE TO SCREEN 0.

  ENDCASE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0400  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0400 INPUT.



  CASE OK_CODE.

    WHEN 'BTN_REV_FI'.

      DATA : LT_REV_BELNR TYPE SORTED TABLE OF ZBKPF09-BELNR WITH UNIQUE KEY TABLE_LINE,

             LV_LINES TYPE I.



      CLEAR : LT_REV_BELNR, LV_LINES.



      "1. ### ## ## ###

      PERFORM GET_REV_BELNR_LIST CHANGING LT_REV_BELNR.



      LV_LINES = LINES( LT_REV_BELNR ).



      IF LV_LINES = 0.

        MESSAGE '### ##### ## # ####.' TYPE 'I'.

        RETURN.

      ELSEIF LV_LINES = 1.

        READ TABLE LT_REV_BELNR INTO GV_SEL_BELNR INDEX 1.

        PERFORM GET_BKPF.

        GV_FI_VIEW_MODE = 'R'. "### ###

        PERFORM GET_BSEG.

        GO_ALV_400->REFRESH_TABLE_DISPLAY( ).



      ELSE.

        "### 300## ##(#: 310)## LT_REV_BELNR# ####

        "###### GV_SEL_BELNR ## # 400 ####

        GT_REV_BELNR = LT_REV_BELNR.



        CALL SCREEN 410 STARTING AT 20 5 ENDING AT 60 15.





      ENDIF.





  ENDCASE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0410  INPUT

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0410 INPUT.

  CASE OK_CODE.

    WHEN 'EXIT'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.