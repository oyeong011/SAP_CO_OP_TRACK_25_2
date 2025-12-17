
*&---------------------------------------------------------------------*

*&  Include           ZMM09_002_PAI

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

  CASE OK_CODE.

    WHEN 'ADD_ITEM'. "####

      CLEAR : GS_ITEM.

      DATA : LV_MAX TYPE ZEKPO_09-EBELP VALUE 0.



      LOOP AT GT_ITEM INTO DATA(LS_LINE).

        IF LS_LINE-EBELP > LV_MAX.

          LV_MAX = LS_LINE-EBELP.

        ENDIF.

      ENDLOOP.

      GS_ITEM-EBELP = LV_MAX + 10.

    " GS_ITEM-EBELP = ( LINES( GT_ITEM ) + 1 ) * 10. "## 10# ##



      "##, #### ###

      SELECT SINGLE WAERS MWSKZ

      FROM ZLFM1_09

      INTO ( GS_ITEM-WAERS, GS_ITEM-MWSKZ )

      WHERE LIFNR = P_LIFN_C.



      APPEND GS_ITEM TO GT_ITEM.



    WHEN 'DEL_ITEM'.  "####

      LOOP AT GT_ITEM INTO GS_ITEM.

        IF GS_ITEM-MARK = 'X'.

          DELETE GT_ITEM INDEX SY-TABIX.

        ENDIF.

      ENDLOOP.



    WHEN 'CREATE_PO'. "PO##

      "# ### ####

      IF GT_ITEM IS INITIAL.

        MESSAGE '### ### ######' TYPE 'I'.

        RETURN.

      ENDIF.



      "PO##, ##, ###, ###, ####

      LOOP AT GT_ITEM INTO GS_ITEM.

        IF GS_ITEM-MENGE IS INITIAL

        OR GS_ITEM-STPRS IS INITIAL

        OR GS_ITEM-PRDAT IS INITIAL

        OR GS_ITEM-WERKS IS INITIAL

        OR GS_ITEM-LGORT IS INITIAL.

        MESSAGE '### ### ######' TYPE 'I'.

        RETURN .



        ENDIF.

      ENDLOOP.



      PERFORM SAVE_DATA.

      LEAVE TO SCREEN 0.



  ENDCASE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  VALIDATION_MATNR  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE VALIDATION_MATNR INPUT.

  DATA : LV_MTART LIKE ZMARA09-MTART. "####



  IF GS_ITEM-MATNR IS INITIAL.

    MESSAGE '##### ########' TYPE 'E'.

  ELSE.

    DATA : LV_MATNR TYPE ZEKPO_09-MATNR.

    LV_MATNR = GS_ITEM-MATNR.



    "#### 0## ###

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT = LV_MATNR

      IMPORTING

        OUTPUT = GS_ITEM-MATNR.



    "##### # # ## ## ####

    SELECT SINGLE ZMATNAME MEINS MTART

    FROM ZMARA09

    INTO ( ZMATNAME, MEINS, LV_MTART )

    WHERE ZMATNR = GS_ITEM-MATNR.




*    SELECT SINGLE ZMATNAME STPRS MEINS

*    FROM ZMARA09

*    INTO ( ZMATNAME, STPRS, MEINS )

*    WHERE ZMATNR = GS_ITEM-MATNR.






    IF SY-SUBRC <> 0.

      MESSAGE '#### ## #######.' TYPE 'E'.

    ENDIF.



    "### (####)

    IF LV_MTART = 'Z001'. "###_#####

      IF GS_ITEM-PSTYP IS INITIAL.

        MESSAGE '###(Z001)# ########. ##### L# #######.' TYPE 'I'.

      ENDIF.



      GS_ITEM-PSTYP = 'L'.

    ENDIF.



    "#### ####

    GS_ITEM-MAKTX = ZMATNAME.




*    GS_ITEM-STPRS = STPRS.




    GS_ITEM-MEINS = MEINS.



    "## ### ##

    MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  VALIDATION_PRDAT  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE VALIDATION_PRDAT INPUT.

  IF GS_ITEM-PRDAT IS INITIAL.

    MESSAGE '#### ########' TYPE 'E'.

  ELSE.

    IF GS_ITEM-PRDAT < P_BEDAT.

      MESSAGE '#### ##### ### #### ###.' TYPE 'E'.

    ENDIF.



   "## ### ##

    MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  VALIDATION_WERKS  INPUT

*&---------------------------------------------------------------------*




MODULE VALIDATION_WERKS INPUT.



  IF GS_ITEM-WERKS IS INITIAL.

    MESSAGE '#### ########' TYPE 'E'.

  ELSE.

    SELECT SINGLE WERKS

    FROM ZMARA09

    INTO GS_ITEM-WERKS

    WHERE WERKS = GS_ITEM-WERKS

    AND   ZMATNR = GS_ITEM-MATNR.



    IF SY-SUBRC <> 0.

      MESSAGE '### #### ## ### #### ## ####. ##/### ### #####.' TYPE 'E'.

    ENDIF.






*    IF SY-SUBRC <> 0.

*      MESSAGE '#### ## ######' TYPE 'E'.

*    ENDIF.






    "## ### ##

    MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

  ENDIF.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  VALIDATION_LGORT  INPUT

*&---------------------------------------------------------------------*




MODULE VALIDATION_LGORT INPUT.

  DATA : BEGIN OF LS_CHECK,

    ZMATNR LIKE ZMARA09-ZMATNR, "####

    WERKS LIKE ZMARA09-WERKS,   "#####

    LGORT LIKE ZMARA09-LGORT,   "####

  END OF LS_CHECK.



  IF GS_ITEM-WERKS IS INITIAL OR GS_ITEM-LGORT IS INITIAL.

    MESSAGE '### # ##### #####' TYPE 'E'.

  ELSE.

     SELECT SINGLE ZMATNR WERKS LGORT

     FROM ZMARA09

     INTO CORRESPONDING FIELDS OF LS_CHECK

     WHERE ZMATNR = GS_ITEM-MATNR

     AND WERKS = GS_ITEM-WERKS

     AND LGORT = GS_ITEM-LGORT.



    IF SY-SUBRC <> 0.

      MESSAGE '## ### ### ##### ####' TYPE 'E'.

    ENDIF.



    "## ### ##

    MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  FILL_MENGE  INPUT

*&---------------------------------------------------------------------*




MODULE FILL_MENGE INPUT.

  IF GT_ITEM IS NOT INITIAL.

    MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  HANDLE_MARK  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE HANDLE_MARK INPUT.

  MODIFY GT_ITEM FROM GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.

ENDMODULE.