
*&---------------------------------------------------------------------*

*&  Include           ZMM22_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .



  LOOP AT SCREEN.



    " ## ## # ## BLOCK(C) ## / ## BLOCK(S) ###

    IF P_CRE = 'X'.

      IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = '1'.

        SCREEN-INPUT  = '1'.

      ELSEIF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    " ## ## # ## BLOCK(S) ## / ## BLOCK(C) ###

    IF P_SEL = 'X'.

      IF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = '1'.

        SCREEN-INPUT  = '1'.

      ELSEIF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALID_INPUT .

 " 1) ##(P_SEL='X') ## ### ##

  IF P_SEL = 'X' AND SY-UCOMM = 'ONLI'.



    IF P_LIFN2 IS INITIAL OR P_BUKR2 IS INITIAL OR P_EBELN IS INITIAL.

      MESSAGE '#####/####/PO### #### #####.' TYPE 'E'.

    ENDIF.



    RETURN.

  ENDIF.



  " 2) ##(P_CRE='X') ## ### + ### ##

  IF P_CRE = 'X' AND SY-UCOMM = 'ONLI'.



    "### ##

    IF P_BUKRS IS INITIAL OR P_LIFNR IS INITIAL OR P_BEDAT IS INITIAL.

      MESSAGE '####/###/#### #### #####.' TYPE 'E'.

    ENDIF.



    " ##### ## (ZLFA1_22)

    CLEAR ZLFA1_22.

    SELECT SINGLE *

    INTO @ZLFA1_22

    FROM ZLFA1_22

    WHERE LIFNR = @P_LIFNR.



    IF SY-SUBRC <> 0.

      MESSAGE |### { P_LIFNR } #(#) #####(ZLFA1_22)# #### ####.| TYPE 'E'.

    ENDIF.



    " ##### ### ## (ZLFB1_22)

    CLEAR ZLFB1_22.

    SELECT SINGLE *

    INTO @ZLFB1_22

    FROM ZLFB1_22

    WHERE LIFNR = @P_LIFNR

     AND BUKRS = @P_BUKRS.



    IF SY-SUBRC <> 0.

      MESSAGE |### { P_LIFNR } #(#) #### { P_BUKRS } ###(ZLFB1_22)# ####.| TYPE 'E'.

    ENDIF.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME = 'CON1'.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_CUSTOM.



ENDFORM.



