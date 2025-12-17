
*&---------------------------------------------------------------------*

*&  Include           ZMM05_003_F02

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  VALID_GR_INPUT

*&---------------------------------------------------------------------*




FORM VALID_GR_INPUT .

  IF P_EBELN2 IS INITIAL OR P_WERKS2 IS INITIAL.

    MESSAGE '#### ## ######' TYPE 'E'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_GR_DATA

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_GR_DATA

*&---------------------------------------------------------------------*




FORM GET_GR_DATA .

  CLEAR : GS_MKPF, GS_MSEG, GT_MSEG.

  CLEAR : GS_PO_HEADER.



  " 1. PO ## ## #### (## ###)

  SELECT SINGLE * FROM ZEKKO_05

    INTO CORRESPONDING FIELDS OF GS_PO_HEADER

    WHERE EBELN = P_EBELN2.



  " ### # # ###

  GS_PO_HEADER-WERKS = P_WERKS2.





  " 2. [##] PO# ## ## ## ### #### (## ###)

  SELECT * FROM ZMSEG_05

    INTO CORRESPONDING FIELDS OF TABLE GT_MSEG

    WHERE EBELN = P_EBELN2

      AND ZWERKS = P_WERKS2. " ### ## ##



  " 3. ## ### ## ### ## ### (###, ##, ### #)

  DATA : LS_PO_ITEM TYPE ZEKPO_05,

         LS_MKPF_LOC TYPE ZMKPF_05.



  LOOP AT GT_MSEG INTO GS_MSEG.



    " A. ###(BLDAT) #### (## ### ##)

    SELECT SINGLE * FROM ZMKPF_05 INTO LS_MKPF_LOC

      WHERE MBLNR = GS_MSEG-MBLNR.

    IF SY-SUBRC = 0.

      GS_MSEG-BLDAT = LS_MKPF_LOC-BLDAT.

    ENDIF.



    " B. ###(MAKTX), PO##(PO_MENGE), ##(EBELP) ####

    "    (ZEKPO_05 ### ##)

    SELECT SINGLE * FROM ZEKPO_05 INTO LS_PO_ITEM

      WHERE EBELN = GS_MSEG-EBELN

        AND MATNR = GS_MSEG-MATNR

        AND WERKS = GS_MSEG-ZWERKS.



    IF SY-SUBRC = 0.

      GS_MSEG-MAKTX    = LS_PO_ITEM-MAKTX.

      GS_MSEG-PO_MENGE = LS_PO_ITEM-MENGE.

      GS_MSEG-EBELP    = LS_PO_ITEM-EBELP.

    ENDIF.



    " C. ## ### (##/##)

    IF GS_MSEG-BWART = '102'.

      GS_MSEG-STATUS_TXT = '##'.

    ELSE.

      GS_MSEG-STATUS_TXT = '##'.

    ENDIF.



    MODIFY GT_MSEG FROM GS_MSEG.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_GR_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_GR_DATA .

  " ## ## ## ##

ENDFORM.










*&---------------------------------------------------------------------*

*&      Form  BTN_DEL

*&---------------------------------------------------------------------*




FORM BTN_DEL .

  DATA : LS_ROW TYPE LVC_S_ROW.

  DATA : LV_CHECKED_CNT TYPE I.



  " [## ###] ### #### ### ### ITAB# ##

  " # ### ### ### ## ##### ## # # ### #####.

  IF GC_GRID_201 IS BOUND.

    CALL METHOD GC_GRID_201->CHECK_CHANGED_DATA.

  ENDIF.



  " 1. ### ## ## ##

  CLEAR LV_CHECKED_CNT.

  LOOP AT GT_MSEG INTO GS_MSEG WHERE CHECK = 'X'.

    ADD 1 TO LV_CHECKED_CNT.

  ENDLOOP.



  " #### #### ### # ##

  IF LV_CHECKED_CNT = 0.

    MESSAGE '### ### ##### #####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " 2. ## ##

  DATA : LV_ANSWER TYPE C.

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR       = '## ##'

      TEXT_QUESTION  = '### ### [##] ## ######?'

      TEXT_BUTTON_1  = '#'

      TEXT_BUTTON_2  = '###'

    IMPORTING

      ANSWER         = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    RETURN.

  ENDIF.



  " 3. ## ## (### ###)

  DATA : LV_SUCCESS TYPE C.



  LOOP AT GT_MSEG INTO GS_MSEG WHERE CHECK = 'X'.



    " ## ### ### ##

    IF GS_MSEG-BWART = '102'.

      CONTINUE.

    ENDIF.



    " DB ####: ####(BWART)# 102# ##

    UPDATE ZMSEG_05

      SET BWART = '102'

      WHERE MBLNR = GS_MSEG-MBLNR

        AND MJAHR = GS_MSEG-MJAHR

        AND ZEILE = GS_MSEG-ZEILE.



    IF SY-SUBRC = 0.

       " ## ### ##

       GS_MSEG-BWART = '102'.

       GS_MSEG-STATUS_TXT = '##'.

       GS_MSEG-CHECK = ''. " ## # ## ##

       MODIFY GT_MSEG FROM GS_MSEG.

       LV_SUCCESS = 'X'.

    ENDIF.

  ENDLOOP.



  " 4. ## ##

  IF LV_SUCCESS = 'X'.

    COMMIT WORK.

    MESSAGE '### ### ## #######.' TYPE 'S'.

    PERFORM REFRESH2. " ALV ## ##

  ELSE.

    MESSAGE '## ### ##### ### # ####.' TYPE 'I'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MAKE_FIELDCATALOG_201