FORM FIELD_CATALOG .

  CLEAR : GT_FCAT, GS_FCAT.



  GS_FCAT-COL_POS   = 1.

  GS_FCAT-FIELDNAME = 'SEL'.

  GS_FCAT-COLTEXT   = '##'.

  GS_FCAT-OUTPUTLEN = 3.

  GS_FCAT-EDIT      = 'X'.

  GS_FCAT-CHECKBOX  = 'X'.  " # ##### ##

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "##

  GS_FCAT-COL_POS   = 2.

  GS_FCAT-FIELDNAME = 'EBELP'.

  GS_FCAT-COLTEXT   = '##'.

  GS_FCAT-OUTPUTLEN = 5.

  GS_FCAT-KEY       = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "####

  GS_FCAT-COL_POS   = 3.

  GS_FCAT-FIELDNAME = 'MATNR'.

  GS_FCAT-COLTEXT   = '####'.

  GS_FCAT-OUTPUTLEN = 18.

  GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "###

  GS_FCAT-COL_POS   = 4.

  GS_FCAT-FIELDNAME = 'MAKTX'.

  GS_FCAT-COLTEXT   = '###'.

  GS_FCAT-OUTPUTLEN = 30.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "PO##

  GS_FCAT-COL_POS   = 5.

  GS_FCAT-FIELDNAME = 'MENGE'.

  GS_FCAT-COLTEXT   = 'PO##'.

  GS_FCAT-OUTPUTLEN = 13.

  GS_FCAT-EDIT      = 'X'.

  GS_FCAT-REF_TABLE  = 'EKPO'.

  GS_FCAT-REF_FIELD  = 'MENGE'.

  "GS_FCAT-DECIMALS_0 = 0.

  GS_FCAT-NO_ZERO = 'X'.

  "GS_FCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  GS_FCAT-COL_POS   = 6.

  GS_FCAT-FIELDNAME = 'STPRS'.

  GS_FCAT-COLTEXT   = '##'.

  GS_FCAT-OUTPUTLEN = 15.

  GS_FCAT-EDIT      = 'X'.

  GS_FCAT-CFIELDNAME = 'WAERS'.  " ## ##

  "GS_FCAT-DECIMALS_OUT = 2.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "##

  GS_FCAT-COL_POS   = 7.

  GS_FCAT-FIELDNAME = 'MEINS'.

  GS_FCAT-COLTEXT   = '##'.

  GS_FCAT-OUTPUTLEN = 5.

  GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "##

  GS_FCAT-COL_POS   = 8.

  GS_FCAT-FIELDNAME = 'WAERS'.

  GS_FCAT-COLTEXT   = '##'.

  GS_FCAT-OUTPUTLEN = 5.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "####

  GS_FCAT-COL_POS   = 9.

  GS_FCAT-FIELDNAME = 'MWSKZ'.

  GS_FCAT-COLTEXT   = '####'.

  GS_FCAT-OUTPUTLEN = 6.

  GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "###

  GS_FCAT-COL_POS   = 10.

  GS_FCAT-FIELDNAME = 'PRDAT'.

  GS_FCAT-COLTEXT   = '###'.

  GS_FCAT-OUTPUTLEN = 10.

  GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "###

  GS_FCAT-COL_POS   = 11.

  GS_FCAT-FIELDNAME = 'WERKS'.

  GS_FCAT-COLTEXT   = '###'.

  GS_FCAT-OUTPUTLEN = 4.

  GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "####

  GS_FCAT-COL_POS   = 12.

  GS_FCAT-FIELDNAME = 'LGORT'.

  GS_FCAT-COLTEXT   = '####'.

  GS_FCAT-OUTPUTLEN = 4.

  GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  "GS_LAYOUT-ZEBRA      = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-SEL_MODE   = 'A'.

  GS_LAYOUT-BOX_FNAME  = 'SEL'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_ITEM

      IT_FIELDCATALOG = GT_FCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ITEM_LINE

*&---------------------------------------------------------------------*

*       #### ## ## #

*       - ## ## ### ## # # ## ## (10, 20, 30...)

*----------------------------------------------------------------------*




FORM ADD_ITEM_LINE.

  DATA : LV_MAX_EBELP TYPE ZEKPO_22-EBELP,

         LV_NEW_EBELP TYPE ZEKPO_22-EBELP,

         LV_VALID     TYPE C,

         LV_ERROR     TYPE C,

         LV_EBELP     TYPE ZEKPO_22-EBELP.



  " ALV ## ### ##

  IF GC_GRID IS NOT INITIAL.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  "---------------------------------------------------------------

  " ## ### ## ### ##

  "---------------------------------------------------------------

  CLEAR LV_ERROR.



  LOOP AT GT_ITEM INTO GS_ITEM.

    LV_EBELP = GS_ITEM-EBELP.



    " ##### ### #### ##

    IF GS_ITEM-MATNR IS NOT INITIAL.



      " 1. #### ### ## (ZMARA_22)

      PERFORM CHECK_MATNR USING    GS_ITEM-MATNR

                          CHANGING LV_VALID.



      IF LV_VALID <> 'S'.

        MESSAGE |## { LV_EBELP }: #### { GS_ITEM-MATNR } #(#) #####(ZMARA_22)# #### ####.| TYPE 'S' DISPLAY LIKE 'E'.

        LV_ERROR = 'X'.

        EXIT.

      ENDIF.



      " 2. ### ## (##### ### #)

      IF GS_ITEM-PRDAT IS NOT INITIAL.

        IF GS_ITEM-PRDAT < GS_HEADER-BEDAT.

          MESSAGE |## { LV_EBELP }: #### ###({ GS_HEADER-BEDAT })## ### #### ###.| TYPE 'S' DISPLAY LIKE 'E'.

          LV_ERROR = 'X'.

          EXIT.

        ENDIF.

      ENDIF.



      " 3. ###, #### ### ## (ZMARA_22)

      IF GS_ITEM-WERKS IS NOT INITIAL OR GS_ITEM-LGORT IS NOT INITIAL.

        PERFORM CHECK_WERKS_LGORT USING    GS_ITEM-MATNR

                                           GS_ITEM-WERKS

                                           GS_ITEM-LGORT

                                  CHANGING LV_VALID.



        IF LV_VALID <> 'S'.

          MESSAGE |## { LV_EBELP }: ## { GS_ITEM-MATNR } # ## ###/##### ###### #### ####.| TYPE 'S' DISPLAY LIKE 'E'.

          LV_ERROR = 'X'.

          EXIT.

        ENDIF.

      ENDIF.



    ENDIF.

  ENDLOOP.



  " ## ### ## ## ##

  IF LV_ERROR = 'X'.

    RETURN.

  ENDIF.



  "---------------------------------------------------------------

  " # ## ## (10, 20, 30...)

  "---------------------------------------------------------------

  CLEAR LV_MAX_EBELP.



  IF GT_ITEM IS INITIAL.

    LV_NEW_EBELP = '00010'.

  ELSE.

    LOOP AT GT_ITEM INTO GS_ITEM.

      IF GS_ITEM-EBELP > LV_MAX_EBELP.

        LV_MAX_EBELP = GS_ITEM-EBELP.

      ENDIF.

    ENDLOOP.

    LV_NEW_EBELP = LV_MAX_EBELP + 10.

  ENDIF.



  CLEAR GS_ITEM.

  GS_ITEM-EBELP = LV_NEW_EBELP.



  APPEND GS_ITEM TO GT_ITEM.



  " ALV ##

  IF GC_GRID IS NOT INITIAL.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MATNR

*&---------------------------------------------------------------------*

*       #### ### ## (ZMARA_22)

*----------------------------------------------------------------------*




FORM CHECK_MATNR USING    PV_MATNR TYPE ZEKPO_22-MATNR

                 CHANGING PV_VALID TYPE C.



  DATA : LV_COUNT TYPE I.



  CLEAR PV_VALID.



  SELECT COUNT(*)

    INTO LV_COUNT

    FROM ZMARA_22

    WHERE ZMATNR = PV_MATNR.



  IF LV_COUNT > 0.

    PV_VALID = 'S'.

  ELSE.

    PV_VALID = 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_WERKS_LGORT

*&---------------------------------------------------------------------*

*       ###, #### ### ## (ZMARA_22)

*----------------------------------------------------------------------*




FORM CHECK_WERKS_LGORT USING    PV_MATNR TYPE ZEKPO_22-MATNR

                                PV_WERKS TYPE ZEKPO_22-WERKS

                                PV_LGORT TYPE ZEKPO_22-LGORT

                       CHANGING PV_VALID TYPE C.



  DATA : LV_COUNT TYPE I.



  CLEAR PV_VALID.



  SELECT COUNT(*)

    INTO LV_COUNT

    FROM ZMARA_22

    WHERE ZMATNR = PV_MATNR

      AND ZWERKS = PV_WERKS

      AND ZLGORT = PV_LGORT.



  IF LV_COUNT > 0.

    PV_VALID = 'S'.

  ELSE.

    PV_VALID = 'E'.

  ENDIF.



ENDFORM.






*FORM DEL_ITEM_LINE.

*  DATA : LV_INDEX TYPE I,

*         LV_COUNT TYPE I.

*

*  " ALV ## ### ##

*  IF GC_GRID IS NOT INITIAL.

*    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

*  ENDIF.

*

*  " ### # ## (##)

*  LV_INDEX = 1.

*  LOOP AT GT_ITEM INTO GS_ITEM.

*    LV_INDEX = SY-TABIX.

*  ENDLOOP.

*

*  " #### ##

*  WHILE LV_INDEX > 0.

*    READ TABLE GT_ITEM INTO GS_ITEM INDEX LV_INDEX.

*    IF SY-SUBRC = 0 AND GS_ITEM-SEL = 'X'.