*&---------------------------------------------------------------------*




FORM MAKE_FIELDCATALOG_201 .

  CLEAR : GS_FC, GT_FC.



  " 1. ## (PO Item)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 1.

  GS_FC-FIELDNAME = 'EBELP'.

  GS_FC-COLTEXT   = '##'.

  APPEND GS_FC TO GT_FC.



  " 2. [##] ## (####)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 2.

  GS_FC-FIELDNAME = 'CHECK'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-CHECKBOX  = 'X'.  " #### ##

  GS_FC-EDIT      = 'X'.  " ## #### ##

  APPEND GS_FC TO GT_FC.



  " 3. ######

  CLEAR GS_FC.

  GS_FC-COL_POS   = 3.

  GS_FC-FIELDNAME = 'MBLNR'.

  GS_FC-COLTEXT   = '######'.

  APPEND GS_FC TO GT_FC.



  " 4. #####

  CLEAR GS_FC.

  GS_FC-COL_POS   = 4.

  GS_FC-FIELDNAME = 'ZEILE'.

  GS_FC-COLTEXT   = '#####'.

  APPEND GS_FC TO GT_FC.



  " 5. ###

  CLEAR GS_FC.

  GS_FC-COL_POS   = 5.

  GS_FC-FIELDNAME = 'MAKTX'.

  GS_FC-COLTEXT   = '###'.

  APPEND GS_FC TO GT_FC.



  " 6. PO##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 6.

  GS_FC-FIELDNAME = 'PO_MENGE'.

  GS_FC-COLTEXT   = 'PO##'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE  = 'ZEKPO_05'.

  GS_FC-REF_FIELD  = 'MENGE'.

  APPEND GS_FC TO GT_FC.



  " 7. ##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 7.

  GS_FC-FIELDNAME = 'MENGE'.

  GS_FC-COLTEXT   = '##'.

  GS_FC-QFIELDNAME = 'MEINS'.

  GS_FC-REF_TABLE  = 'ZEKPO_05'.

  GS_FC-REF_FIELD  = 'MENGE'.

  APPEND GS_FC TO GT_FC.



  " 8. ##

  CLEAR GS_FC.

  GS_FC-COL_POS   = 8.

  GS_FC-FIELDNAME = 'MEINS'.

  GS_FC-COLTEXT   = '##'.

  APPEND GS_FC TO GT_FC.



  " 9. ## (##/##)

  CLEAR GS_FC.

  GS_FC-COL_POS   = 9.

  GS_FC-FIELDNAME = 'STATUS_TXT'.

  GS_FC-COLTEXT   = '##'.

  APPEND GS_FC TO GT_FC.



  " 10. ###

  CLEAR GS_FC.

  GS_FC-COL_POS   = 10.

  GS_FC-FIELDNAME = 'BLDAT'.

  GS_FC-COLTEXT   = '###'.

  APPEND GS_FC TO GT_FC.



  " 11. ####

  CLEAR GS_FC.

  GS_FC-COL_POS   = 11.

  GS_FC-FIELDNAME = 'ZLGORT'.

  GS_FC-COLTEXT   = '####'.

  APPEND GS_FC TO GT_FC.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH_SCREEN

*&---------------------------------------------------------------------*