*      DELETE GT_ITEM INDEX LV_INDEX.

*      LV_COUNT = LV_COUNT + 1.

*    ENDIF.

*    LV_INDEX = LV_INDEX - 1.

*  ENDWHILE.

*

*  IF LV_COUNT = 0.

*    MESSAGE '### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

*    RETURN.

*  ENDIF.

*

*  " ALV ##

*  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

*

*  MESSAGE |{ LV_COUNT }# ### #######.| TYPE 'S'.

*

*ENDFORM.

*&---------------------------------------------------------------------*

*&      Form  DEL_ITEM_LINE

*&---------------------------------------------------------------------*




FORM DEL_ITEM_LINE.

  DATA : LV_COUNT TYPE I,

         LV_IDX   TYPE I.



  " ALV ## ### ##

  IF GC_GRID IS NOT INITIAL.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

  ENDIF.



  " ### ## #### ##

  LV_IDX = LINES( GT_ITEM ).



  WHILE LV_IDX > 0.

    READ TABLE GT_ITEM INTO GS_ITEM INDEX LV_IDX.

    IF SY-SUBRC = 0 AND GS_ITEM-SEL = 'X'.

      DELETE GT_ITEM INDEX LV_IDX.

      LV_COUNT = LV_COUNT + 1.

    ENDIF.

    LV_IDX = LV_IDX - 1.

  ENDWHILE.



  IF LV_COUNT = 0.

    MESSAGE '### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " ALV ##

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.



  MESSAGE |{ LV_COUNT }# ### #######.| TYPE 'S'.



ENDFORM.






*FORM CREATE_PO.

*  DATA : lv_ebeln   TYPE zekkO_22-ebeln,

*         lv_max_po  TYPE zekkO_22-ebeln,

*         ls_header  TYPE zekkO_22,

*         ls_item    TYPE zekpo_22.

*

*  " ALV ## ### ##

*  IF gc_grid IS NOT INITIAL.

*    CALL METHOD gc_grid->check_changed_data.

*  ENDIF.

*

*  " ## ### ##

*  IF gt_item IS INITIAL.

*    MESSAGE '### #####.' TYPE 'S' DISPLAY LIKE 'E'.

*    RETURN.

*  ENDIF.

*

*  " 1. #### ## ##

*  CLEAR lv_max_po.

*

*  SELECT MAX( ebeln )

*    INTO lv_max_po

*    FROM zekkO_22.

*

*  IF lv_max_po IS INITIAL.

*    lv_ebeln = '4500000000'.

*  ELSE.

*    lv_ebeln = lv_max_po + 1.

*  ENDIF.

*

*  " 2. #### ## ### ## (ZEKKO_22)

*  CLEAR ls_header.

*

*  ls_header-ebeln = lv_ebeln.

*  ls_header-bukrs = gs_header-bukrs.

*  ls_header-ekgrp = gs_header-ekgrp.

*  ls_header-ekorg = gs_header-ekorg.

*  ls_header-lifnr = gs_header-lifnr.

*  ls_header-bedat = gs_header-bedat.

*  "ls_header-waers = gs_header-waers.

*

*  " [## ##] -----------------------------------------------------

*  " ## ###(GS_HEADER)# ### ###, # ## #### #### ##

*  IF gs_header-waers IS INITIAL.

*    READ TABLE gt_item INTO gs_item INDEX 1.

*    IF sy-subrc = 0.

*      ls_header-waers = gs_item-waers.

*    ENDIF.

*  ELSE.

*    ls_header-waers = gs_header-waers.

*  ENDIF.

*  " [## #] -------------------------------------------------------

*

*  INSERT zekkO_22 FROM ls_header.

*

*  IF sy-subrc <> 0.

*    MESSAGE '## ## ##.' TYPE 'S' DISPLAY LIKE 'E'.

*    RETURN.

*  ENDIF.

*

*  " 3. #### ## ### ## (ZEKPO_22)

*  LOOP AT gt_item INTO gs_item.

*    CLEAR ls_item.

*

*    ls_item-ebeln = lv_ebeln.

*    ls_item-ebelp = gs_item-ebelp.

*    ls_item-matnr = gs_item-matnr.

*    ls_item-maktx = gs_item-maktx.

*    ls_item-menge = gs_item-menge.

*    "ls_item-menge = gs_item-menge_raw.

*    ls_item-meins = gs_item-meins.

*    ls_item-stprs = gs_item-stprs.

*    "ls_item-waers = gs_item-waers.

*    ls_item-mwskz = gs_item-mwskz.

*    ls_item-prdat = gs_item-prdat.

*    ls_item-werks = gs_item-werks.

*    ls_item-lgort = gs_item-lgort.

*    "ls_item-bprme = gs_item-bprme.

*

*    INSERT zekpo_22 FROM ls_item.

*

*    IF sy-subrc <> 0.

*      ROLLBACK WORK.

*      MESSAGE |## { gs_item-ebelp } ## ##.| TYPE 'S' DISPLAY LIKE 'E'.

*      RETURN.

*    ENDIF.

*  ENDLOOP.

*

*  " 4. ##

*  COMMIT WORK AND WAIT.

*

*  MESSAGE |#### { lv_ebeln } #(#) #######.| TYPE 'S'.

*

*  "LEAVE TO SCREEN 0.

*ENDFORM.



*&---------------------------------------------------------------------*

*&      Form  CREATE_PO

*&---------------------------------------------------------------------*




FORM CREATE_PO.

  DATA : lv_ebeln   TYPE zekko_22-ebeln,

         lv_max_po  TYPE zekko_22-ebeln,

         ls_header  TYPE zekko_22,

         ls_item    TYPE zekpo_22.



  " ALV ## ### ##

  IF gc_grid IS NOT INITIAL.

    CALL METHOD gc_grid->check_changed_data.

  ENDIF.



  " ## ### ## ## ##

  IF gt_item IS INITIAL.

    MESSAGE '### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " (### ## ### ### ##### ##### ##)



  " 1. #### ## ##

  CLEAR lv_max_po.

  SELECT MAX( ebeln ) INTO lv_max_po FROM zekko_22.



  IF lv_max_po IS INITIAL.

    lv_ebeln = '4500000000'.

  ELSE.

    lv_ebeln = lv_max_po + 1.

  ENDIF.



  " 2. #### ## ### ## (ZEKKO_22)

  CLEAR ls_header.

  ls_header-ebeln = lv_ebeln.

  ls_header-bukrs = gs_header-bukrs.

  ls_header-ekgrp = gs_header-ekgrp.

  ls_header-ekorg = gs_header-ekorg.

  ls_header-lifnr = gs_header-lifnr.

  ls_header-bedat = gs_header-bedat.



  IF gs_header-waers IS INITIAL.

    READ TABLE gt_item INTO gs_item INDEX 1.

    IF sy-subrc = 0.

      ls_header-waers = gs_item-waers.

    ENDIF.

  ELSE.

    ls_header-waers = gs_header-waers.

  ENDIF.



  INSERT zekko_22 FROM ls_header.

  IF sy-subrc <> 0.

    MESSAGE '## ## ##.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " 3. #### ## ### ## (ZEKPO_22)

  LOOP AT gt_item INTO gs_item.

    CLEAR ls_item.



    ls_item-ebeln = lv_ebeln.

    ls_item-ebelp = gs_item-ebelp.

    ls_item-matnr = gs_item-matnr.

    ls_item-maktx = gs_item-maktx.

    ls_item-menge = gs_item-menge.

    ls_item-meins = gs_item-meins.

    ls_item-stprs = gs_item-stprs.

    ls_item-mwskz = gs_item-mwskz.

    ls_item-prdat = gs_item-prdat.

    ls_item-werks = gs_item-werks.

    ls_item-lgort = gs_item-lgort.

    ls_item-bprme = gs_item-meins.



    INSERT zekpo_22 FROM ls_item.



    IF sy-subrc <> 0.

      ROLLBACK WORK.

      MESSAGE |## { gs_item-ebelp } ## ##.| TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  " 4. ##

  COMMIT WORK AND WAIT.



  MESSAGE |#### { lv_ebeln } #(#) #######.| TYPE 'I'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                    P_ONF4

                                    P_ONF4_BEFORE

                                    P_ONF4_AFTER

                                    P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LS_CELL TYPE LVC_S_STYL.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    " # ## ##

    IF LS_MODI-VALUE IS INITIAL.

      CONTINUE.

    ENDIF.



    READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_MODI-ROW_ID.



    CASE LS_MODI-FIELDNAME.



      WHEN 'MATNR'. " ####

        GS_ITEM-MATNR = LS_MODI-VALUE.

        " ###, ##, ##, ## ## ##

        SELECT SINGLE ZMATNAME, STPRS, MEINS, WAERS

          INTO (@GS_ITEM-MAKTX, @GS_ITEM-STPRS, @GS_ITEM-MEINS, @GS_ITEM-WAERS)

          FROM ZMARA_22

          WHERE ZMATNR = @GS_ITEM-MATNR.



        " [## 1] ## ## # ### ##(MEINS)# ####(BPRME)## ##

        GS_ITEM-BPRME = GS_ITEM-MEINS.



        " ### ## ### ### ## ##

        IF GS_HEADER-WAERS IS INITIAL.

           GS_HEADER-WAERS = GS_ITEM-WAERS.

        ENDIF.



        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.