FORM REFRESH_SCREEN .

  IF GV_SELECTED_MBLNR IS INITIAL OR GV_SELECTED_MBLNR = 'ROOT'.

    RETURN.

  ENDIF.



  CLEAR GT_MSEG.



  " 1. ### ## ##(MBLNR)# ### ####

  SELECT * FROM ZMSEG_05

    INTO CORRESPONDING FIELDS OF TABLE GT_MSEG

    WHERE MBLNR = GV_SELECTED_MBLNR.



  " 2. ### ##(###, ##) ###

  DATA : LS_MAKT TYPE MAKT.



  LOOP AT GT_MSEG INTO GS_MSEG.

    " 2-1. ### #### (MAKT ### ## or PO### ##)

    "      ## ### # MAKT ######.

    SELECT SINGLE MAKTX FROM ZEKPO_05

      INTO GS_MSEG-MAKTX " (##: GS_MSEG #### MAKTX ### ### #. ### TOP ## ##)

      WHERE EBELN = GS_MSEG-EBELN

        AND MATNR = GS_MSEG-MATNR.



    " (## ZEKPO_05# MAKTX# ### MAKT ### ##)

    " SELECT SINGLE MAKTX FROM MAKT INTO GS_MSEG-MAKTX

    "   WHERE MATNR = GS_MSEG-MATNR AND SPRAS = SY-LANGU.



    " 2-2. ## ### ## (## ##)

    IF GS_MSEG-BWART = '102'.

      GS_MSEG-STATUS_TXT = '##'. " (##: GS_MSEG# STATUS_TXT ## ##)

    ELSE.

      GS_MSEG-STATUS_TXT = '##'.

    ENDIF.



    MODIFY GT_MSEG FROM GS_MSEG.

  ENDLOOP.



  CLEAR OK_CODE.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  BUILD_TREE_NODES

*&---------------------------------------------------------------------*




FORM BUILD_TREE_NODES .

  DATA : LT_MBLNR_LIST TYPE TABLE OF ZMSEG_05,

         LS_MBLNR_LIST TYPE ZMSEG_05.

  DATA : LS_MKPF_LOCAL TYPE ZMKPF_05.



  DATA: GT_NODES TYPE TABLE OF MTREESNODE,

        LS_NODE  TYPE MTREESNODE.

  DATA : LV_DATE_CHAR TYPE C LENGTH 10.



  " 1. ## PO# #### #### ## ## ### ## ## (ZMSEG_05 ##)

  SELECT DISTINCT MBLNR

    INTO CORRESPONDING FIELDS OF TABLE LT_MBLNR_LIST

    FROM ZMSEG_05

    WHERE EBELN = P_EBELN2

      AND ZWERKS = P_WERKS2. " ZWERKS ##



  " 2. ## ## ##

  CLEAR LS_NODE.

  LS_NODE-NODE_KEY  = 'ROOT'.

  LS_NODE-ISFOLDER  = 'X'.

  LS_NODE-TEXT      = '## ## ##'.

  LS_NODE-RELATKEY  = space.

  APPEND ls_node TO gt_nodes.



  " 3. ## ## ##

  SORT LT_MBLNR_LIST BY MBLNR DESCENDING.



  LOOP AT LT_MBLNR_LIST INTO LS_MBLNR_LIST.

    " ## ## ####

    SELECT SINGLE * INTO LS_MKPF_LOCAL

      FROM ZMKPF_05

      WHERE MBLNR = LS_MBLNR_LIST-MBLNR.



    CLEAR LS_NODE.

    LS_NODE-NODE_KEY = LS_MBLNR_LIST-MBLNR.

    LS_NODE-RELATKEY = 'ROOT'.

    LS_NODE-RELATSHIP = CL_GUI_SIMPLE_TREE=>RELAT_LAST_CHILD.

    LS_NODE-N_IMAGE = ICON_DOCUMENT.



    WRITE LS_MKPF_LOCAL-BUDAT TO LV_DATE_CHAR.

    CONCATENATE LS_MBLNR_LIST-MBLNR '(' LV_DATE_CHAR ')'

           INTO LS_NODE-TEXT SEPARATED BY SPACE.



    APPEND LS_NODE TO GT_NODES.

  ENDLOOP.



  " 4. ### ### ##

  CALL METHOD GO_TREE->ADD_NODES

    EXPORTING

      TABLE_STRUCTURE_NAME = 'MTREESNODE'

      NODE_TABLE           = GT_NODES.



  " 5. ###

  CALL METHOD GO_TREE->EXPAND_NODE

    EXPORTING NODE_KEY = 'ROOT'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH2

*&---------------------------------------------------------------------*




FORM REFRESH2 .

  DATA : LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID_201->REFRESH_TABLE_DISPLAY

    EXPORTING IS_STABLE = LS_STABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  HANDLE_NODE_DOUBLE_CLICK

*&---------------------------------------------------------------------*

* CLS## #### #### ## # OK_CODE ##

*----------------------------------------------------------------------*




FORM HANDLE_NODE_DOUBLE_CLICK USING P_NODE_KEY.



  " 1. ## ### ### #### ##

  GV_SELECTED_MBLNR = P_NODE_KEY.



  " 2. ## ### ## PAI ### (OK_CODE ## ##)

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING

      NEW_CODE = 'REFRESH_SCREEN'.



ENDFORM.