*        WHEN 'MATNR'. " ####

* GS_ITEM-MATNR = LS_MODI-VALUE.

*

* " -----------------------------------------------------------

* " [##] ##(STPRS)# ##, ###, ##, ### ##

* " -----------------------------------------------------------

* SELECT SINGLE ZMATNAME, MEINS, WAERS

* INTO (@GS_ITEM-MAKTX, @GS_ITEM-MEINS, @GS_ITEM-WAERS)

* FROM ZMARA_22

* WHERE ZMATNR = @GS_ITEM-MATNR.

*

* " [##] ##(MEINS)# #####, ####(BPRME) ### ## ##

* GS_ITEM-BPRME = GS_ITEM-MEINS.

*

* " ### ## ### ### ## ### ### ##

* IF GS_HEADER-WAERS IS INITIAL.

* GS_HEADER-WAERS = GS_ITEM-WAERS.

* ENDIF.

*

* MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.






      WHEN 'MAKTX'. " ###

        GS_ITEM-MAKTX = LS_MODI-VALUE.

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



      WHEN 'MENGE'. " PO##

        GS_ITEM-MENGE = LS_MODI-VALUE * 1000.

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



      WHEN 'STPRS'."##

         GS_ITEM-STPRS = LS_MODI-VALUE * 100.

         MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



      WHEN 'MEINS'. " ##

        GS_ITEM-MEINS = LS_MODI-VALUE.



        " [## 2] #### ### ## #### ####(BPRME)# ## ##

        GS_ITEM-BPRME = LS_MODI-VALUE.



        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



      WHEN 'WAERS'. " ##

        GS_ITEM-WAERS = LS_MODI-VALUE.

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



          IF GS_HEADER-WAERS IS INITIAL.

             GS_HEADER-WAERS = GS_ITEM-WAERS.

          ENDIF.



      WHEN 'MWSKZ'. " ####

        GS_ITEM-MWSKZ = LS_MODI-VALUE.

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



      WHEN 'PRDAT'. " ###

        GS_ITEM-PRDAT = LS_MODI-VALUE.

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



      WHEN 'WERKS'. " ###

        GS_ITEM-WERKS = LS_MODI-VALUE.

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



      WHEN 'LGORT'. " ####

        GS_ITEM-LGORT = LS_MODI-VALUE.

        MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.



    ENDCASE.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED USING P_MODIFIED

                                     P_GOOD_CELLS TYPE LVC_T_MODI.

  DATA : LS_GOOD TYPE LVC_S_MODI.



  LOOP AT P_GOOD_CELLS INTO LS_GOOD.

    " 1. #### # ####

    READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_GOOD-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    " 2. GS_ITEM# ## VALID #### PERFORM# ##

    PERFORM VALID_ITEM USING LS_GOOD-FIELDNAME CHANGING GS_ITEM.



    MODIFY GT_ITEM FROM GS_ITEM INDEX LS_GOOD-ROW_ID.

  ENDLOOP.



  " 3. ALV REFRESH

  PERFORM REFRESH.



ENDFORM.



FORM REFRESH.

  DATA : LS_STABLE TYPE LVC_S_STBL.



  " ### ### #

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  " ## ##

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALID_ITEM

*&---------------------------------------------------------------------*




FORM VALID_ITEM USING    P_FIELD

                CHANGING P_ITEM TYPE TY_ITEM.



  DATA : LS_ITEM TYPE TY_ITEM.



  CASE P_FIELD.



    " 1. #### - ZMARA_22 ##

    WHEN 'MATNR'.

      SELECT SINGLE ZMATNR

        FROM ZMARA_22

        INTO LS_ITEM-MATNR

       WHERE ZMATNR = P_ITEM-MATNR.



      IF SY-SUBRC <> 0.

        CLEAR P_ITEM-MATNR.

        MESSAGE '#### ## #######.' TYPE 'I'.

      ENDIF.



    " 2. ### - ##### ### ##

    WHEN 'PRDAT'.

      IF P_ITEM-PRDAT < GS_HEADER-BEDAT.

        CLEAR P_ITEM-PRDAT.

        MESSAGE '#### ##### ### #### ###.' TYPE 'I'.

      ENDIF.



    " 3. ### - ZMARA_22 ##

    WHEN 'WERKS'.

      SELECT SINGLE ZWERKS

        FROM ZMARA_22

        INTO LS_ITEM-WERKS

       WHERE ZMATNR = P_ITEM-MATNR

         AND ZWERKS = P_ITEM-WERKS.



      IF SY-SUBRC <> 0.

        CLEAR P_ITEM-WERKS.

        MESSAGE '#### ## ######.' TYPE 'I'.

      ENDIF.



    " 4. #### - ## ## + ### + ####

    WHEN 'LGORT'.

      SELECT SINGLE ZLGORT

        FROM ZMARA_22

        INTO LS_ITEM-LGORT

       WHERE ZMATNR = P_ITEM-MATNR

         AND ZWERKS = P_ITEM-WERKS

         AND ZLGORT = P_ITEM-LGORT.



      IF SY-SUBRC <> 0.

        CLEAR P_ITEM-LGORT.

        MESSAGE '## ### # ##### ####.' TYPE 'I'.

      ENDIF.



  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       ### ### ##

*----------------------------------------------------------------------*




FORM CLASS_EVENT.

  " ### ### ##

  CREATE OBJECT GO_EVENT.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_200 .

    " Docking Container - ### ## ## GUI ##

  IF GC_DOCKING IS INITIAL.

    CREATE OBJECT GC_DOCKING

      EXPORTING

        side  = CL_GUI_DOCKING_CONTAINER=>dock_at_left

        ratio = 70      " ## ## (### ##)

        extension = 2000.

  ENDIF.



  " ALV GRID ## ##

  IF GC_GRID_200 IS INITIAL.

    CREATE OBJECT GC_GRID_200

      EXPORTING

        i_parent = GC_DOCKING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .

  "##

  GS_FCAT-COL_POS   = 1.

  GS_FCAT-FIELDNAME = 'EBELP'.

  GS_FCAT-COLTEXT   = '##'.

  "GS_FCAT-OUTPUTLEN = 5.

  GS_FCAT-KEY       = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "####

  GS_FCAT-COL_POS   = 2.

  GS_FCAT-FIELDNAME = 'MATNR'.

  GS_FCAT-COLTEXT   = '####'.

  "GS_FCAT-OUTPUTLEN = 18.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "###

  GS_FCAT-COL_POS   = 3.

  GS_FCAT-FIELDNAME = 'MAKTX'.

  GS_FCAT-COLTEXT   = '###'.

  "GS_FCAT-OUTPUTLEN = 30.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "PO##

  GS_FCAT-COL_POS   = 4.

  GS_FCAT-FIELDNAME = 'MENGE'.

  GS_FCAT-COLTEXT   = 'PO##'.

  "GS_FCAT-OUTPUTLEN = 13.

  "GS_FCAT-EDIT      = 'X'.

  GS_FCAT-NO_ZERO = 'X'.

  "GS_FCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  GS_FCAT-COL_POS   = 5.

  GS_FCAT-FIELDNAME = 'STPRS'.

  GS_FCAT-COLTEXT   = '##'.

  "GS_FCAT-OUTPUTLEN = 15.

  "GS_FCAT-EDIT      = 'X'.

  GS_FCAT-CFIELDNAME = 'WAERS'.  " ## ##

  "GS_FCAT-DECIMALS_OUT = 2.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "##

  GS_FCAT-COL_POS   = 6.

  GS_FCAT-FIELDNAME = 'MEINS'.

  GS_FCAT-COLTEXT   = '##'.

  "GS_FCAT-OUTPUTLEN = 5.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.





  "##

  GS_FCAT-COL_POS   = 7.

  GS_FCAT-FIELDNAME = 'WAERS'.

  GS_FCAT-COLTEXT   = '##'.

  "GS_FCAT-OUTPUTLEN = 5.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "####

  GS_FCAT-COL_POS   = 8.

  GS_FCAT-FIELDNAME = 'MWSKZ'.

  GS_FCAT-COLTEXT   = '####'.

  "GS_FCAT-OUTPUTLEN = 6.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "###

  GS_FCAT-COL_POS   = 9.

  GS_FCAT-FIELDNAME = 'PRDAT'.

  GS_FCAT-COLTEXT   = '###'.

  "GS_FCAT-OUTPUTLEN = 10.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "###

  GS_FCAT-COL_POS   = 10.

  GS_FCAT-FIELDNAME = 'WERKS'.

  GS_FCAT-COLTEXT   = '###'.

  "GS_FCAT-OUTPUTLEN = 4.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.



  "####

  GS_FCAT-COL_POS   = 11.

  GS_FCAT-FIELDNAME = 'LGORT'.

  GS_FCAT-COLTEXT   = '####'.

  "GS_FCAT-OUTPUTLEN = 4.

  "GS_FCAT-EDIT      = 'X'.

  APPEND GS_FCAT TO GT_FCAT. CLEAR GS_FCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_200 .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  "GS_LAYOUT-ZEBRA      = 'X'.

  GS_LAYOUT-SEL_MODE   = 'D'.  "## ##: ## ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV_200 .

    CALL METHOD GC_GRID_200->set_table_for_first_display

    EXPORTING

      is_layout       = GS_LAYOUT

    CHANGING

      it_outtab       = GT_ITEM        " ### ##

      it_fieldcatalog = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  READ_PO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM READ_PO_DATA .

  "------------------------------------------

  " 1. ## ## (ZEKKO_22)

  "------------------------------------------

  CLEAR GS_HEADER.



  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF @GS_HEADER

      FROM ZEKKO_22

     WHERE EBELN = @P_EBELN

       AND BUKRS = @P_BUKR2

       AND LIFNR = @P_LIFN2.



  IF sy-subrc <> 0.

    MESSAGE |PO { P_EBELN } #(#) #### ####.| TYPE 'E'.

    EXIT.

  ENDIF.





  "------------------------------------------

  " 2. ## ## (ZEKPO_22)

  "------------------------------------------

  CLEAR GT_ITEM.



  SELECT P~EBELP,

         P~MATNR,

         P~MAKTX,

         P~MENGE,

         P~MEINS,

         P~STPRS,

         P~MWSKZ,

         P~PRDAT,

         P~WERKS,

         P~LGORT,

         H~WAERS     " # #### ## ####

    FROM ZEKPO_22 AS P

    INNER JOIN ZEKKO_22 AS H

      ON P~EBELN = H~EBELN

    INTO CORRESPONDING FIELDS OF TABLE @GT_ITEM

   WHERE P~EBELN = @P_EBELN.



  IF GT_ITEM IS INITIAL.

    MESSAGE '## PO# ##### ####.' TYPE 'I'.

  ENDIF.



ENDFORM.