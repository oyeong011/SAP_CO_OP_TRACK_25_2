
*&---------------------------------------------------------------------*

*&  Include           ZMM09_003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*




FORM CONTROL_SCREEN .

  LOOP AT SCREEN.

    IF P_R1 = 'X'. "####

      IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = 0.

      ENDIF.



    ELSEIF P_R2 = 'X'. "####

      IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  IF P_R1 = 'X'.

    P_BUDAT = SY-DATUM.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT

*&---------------------------------------------------------------------*




FORM VALID_INPUT .

  DATA : LV_EBELN LIKE ZEKKO_09-EBELN,

         LV_WERKS LIKE ZEKPO_09-WERKS.





  SELECT SINGLE EBELN WERKS

  FROM ZEKPO_09

  INTO ( LV_EBELN, LV_WERKS )

  WHERE EBELN = P_EBELNC

  AND   WERKS = P_WERKSC.





  IF SY-SUBRC <> 0.

    MESSAGE '## ##### #### ## ##### #### ####.' TYPE 'I'.

    STOP.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT_ALL

*&---------------------------------------------------------------------*




FORM VALID_INPUT_ALL .

  IF P_R1 = 'X'.

    IF ( P_EBELNC IS INITIAL ) OR ( P_WERKSC IS INITIAL ) OR ( P_BUDAT IS INITIAL ).

      MESSAGE '####, ###, ###### ########' TYPE 'I'.

      STOP.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF ( P_EBELNS IS INITIAL ) OR ( P_WERKSS IS INITIAL ).

      MESSAGE '####, #### ########' TYPE 'I'.

      STOP.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_MBLNR

*&---------------------------------------------------------------------*




FORM GET_MBLNR  CHANGING P_MBLNR.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'

      OBJECT = 'ZMBLNR09'

    IMPORTING

      NUMBER = P_MBLNR.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_ITAB

*&---------------------------------------------------------------------*




FORM GET_ITAB .



  TYPES : BEGIN OF TY_GR,

    EBELN TYPE EBELN,

    EBELP TYPE EBELP,

    GR_DONE TYPE MENGE_D,

  END OF TY_GR.

  DATA : LT_GR TYPE STANDARD TABLE OF TY_GR,

         LS_GR TYPE TY_GR.



  CLEAR : GT_ITEM, LT_GR.



  "ZEKKO_09 (####) #### ## ## ###

  SELECT

    a~EBELN "######

    b~EBELP "##

    a~LIFNR "###

    a~BEDAT "###

    b~MATNR "####

    c~ZMATNAME "###

    b~MENGE "## (PO##)

    b~MEINS "##

    b~STPRS "##

    a~WAERS "##

    b~PRDAT "###

    b~WERKS "###

    b~LGORT "####

  INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

  FROM ZEKKO_09 AS a

  INNER JOIN ZEKPO_09 AS b

    ON a~EBELN = b~EBELN

  INNER JOIN ZMARA09 AS c

    ON b~MATNR = c~ZMATNR

  WHERE a~EBELN = P_EBELNC "#### ##

  AND   b~WERKS = P_WERKSC.



  "###### ##### ####

   SELECT

      EBELN,

      EBELP,

      SUM( CASE SHKZG WHEN 'S' THEN MENGE

                      WHEN 'H' THEN MENGE * -1

           END ) AS GR_DONE

   FROM ZMSEG09

   WHERE EBELN = @P_EBELNC

   AND   WERKS = @P_WERKSC

   AND   BWART IN ('101', '102') "#543 ### ### ###### ##### ## #

   GROUP BY EBELN, EBELP

   INTO TABLE @LT_GR.



  "######, ####, ######

  CLEAR : GS_ITEM, LS_GR.

  LOOP AT GT_ITEM INTO GS_ITEM.

    READ TABLE LT_GR WITH KEY EBELN = GS_ITEM-EBELN

                              EBELP = GS_ITEM-EBELP

                     INTO LS_GR.



    IF SY-SUBRC = 0.

      GS_ITEM-GR_DONE = LS_GR-GR_DONE.

    ELSE.

      GS_ITEM-GR_DONE = 0.

    ENDIF.



    GS_ITEM-GR_REM = GS_ITEM-MENGE - GS_ITEM-GR_DONE.

    GS_ITEM-GR_REM = GS_ITEM-MENGE - GS_ITEM-GR_DONE.

    IF GS_ITEM-GR_REM < 0.

      GS_ITEM-GR_REM = 0. "## ## ## ##

    ENDIF.



    MODIFY GT_ITEM FROM GS_ITEM TRANSPORTING GR_DONE GR_REM GR_NOW

      WHERE EBELN = GS_ITEM-EBELN

      AND   EBELP = GS_ITEM-EBELP.

  ENDLOOP.



  "##### 0# ## ##

  DELETE GT_ITEM WHERE GR_REM <= 0.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*






FORM SAVE_DATA .

  DATA : LV_MTART LIKE ZMARA09-MTART, "####

         LV_PSTYP LIKE ZEKPO_09-PSTYP, "PO### ####

         LV_LINE_ID TYPE N LENGTH 3 VALUE '000', "MSEG LINE ID

         LV_BUZEI TYPE N LENGTH 3 VALUE '000',   "BSEG LINE ID

         LV_LINE_ID_B TYPE N LENGTH 3 VALUE '000'. "BSEG2 LINE IN(## #### ##)







  " 1. #### ##

  PERFORM GET_MBLNR CHANGING GF_MBLNR. "## (####)

  PERFORM BUILD_MKPF USING GF_MBLNR. "#### ## (##)



  " 2. #### ##

  PERFORM GET_BELNR CHANGING GV_BELNR. "#### ## ## (##)

  PERFORM BUILD_BKPF USING GV_BELNR. "#### ## (##)





  " 3. ####/#### ##

  LOOP AT GT_ITEM INTO GS_ITEM WHERE L_CHECK = 'X'.



    CLEAR : LV_MTART.



    "## ## #### ####

    SELECT SINGLE MTART

    FROM ZMARA09

    INTO LV_MTART "####

    WHERE ZMATNR = GS_ITEM-MATNR.



    "## ## PO## #### ####

    SELECT SINGLE PSTYP

    FROM ZEKPO_09

    INTO LV_PSTYP

    WHERE EBELN = GS_ITEM-EBELN

    AND   EBELP = GS_ITEM-EBELP.



    "##### ## ##

    IF LV_MTART = 'Z001' AND LV_PSTYP = 'L'.

      DATA : LV_ZMZEILE TYPE ZBSEG09-ZMZEILE. "## 101(###)# ZMZEILE



      "##### ####



      PERFORM BUILD_MSEG_101_OUTS USING GS_ITEM         "### ## MSEG ##

                                  CHANGING LV_LINE_ID.  "#### ZEILE

      LV_ZMZEILE = LV_LINE_ID. "## ##### ## ###





      PERFORM BUILD_MSEG_543_CONS USING GS_ITEM "### ## 543 MSEG ##

                                  CHANGING LV_LINE_ID.





      "##### #### ##

      PERFORM BUILD_BSEG_OUTS USING GS_ITEM

                                    LV_ZMZEILE

                              CHANGING LV_LINE_ID_B.

    ELSE.

      "#### (##/###/###/###_####)

      PERFORM BUILD_MSEG_101_STD USING GS_ITEM

                                 CHANGING LV_LINE_ID.

      PERFORM BUILD_BSEG_STD USING GS_ITEM LV_LINE_ID

                                 CHANGING LV_BUZEI.



    ENDIF.



  ENDLOOP. "#### ### LOOP



  "DB ## - ## # ### ## ##

  PERFORM SAVE_TO_DB.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  "####### ####

  PERFORM GET_GOODS_LIST.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_GOODS_LIST

*&---------------------------------------------------------------------*




FORM GET_GOODS_LIST.

  CLEAR : GS_GOODS_LIST, GT_GOODS_LIST.



  SELECT

         DISTINCT

         a~MBLNR

         a~BUDAT

  INTO CORRESPONDING FIELDS OF TABLE GT_GOODS_LIST

  FROM ZMKPF09 AS a "#### ## (a), ### (b)

  INNER JOIN ZMSEG09 AS b

    ON a~MBLNR = b~MBLNR

  WHERE b~EBELN = P_EBELNS "####

  AND   b~WERKS = P_WERKSS "###

  AND   b~BWART = '101'.   "101# (##/### ### ## ####) ##### ####



  IF SY-SUBRC <> 0.

    MESSAGE '## ##### #### #### ##### #### ####' TYPE 'I'.

    STOP.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_GOODS

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_GOODS .

  CREATE OBJECT GC_CUSTOM_GOODS_LIST

    EXPORTING

      CONTAINER_NAME              = 'CON1'.



  CREATE OBJECT GC_GRID_GOODS_LIST

    EXPORTING

      I_PARENT          = GC_CUSTOM_GOODS_LIST.







ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID_GOODS_LIST->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IT_TOOLBAR_EXCLUDING = GT_TOOLBAR

    CHANGING

      IT_OUTTAB                     = GT_GOODS_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'DISP_TEXT'.

  GS_FIELDCAT-COLTEXT = '#### (###) '.

  GS_FIELDCAT-OUTPUTLEN = 50.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  "#### ### alv###

  PERFORM MODIFY_GOODS_LIST.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_GOODS_LIST

*&---------------------------------------------------------------------*




FORM MODIFY_GOODS_LIST .



  CLEAR : GS_GOODS_LIST.

  LOOP AT GT_GOODS_LIST INTO GS_GOODS_LIST.

    "#### ( ### ) # ###



      CONCATENATE GS_GOODS_LIST-MBLNR

             ' (' GS_GOODS_LIST-BUDAT ')'

        INTO GS_GOODS_ALV-DISP_TEXT.



      APPEND GS_GOODS_ALV TO GT_GOODS_ALV.



    CLEAR : GS_GOODS_LIST.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DELETE_TOOLBAR

*&---------------------------------------------------------------------*




FORM DELETE_TOOLBAR .

  APPEND CL_GUI_ALV_GRID=>MC_FC_EXCL_ALL TO GT_TOOLBAR.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLE_CLICK

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DOUBLE_CLICK  USING    P_ROW TYPE LVC_S_ROW "Line ID

                                        P_COLUMN TYPE LVC_S_COL "Column Name

                                        P_ROW_NO TYPE LVC_S_ROID. "Numeric Row ID

   CLEAR : GS_GOODS_LIST.

   READ TABLE GT_GOODS_LIST INTO GS_GOODS_LIST INDEX P_ROW_NO-ROW_ID.

   IF SY-SUBRC <> 0.

     MESSAGE '## ###### ##### ### ######' TYPE 'I'.

     RETURN.

   ENDIF.



   PERFORM GET_HEADER_AND_ITEMS USING GS_GOODS_LIST-MBLNR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DOUBLE_CLICK FOR GC_GRID_GOODS_LIST.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_GR_SELECT_GUIDE

*&---------------------------------------------------------------------*




FORM DISPLAY_GR_SELECT_GUIDE .

  MESSAGE '##### # #### ## #### ### ########.' TYPE 'I'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_HEADER_AND_ITEMS

*&---------------------------------------------------------------------*




FORM GET_HEADER_AND_ITEMS  USING    P_GS_GOODS_MBLNR.

  "#### ####

  CLEAR : GS_HEADER_ALV.



  SELECT SINGLE

    MBLNR

    BLART

    BLDAT

    BUDAT

  FROM ZMKPF09

  INTO CORRESPONDING FIELDS OF GS_HEADER_ALV

  WHERE MBLNR = P_GS_GOODS_MBLNR.



  "### ## ####

  CLEAR : GS_ITEM_ALV, GT_ITEM_ALV.

  SELECT

    ZEILE

    MATNR

    MENGE

    MEINS

    WERKS

    LGORT

    BWART

    LIFNR

    BUKRS

  FROM ZMSEG09

  INTO CORRESPONDING FIELDS OF TABLE GT_ITEM_ALV

  WHERE MBLNR = P_GS_GOODS_MBLNR.



  "### ####

  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV.

    SELECT SINGLE ZMATNAME

    FROM ZMARA09

    INTO GS_ITEM_ALV-ZMATNAME

    WHERE ZMATNR = GS_ITEM_ALV-MATNR.



    MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX SY-TABIX.

  ENDLOOP.



  CALL SCREEN 200.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_ITEMS

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_ITEMS .

  CREATE OBJECT GC_CUSTOM_GOODS_ITEM

    EXPORTING

      CONTAINER_NAME              = 'CON2'.



  CREATE OBJECT GC_GRID_GOODS_ITEM

    EXPORTING

      I_PARENT          = GC_CUSTOM_GOODS_ITEM.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_ITEMS

*&---------------------------------------------------------------------*




FORM CALL_ALV_ITEMS .

  CALL METHOD GC_GRID_GOODS_ITEM->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IT_TOOLBAR_EXCLUDING = GT_TOOLBAR

      IS_LAYOUT            = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ITEM_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_ITEMS

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_ITEMS .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LV_CHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

 "GS_FIELDCAT-STYLEFIELD  = 'STYLE'. "543 #### #### ####

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'CANCEL_TEXT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'BWART'.

  GS_FIELDCAT-COLTEXT = '####'. "TODO (### # ##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT. "TODO (### # ##)

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CANCEL_GOODS

*&---------------------------------------------------------------------*




FORM CANCEL_GOODS   USING    P_MBLNR_NEW P_BELNR_NEW

                    CHANGING P_SUBRC P_AVAIL P_CURR.

  DATA : LS_OLD_ITEM TYPE ZMSEG09,  "### #### #### (## MSEG)

         LT_OLD_ITEM LIKE TABLE OF LS_OLD_ITEM.



  DATA : LS_MKPF_NEW TYPE ZMKPF09,  "## #### ##( 102/544 )

         LT_MKPF_NEW LIKE TABLE OF LS_MKPF_NEW.



  DATA : LS_MSEG_NEW TYPE ZMSEG09,  "## #### ###

         LT_MSEG_NEW LIKE TABLE OF LS_MSEG_NEW.



  DATA : LS_BKPF_NEW TYPE ZBKPF09, "## #### ##

         LT_BKPF_NEW LIKE TABLE OF LS_BKPF_NEW.



  DATA : LS_BSEG_NEW TYPE ZBSEG09, "## #### ###

         LT_BSEG_NEW LIKE TABLE OF LS_BSEG_NEW.



  DATA : LV_MBLNR_NEW TYPE ZMKPF09-MBLNR. "# ###### (##)



  DATA : TOTAL_GR TYPE MENGE_D,     "## ####(101)

         TOTAL_REV TYPE MENGE_D,    "## ####(102)

         AVAIL_QUAN TYPE MENGE_D.   "## ## ##



  DATA : LV_BELNR_NEW TYPE ZBKPF09-BELNR. "## ######





  "--------------------------------------------------------------------"

  " 1. ### ### ### (## MSEG ##)

  "   - ## ALV## ### ##(GT_ITEM_ALV) ####

  "   - ZMSEG09 ## #### LT_OLD_ITEM# ###.

  "--------------------------------------------------------------------"

  CLEAR : LS_OLD_ITEM, LT_OLD_ITEM.



  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV.

    IF GS_ITEM_ALV-LV_CHECK = ''.

      CONTINUE.

    ENDIF.



    SELECT SINGLE *

    FROM ZMSEG09

    INTO LS_OLD_ITEM

    WHERE MBLNR = GS_HEADER_ALV-MBLNR

    AND   ZEILE = GS_ITEM_ALV-ZEILE.



    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    APPEND LS_OLD_ITEM TO LT_OLD_ITEM.

  ENDLOOP.



  IF LT_OLD_ITEM IS INITIAL.

    P_SUBRC = 3. "####

    RETURN.

  ENDIF.



  "--------------------------------------------------------------

  " 1-1. ### ##, ### 101 ### ### 543 ### ## ##

  " - 543### PARENT_ID# 101# LINE_ID# ### ##

  "--------------------------------------------------------------

  DATA : LS_CHILD TYPE ZMSEG09,

         LT_CHILD LIKE TABLE OF LS_CHILD.



  LOOP AT LT_OLD_ITEM INTO LS_OLD_ITEM.

    "101 ### ## ##

    IF LS_OLD_ITEM-BWART = '101'.

      "## BOM #### (543) ##

      SELECT *

      FROM ZMSEG09

      INTO CORRESPONDING FIELDS OF TABLE LT_CHILD

      WHERE MBLNR = LS_OLD_ITEM-MBLNR "## ####

      AND   PARENT_ID = LS_OLD_ITEM-LINE_ID. "#### ##



      "## 543### LT_OLD_ITEM# ##

      LOOP AT LT_CHILD INTO LS_CHILD.

        APPEND LS_CHILD TO LT_OLD_ITEM.

      ENDLOOP.



    ENDIF.

  ENDLOOP.



  "--------------------------------------------------------------------"

  " 2. ## ## ## ##

  "    - ## ## ## = (## 101 ## ##) - (### ## ### 102 ##) => ####

  "    - ## #### > ## ## ## ## ## (P_SUBRC = 4)

  "--------------------------------------------------------------------"



  LOOP AT LT_OLD_ITEM INTO LS_OLD_ITEM.



    "##### 101## ##### ##(543# ### #### ## ##)

    IF LS_OLD_ITEM-BWART <> '101'.

      CONTINUE.

    ENDIF.



    CLEAR : TOTAL_GR, TOTAL_REV, AVAIL_QUAN.



    "## ### ## ## GR(101) ##

    SELECT SUM( MENGE ) INTO TOTAL_GR

    FROM ZMSEG09

    WHERE EBELN = LS_OLD_ITEM-EBELN

    AND   EBELP = LS_OLD_ITEM-EBELP

    AND   MATNR = LS_OLD_ITEM-MATNR

    AND   BWART = '101'.



    "## ### ## ## reversal (102) ##

    SELECT SUM( MENGE ) INTO TOTAL_REV

    FROM ZMSEG09

    WHERE EBELN = LS_OLD_ITEM-EBELN

    AND   EBELP = LS_OLD_ITEM-EBELP

    AND   MATNR = LS_OLD_ITEM-MATNR

    AND   BWART = '102'.



    AVAIL_QUAN = TOTAL_GR - TOTAL_REV.



    IF LS_OLD_ITEM-MENGE > AVAIL_QUAN.

      P_SUBRC = 4.

      P_AVAIL = AVAIL_QUAN.

      P_CURR = LS_OLD_ITEM-MENGE.

      RETURN.

    ENDIF.



  ENDLOOP.



  "--------------------------------------------------------------------"

  " 4. ## #### ##(MKPF) ##

  "    - ### MBLNR ##

  "    - ##### ## ###(BUDAT)# ##

  "    - ### = ##(SY-DATUM)

  "--------------------------------------------------------------------"



  "#### ##

  PERFORM GET_MBLNR CHANGING LV_MBLNR_NEW.

  P_MBLNR_NEW = LV_MBLNR_NEW.



  CLEAR : LS_MKPF_NEW.

  LS_MKPF_NEW-MANDT = SY-MANDT.

  LS_MKPF_NEW-MBLNR = LV_MBLNR_NEW.

  LS_MKPF_NEW-MJAHR = GS_HEADER_ALV-BUDAT+0(4). "##### #### ##

  LS_MKPF_NEW-BLART = GS_HEADER_ALV-BLART.

  LS_MKPF_NEW-BLDAT = GS_HEADER_ALV-BLDAT.

  LS_MKPF_NEW-BUDAT = SY-DATUM.                 "### = ##



  APPEND LS_MKPF_NEW TO LT_MKPF_NEW.





  "--------------------------------------------------------------

  " 3-A. ###### ## & ## #### ##(BKPF) ##

  "--------------------------------------------------------------

  PERFORM GET_BELNR CHANGING LV_BELNR_NEW.

  P_BELNR_NEW = LV_BELNR_NEW.



  CLEAR : LS_BKPF_NEW.



  LS_BKPF_NEW-MANDT = SY-MANDT.

  LS_BKPF_NEW-BELNR = LV_BELNR_NEW. "### ####

  LS_BKPF_NEW-GJAHR = LS_MKPF_NEW-MJAHR. "#### ### ##

  LS_BKPF_NEW-BLART = 'WE'. "##

  LS_BKPF_NEW-BLDAT = LS_MKPF_NEW-BLDAT.

  LS_BKPF_NEW-BUDAT = LS_MKPF_NEW-BUDAT.

  LS_BKPF_NEW-XBLNR = P_EBELNS. "###### - PO##



  "####### ####, ### ####

  SELECT SINGLE BUKRS WAERS

  FROM ZEKKO_09

  INTO ( LS_BKPF_NEW-BUKRS, LS_BKPF_NEW-WAERS )

  WHERE EBELN = P_EBELNS.



  APPEND LS_BKPF_NEW TO LT_BKPF_NEW.







  "--------------------------------------------------------------

  " 3-B. ## #### ### (BSEG) ## - ###

  "    - ### ###(ZTBSL09)# ###, "#posting key"# ####

  "    - SHZKG# 'S'# 'H'# ####.

  "--------------------------------------------------------------

  DATA : LS_BSEG_OLD TYPE ZBSEG09,                "## ## ###

         LT_BSEG_OLD LIKE TABLE OF LS_BSEG_OLD.



  DATA : LS_BASE TYPE ZMSEG09. "### MSEG # 101## 1#

  DATA : LT_BSEG_ITEM LIKE STANDARD TABLE OF ZBSEG09.



  DATA : LV_HAS_SUB TYPE ABAP_BOOL.



  "## ## ##

  LV_HAS_SUB = ABAP_FALSE.

  LOOP AT LT_OLD_ITEM INTO LS_OLD_ITEM.

    IF LS_OLD_ITEM-BWART = '543'. "### ## ## = ##

      LV_HAS_SUB = ABAP_TRUE.

      EXIT.

    ENDIF.

  ENDLOOP.



  CLEAR : LT_BSEG_NEW.



  "LT_OLD_ITEM# 101 + 543 ### ##. ###### 101## ##

  LOOP AT LT_OLD_ITEM INTO LS_BASE WHERE BWART = '101'.

    CLEAR : LT_BSEG_ITEM.



    IF LV_HAS_SUB = ABAP_FALSE. "### # -> #### ##

       SELECT *

         FROM ZBSEG09

         INTO CORRESPONDING FIELDS OF TABLE LT_BSEG_ITEM

         WHERE BELNR = LS_BASE-BELNR "#### MSEG-BELNR# ######

         AND   GJAHR = LS_BASE-GJAHR

         AND   ZMBLNR = LS_BASE-MBLNR   "### #### #### ###### ##### ##

         AND   ZMZEILE = LS_BASE-ZEILE.



    ELSEIF LV_HAS_SUB = ABAP_TRUE. "### # -> #### ##




*        SELECT *

*        FROM ZBSEG09

*        INTO CORRESPONDING FIELDS OF TABLE LT_BSEG_ITEM

*        WHERE BELNR = LS_BASE-BELNR "#### MSEG-BELNR# ######

*        AND   GJAHR = LS_BASE-GJAHR.




        SELECT *

        FROM ZBSEG09

        INTO CORRESPONDING FIELDS OF TABLE LT_BSEG_ITEM

        WHERE BELNR = LS_BASE-BELNR

        AND   GJAHR = LS_BASE-GJAHR

        AND   ZMBLNR = LS_BASE-MBLNR "### ####id# ### ####(ZEILE)# ### ## ###### ##

        AND   ZMZEILE = LS_BASE-ZEILE.



    ENDIF.

   "### #### ### ### ##

   LOOP AT LT_BSEG_ITEM INTO LS_BSEG_OLD.

     CLEAR : LS_BSEG_NEW.



     MOVE-CORRESPONDING LS_BSEG_OLD TO LS_BSEG_NEW.



    "# ##### ####

     LS_BSEG_NEW-BELNR = LV_BELNR_NEW.



    "# POSTING KEY ## (ZTBSL09)

    SELECT SINGLE STBSL "### ###

    FROM ZTBSL09

    INTO LS_BSEG_NEW-BSCHL

    WHERE BSCHL = LS_BSEG_OLD-BSCHL "## ###

    AND   KOART = LS_BSEG_OLD-KOART. "####



    "SHKZG #/## ##

    IF LS_BSEG_OLD-SHKZG = 'H'.

      LS_BSEG_NEW-SHKZG = 'S'.

    ELSEIF LS_BSEG_OLD-SHKZG = 'S'.

      LS_BSEG_NEW-SHKZG = 'H'.

    ENDIF.



    APPEND LS_BSEG_NEW TO LT_BSEG_NEW.



   ENDLOOP.



  ENDLOOP.





  "--------------------------------------------------------------------"

  " 5. ## #### ###(MSEG) ##

  "

  "   ## ##:

  "    - # MBLNR / MJAHR ##

  "    - LFBJA/LFBNR/LFPOS# ##(##/##/###) ## ##

  "    - BWART/SHKZG# ### #### ##

  "    - ### ### ##### ### # (MSEG-BELNR)

  "    - #### ## - "## #### ### ## #######"

  "

  "   ##:

  "     101 S # 102 H

  "

  "   ##:

  "     101 S # 102 H (###)

  "     543 H # 544 S (### ## ##)

  "--------------------------------------------------------------------"



  CLEAR : LT_MSEG_NEW, LS_MSEG_NEW.



  LOOP AT LT_OLD_ITEM INTO LS_OLD_ITEM.

    CLEAR : LS_MSEG_NEW.



    "## ## ##

    MOVE-CORRESPONDING LS_OLD_ITEM TO LS_MSEG_NEW.

    LS_MSEG_NEW-BELNR = LV_BELNR_NEW. "## #### ####



    "# ########/##

    LS_MSEG_NEW-MANDT = SY-MANDT.

    LS_MSEG_NEW-MBLNR = LV_MBLNR_NEW.

    LS_MSEG_NEW-MJAHR = LS_MKPF_NEW-MJAHR.



    "## ## ## (LFBJA / LFBNR / LFPOS )

    LS_MSEG_NEW-LFBJA = LS_OLD_ITEM-MJAHR.

    LS_MSEG_NEW-LFBNR = LS_OLD_ITEM-MBLNR.

    LS_MSEG_NEW-LFPOS = LS_OLD_ITEM-ZEILE.



    "#### ###

    CASE LS_OLD_ITEM-BWART.

      WHEN '101'.       "## -> ####

        LS_MSEG_NEW-BWART = '102'.

      WHEN '543'.       "### ## -> ## ##

        LS_MSEG_NEW-BWART = '544'.

      WHEN OTHERS.

        CONTINUE.

    ENDCASE.



    "#/# ## ### ###

    IF LS_OLD_ITEM-SHKZG = 'S'.

      LS_MSEG_NEW-SHKZG = 'H'.

    ELSEIF LS_OLD_ITEM-SHKZG = 'H'.

      LS_MSEG_NEW-SHKZG = 'S'.

    ENDIF.



    "## #### (101)## #### ###

    UPDATE ZMSEG09

      SET ZCANCEL_FLAG = 'X'

      WHERE MBLNR = LS_OLD_ITEM-MBLNR

      AND   ZEILE = LS_OLD_ITEM-ZEILE

      AND   BWART = '101'.



    APPEND LS_MSEG_NEW TO LT_MSEG_NEW.

  ENDLOOP.



  "--------------------------------------------------------------------"

  " 6. DB INSERT

  "    - (TODO) ### ### ## ##/#### INSERT

  "    - P_SUBRC = 0. "## (CANCEL_GOODS# ### ### #)

  "--------------------------------------------------------------------"




*  "## #### ##/###




  INSERT ZMKPF09 FROM TABLE LT_MKPF_NEW.

  INSERT ZMSEG09 FROM TABLE LT_MSEG_NEW.



  "## #### ##/###

  INSERT ZBKPF09 FROM TABLE LT_BKPF_NEW.

  INSERT ZBSEG09 FROM TABLE LT_BSEG_NEW.



  P_SUBRC = 0.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI.

  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    READ TABLE GT_ITEM_ALV INTO GS_ITEM_ALV INDEX LS_MODI-ROW_ID.



    IF SY-SUBRC = 0 AND LS_MODI-FIELDNAME = 'LV_CHECK'.

      GS_ITEM_ALV-LV_CHECK = LS_MODI-VALUE.

      MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX LS_MODI-ROW_ID.

    ENDIF.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_ITEMS

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_ITEMS .

  "### ###

  CALL METHOD GC_GRID_GOODS_ITEM->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID_GOODS_ITEM.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_MKPF

*&---------------------------------------------------------------------*




FORM BUILD_MKPF  USING    P_GF_MBLNR.

  CLEAR : GS_MKPF.



  "#### ## (##)

  GS_MKPF-MANDT = SY-MANDT.

  GS_MKPF-MBLNR = GF_MBLNR. "### ######

  GS_MKPF-MJAHR = GF_MJAHR. "####

  GS_MKPF-BLART = GF_BLART. "####

  GS_MKPF-BLDAT = GF_BLDAT. "###

  GS_MKPF-BUDAT = GF_BUDAT. "###



  APPEND GS_MKPF TO GT_MKPF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_BELNR

*&---------------------------------------------------------------------*




FORM GET_BELNR  CHANGING P_GV_BELNR.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '01'

      OBJECT = 'ZBELNR09_M'

    IMPORTING

      NUMBER = P_GV_BELNR.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_BKPF

*&---------------------------------------------------------------------*




FORM BUILD_BKPF  USING    P_GV_BELNR.

  CLEAR : GS_BKPF.



  "####### ####, ### ####

  SELECT SINGLE BUKRS WAERS

  FROM ZEKKO_09

  INTO ( GS_BKPF-BUKRS, GS_BKPF-WAERS )

  WHERE EBELN = P_EBELNC.





  GS_BKPF-MANDT = SY-MANDT.

  GS_BKPF-BELNR = P_GV_BELNR. "### ####

  GS_BKPF-GJAHR = GF_MJAHR. "####

  GS_BKPF-BLART = 'WE'. "##

  GS_BKPF-BLDAT = GF_BLDAT. "###

  GS_BKPF-BUDAT = GF_BUDAT. "###

  GS_BKPF-XBLNR = P_EBELNC. "###### - PO##



  APPEND GS_BKPF TO GT_BKPF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_MSEG_101_STD

*&---------------------------------------------------------------------*




FORM BUILD_MSEG_101_STD  USING    P_GS_ITEM STRUCTURE GS_ITEM

                         CHANGING LV_LINE_ID.



"### ## ##### - MSEG (PO### 1##, 101 ####, 'S' ####)



  LV_LINE_ID = LV_LINE_ID + 1.



  CLEAR : GS_MSEG.



  GS_MSEG-MANDT = SY-MANDT.



  "###### / ## / #####

  GS_MSEG-MBLNR = GF_MBLNR.

  GS_MSEG-MJAHR = GF_MJAHR.

" GS_MSEG-ZEILE = P_GS_ITEM-EBELP. "PO# ## ### ##

  GS_MSEG-ZEILE = LV_LINE_ID.



  "LINE_ID : 1, 2, 3,....

  GS_MSEG-LINE_ID = LV_LINE_ID.



  "#### 101

  GS_MSEG-BWART = '101'.



  "####, ###, ####

  GS_MSEG-MATNR = P_GS_ITEM-MATNR.

  GS_MSEG-WERKS = P_GS_ITEM-WERKS.

  GS_MSEG-LGORT = P_GS_ITEM-LGORT.



  "####

  GS_MSEG-LIFNR = P_GS_ITEM-LIFNR.



  "## ## : ### 'S'

  GS_MSEG-SHKZG = 'S'.



  "##

  GS_MSEG-WAERS = P_GS_ITEM-WAERS.



  "#### = #### * PO##

  GS_MSEG-DMBTR = P_GS_ITEM-GR_NOW * P_GS_ITEM-STPRS.



  "#### / ##

  GS_MSEG-MENGE = P_GS_ITEM-GR_NOW.

  GS_MSEG-MEINS = P_GS_ITEM-MEINS.



  "PO## ## -> #### ## / ##

  GS_MSEG-EBELN = P_GS_ITEM-EBELN.

  GS_MSEG-EBELP = P_GS_ITEM-EBELP.



  "## ## (101) -> ###### #### (102 ## ## ###)

  GS_MSEG-LFBJA = ''.

  GS_MSEG-LFBNR = ''.

  GS_MSEG-LFPOS = ''.



  "#######  -> #### ### # ####

  IF P_GS_ITEM-GR_REM - P_GS_ITEM-GR_NOW = 0.

    GS_MSEG-ELIKZ = 'X'.

  ELSE.

    GS_MSEG-ELIKZ = ''.

  ENDIF.



  "FI ####

  GS_MSEG-GJAHR = GF_MJAHR.



  "#### (PO ##)

  SELECT SINGLE BUKRS

  FROM ZEKKO_09

  INTO GS_MSEG-BUKRS

  WHERE EBELN = P_GS_ITEM-EBELN.



  "##### (##### ## #### = 'B'

  GS_MSEG-KZBEW = 'B'.



  "#### (##### ####)

  GS_MSEG-BELNR = GV_BELNR.



  APPEND GS_MSEG TO GT_MSEG.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_BSEG_STD

*&---------------------------------------------------------------------*




FORM BUILD_BSEG_STD  USING    P_GS_ITEM STRUCTURE GS_ITEM

                              LV_LINE_ID

                     CHANGING LV_BUZEI.

"### ## ##### - BSEG (PO## 1## 2## (#/##), #### ####, ####### ###)

"#) #### BSX

"#) GR/IR #### WRX



  "##### ####

  LV_BUZEI = LV_BUZEI + 1.



  "========================================================

  " ##  BSX  ## ##

  "========================================================

  CLEAR : GS_BSEG.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = LV_BUZEI.



  GS_BSEG-BUZID = 'M'. " M - #### ##



  GS_BSEG-BSCHL = '89'. "### 89 = Debit, Material

  GS_BSEG-KOART = 'M'.  "Material

  GS_BSEG-SHKZG = 'S'.  "Debit



  "## / ##

  GS_BSEG-DMBTR = P_GS_ITEM-GR_NOW * P_GS_ITEM-STPRS.

  GS_BSEG-WRBTR = GS_BSEG-DMBTR.

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  "#####

  GS_BSEG-KTOSL = 'BSX'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  "#### G/L ## ##

  GS_BSEG-HKONT = '11051010'. "######



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "##### ### ####ID# ##

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_LINE_ID.



  APPEND GS_BSEG TO GT_BSEG.



  "========================================================

  " ## - WRX - GR/IR #### ##

  "========================================================

  CLEAR : GS_BSEG.



  LV_BUZEI = LV_BUZEI + 1.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = LV_BUZEI.



  GS_BSEG-BUZID = 'W'. " W - GR/IR ##



  GS_BSEG-BSCHL = '96'. "### 96 = Credit, G/L Account

  GS_BSEG-KOART = 'S'.  "G/L Account

  GS_BSEG-SHKZG = 'H'.  "Credit



  "## / ## -> Debit# ##

  GS_BSEG-DMBTR = P_GS_ITEM-GR_NOW * P_GS_ITEM-STPRS.

  GS_BSEG-WRBTR = GS_BSEG-DMBTR.

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  "#####

  GS_BSEG-KTOSL = 'WRX'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  "#### G/L ## ##

  GS_BSEG-HKONT = '93000030'. "###### (GR/IR ##)



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "##### ### ####ID# ##

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_LINE_ID.





  APPEND GS_BSEG TO GT_BSEG.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*




FORM CHECK_INPUT  CHANGING LV_SUBRC.

  DATA : LV_CHECKED TYPE ABAP_BOOL VALUE ABAP_FALSE.



  LOOP AT GT_ITEM INTO GS_ITEM.

    IF GS_ITEM-L_CHECK = 'X'.

      LV_CHECKED = ABAP_TRUE.

    ENDIF.



    IF ( GS_ITEM-L_CHECK = 'X' ) AND ( GS_ITEM-GR_NOW <= 0 ).

      MESSAGE '## ##### ######.' TYPE 'I'.

      LV_SUBRC = 2.

      RETURN.

    ENDIF.

  ENDLOOP.



  IF LV_CHECKED = ABAP_FALSE.

    MESSAGE '## ## ### ### ######.' TYPE 'I'.

    LV_SUBRC = 2.

    RETURN.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_TO_DB

*&---------------------------------------------------------------------*




FORM SAVE_TO_DB .

  "1) #### ## ##

  INSERT ZMKPF09 FROM TABLE GT_MKPF.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ## ##' TYPE 'E'.

    ROLLBACK WORK.

    RETURN.

  ENDIF.



  "2) #### ### ##

  INSERT ZMSEG09 FROM TABLE GT_MSEG.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ### ## ##' TYPE 'E'.

    ROLLBACK WORK.

    RETURN.

  ENDIF.



  "3) #### ## ##

  INSERT ZBKPF09 FROM TABLE GT_BKPF.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ## ##' TYPE 'E'.

    ROLLBACK WORK.

    RETURN.

  ENDIF.



  "4) #### ### ##

  INSERT ZBSEG09 FROM TABLE GT_BSEG.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ### ## ##' TYPE 'E'.

    ROLLBACK WORK.

    RETURN.

  ENDIF.



  "5) ## ## ## # COMMIT

  COMMIT WORK.



  MESSAGE |#### { GF_MBLNR } / #### { GV_BELNR } #######| TYPE 'S'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_MSEG_101_OUTS

*&---------------------------------------------------------------------*




FORM BUILD_MSEG_101_OUTS  USING    P_GS_ITEM STRUCTURE GS_ITEM

                          CHANGING LV_LINE_ID.

"### - MSEG (PO### 1##, 101 ####, 'S' ####)



  LV_LINE_ID = LV_LINE_ID + 1.



  CLEAR : GS_MSEG.



  GS_MSEG-MANDT = SY-MANDT.



  "###### / ## / #####

  GS_MSEG-MBLNR = GF_MBLNR.

  GS_MSEG-MJAHR = GF_MJAHR.

  GS_MSEG-ZEILE = LV_LINE_ID.



  "LINE_ID : 1, 2, 3,...

  GS_MSEG-LINE_ID = LV_LINE_ID.



  "### ### ##

  GS_MSEG-PARENT_ID = ''.



  "#### 101 (### ##)

  GS_MSEG-BWART = '101'.



  "####, ###, ####

  GS_MSEG-MATNR = P_GS_ITEM-MATNR.

  GS_MSEG-WERKS = P_GS_ITEM-WERKS.

  GS_MSEG-LGORT = P_GS_ITEM-LGORT.



  "####### (#### #### ##)

  GS_MSEG-SOBKZ = ''.



  "####

  GS_MSEG-LIFNR = P_GS_ITEM-LIFNR.



  "## ## : ### 'S'

  GS_MSEG-SHKZG = 'S'.



  "##

  GS_MSEG-WAERS = P_GS_ITEM-WAERS.



  "#### = #### * PO##

  GS_MSEG-DMBTR = P_GS_ITEM-GR_NOW * P_GS_ITEM-STPRS.



  "#### / ##

  GS_MSEG-MENGE = P_GS_ITEM-GR_NOW.

  GS_MSEG-MEINS = P_GS_ITEM-MEINS.



  "PO## ## -> #### ## / ##

  GS_MSEG-EBELN = P_GS_ITEM-EBELN.

  GS_MSEG-EBELP = P_GS_ITEM-EBELP.



  "## ## (101) -> ###### #### (102 ## ## ###)

  GS_MSEG-LFBJA = ''.

  GS_MSEG-LFBNR = ''.

  GS_MSEG-LFPOS = ''.



  "#######  -> #### ### # ####

  IF P_GS_ITEM-GR_REM - P_GS_ITEM-GR_NOW = 0.

    GS_MSEG-ELIKZ = 'X'.

  ELSE.

    GS_MSEG-ELIKZ = ''.

  ENDIF.



  "FI ####

  GS_MSEG-GJAHR = GF_MJAHR.



  "#### (PO ##)

  SELECT SINGLE BUKRS

  FROM ZEKKO_09

  INTO GS_MSEG-BUKRS

  WHERE EBELN = P_GS_ITEM-EBELN.



  "##### (##### ## #### = 'B')

  GS_MSEG-KZBEW = 'B'.



  "#### (##### ####)

  GS_MSEG-BELNR = GV_BELNR.



  APPEND GS_MSEG TO GT_MSEG.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  BUILD_MSEG_543_CONS

*&---------------------------------------------------------------------*




FORM BUILD_MSEG_543_CONS  USING    P_GS_ITEM STRUCTURE GS_ITEM

                          CHANGING P_LV_LINE_ID.



  DATA : LV_STLNR LIKE ZMAST09-STLNR. "BOM ID

  DATA : LS_BOM TYPE ZSTPO09,

         LT_BOM LIKE TABLE OF LS_BOM,

         LV_STPRS LIKE ZMARA09-STPRS,

         LV_PARENT_ID TYPE N LENGTH 3,

         LV_CONS_QTY TYPE MENGE_D,

         LV_DMBTR LIKE ZMSEG09-DMBTR.



  " ## ### 101 ### LINE_ID# PARENT_ID# ##

  LV_PARENT_ID = P_LV_LINE_ID.



  "1. ### MATNR -> BOM ID (ZMAST09)## ##

  SELECT SINGLE STLNR

  FROM ZMAST09

  INTO LV_STLNR

  WHERE MATNR = P_GS_ITEM-MATNR.





  IF SY-SUBRC <> 0.

    RETURN.

  ENDIF.





  "2. ## BOM ID# ### ## ##

  SELECT *

  FROM ZSTPO09

  INTO CORRESPONDING FIELDS OF TABLE LT_BOM

  WHERE STLNR = LV_STLNR.



  CLEAR : LS_BOM.

  LOOP AT LT_BOM INTO LS_BOM.

    "3. ### ## ## (ZMARA09)

    SELECT SINGLE STPRS

    FROM ZMARA09

    INTO LV_STPRS

    WHERE ZMATNR = LS_BOM-IDNRK. "#### #/### ## ##



    IF SY-SUBRC <> 0.

      LV_STPRS = 0.

    ENDIF.



    "4. ### ## 543 MSEG ### - #### #/###(IDNRK) ####

    CLEAR : GS_MSEG.

    P_LV_LINE_ID = P_LV_LINE_ID + 1.



    GS_MSEG-MANDT = SY-MANDT.

    GS_MSEG-MBLNR = GF_MBLNR.

    GS_MSEG-MJAHR = GF_MJAHR.

    GS_MSEG-ZEILE = P_LV_LINE_ID. "543# PO#### ##



    "LINE_ID : 1,2,3,4.. (101## ###)

    GS_MSEG-LINE_ID = P_LV_LINE_ID.



    "PARENT_ID : ### 101 ### ##

    GS_MSEG-PARENT_ID = LV_PARENT_ID.



    GS_MSEG-BWART = '543'.        "### ##

    GS_MSEG-MATNR = LS_BOM-IDNRK. "### ##

    GS_MSEG-WERKS = P_GS_ITEM-WERKS.

    GS_MSEG-LGORT = P_GS_ITEM-LGORT.

    GS_MSEG-LIFNR = P_GS_ITEM-LIFNR. "####



    GS_MSEG-SOBKZ = 'O'. "#######

    GS_MSEG-SHKZG = 'H'. "## ##



    GS_MSEG-WAERS = P_GS_ITEM-WAERS.



    " #### - BOM.MENGE * ## ####(GR_NOW)

    " DMBTR = #### * #####(from MARA)

    LV_CONS_QTY = LS_BOM-MENGE * P_GS_ITEM-GR_NOW.



    GS_MSEG-MENGE = LV_CONS_QTY.

    GS_MSEG-MEINS = LS_BOM-MEINS.



    LV_DMBTR = LV_CONS_QTY * LV_STPRS.

    GS_MSEG-DMBTR = LV_DMBTR.



    "PO## ## -> #### ## / ##

    GS_MSEG-EBELN = P_GS_ITEM-EBELN.

    GS_MSEG-EBELP = P_GS_ITEM-EBELP.



    "###### #### (102 ## ## ###)

    GS_MSEG-LFBJA = ''.

    GS_MSEG-LFBNR = ''.

    GS_MSEG-LFPOS = ''.



    "FI##

    GS_MSEG-GJAHR = GF_MJAHR.

    GS_MSEG-BUKRS = GS_BKPF-BUKRS.

    GS_MSEG-BELNR = GV_BELNR.



    APPEND GS_MSEG TO GT_MSEG.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_BSEG_OUTS

*&---------------------------------------------------------------------*




FORM BUILD_BSEG_OUTS  USING    P_GS_ITEM STRUCTURE GS_ITEM

                               LV_ZMZEILE

                      CHANGING P_LV_LINE_ID_B.



  DATA : LV_CONS_COST TYPE DMBTR, "### ## ##

         LV_PROC_COST TYPE DMBTR, "#### ##

         LV_MAT_COST TYPE DMBTR.  "### ## = #### + ###



  CLEAR : LV_CONS_COST.



  " 543 #### SUM (GT_MSEG)## ##

  CLEAR : GS_MSEG.

  LOOP AT GT_MSEG INTO GS_MSEG WHERE BWART = '543'.

    LV_CONS_COST = LV_CONS_COST + GS_MSEG-DMBTR.

  ENDLOOP.



  " #### = ## #### * PO ## (#### ##)

  LV_PROC_COST = P_GS_ITEM-GR_NOW * P_GS_ITEM-STPRS.



  " ### ## = #### + ###

  LV_MAT_COST = LV_CONS_COST + LV_PROC_COST.





  "#### 6#



  "===============================================================

  " (1) #) BSX ##### ##

  "===============================================================

  P_LV_LINE_ID_B  = P_LV_LINE_ID_B + 1.

  CLEAR GS_BSEG.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = P_LV_LINE_ID_B.



  GS_BSEG-BUZID = 'M'. " M - #### ##

  GS_BSEG-BSCHL = '89'. "### 89 = Debit, Material

  GS_BSEG-KOART = 'M'.  "Material

  GS_BSEG-SHKZG = 'S'.  "Debit

  GS_BSEG-DMBTR = LV_MAT_COST. "### ##

  GS_BSEG-WRBTR = LV_MAT_COST. "### ##

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  GS_BSEG-KTOSL = 'BSX'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  GS_BSEG-HKONT = '11051010'. "#### (BSX)



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "ZMBLNR : #### ##, ZMZEILE : #### ZEILE

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_ZMZEILE.

  APPEND GS_BSEG TO GT_BSEG.





  "===============================================================

  " (2) #) BSV ######

  "===============================================================



  P_LV_LINE_ID_B  = P_LV_LINE_ID_B + 1.

  CLEAR GS_BSEG.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = P_LV_LINE_ID_B.



  GS_BSEG-BUZID = 'S'. " S - ##/##/## ####

  GS_BSEG-BSCHL = '91'. "### 91 (Cost) - Credit, G/L Account

  GS_BSEG-KOART = 'S'.  "G/L Account

  GS_BSEG-SHKZG = 'H'.  "Credit

  GS_BSEG-DMBTR = LV_MAT_COST. "### ##

  GS_BSEG-WRBTR = LV_MAT_COST. "### ##

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  GS_BSEG-KTOSL = 'BSV'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  GS_BSEG-HKONT = '95000100'. "GR/IR ## (WRX)



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "ZMBLNR : #### ##, ZMZEILE : #### ZEILE

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_ZMZEILE.



  APPEND GS_BSEG TO GT_BSEG.





  "===============================================================

  " (3) #) GBB ### ##

  "===============================================================

  P_LV_LINE_ID_B  = P_LV_LINE_ID_B + 1.

  CLEAR GS_BSEG.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = P_LV_LINE_ID_B.



  GS_BSEG-BUZID = 'S'. " S - ##/##/## ####

  GS_BSEG-BSCHL = '81'. "### 81 (Cost) - Debit, G/L Account

  GS_BSEG-KOART = 'S'.  "G/L Account

  GS_BSEG-SHKZG = 'S'.  "Debit

  GS_BSEG-DMBTR = LV_CONS_COST. "### ####

  GS_BSEG-WRBTR = LV_CONS_COST. "### ####

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  GS_BSEG-KTOSL = 'GBB'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  GS_BSEG-HKONT = '95000040'. "### ## ## (GBB)



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "ZMBLNR : #### ##, ZMZEILE : #### ZEILE

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_ZMZEILE.

  APPEND GS_BSEG TO GT_BSEG.



  "===============================================================

  " (4) #) BSX ### ## ##

  "===============================================================

  P_LV_LINE_ID_B  = P_LV_LINE_ID_B + 1.

  CLEAR GS_BSEG.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = P_LV_LINE_ID_B.



  GS_BSEG-BUZID = 'M'. " M - #### ##

  GS_BSEG-BSCHL = '99'. "### 99 (Stock Outwd Movement) - Credit, Material

  GS_BSEG-KOART = 'M'.  "Material

  GS_BSEG-SHKZG = 'H'.  "Credit

  GS_BSEG-DMBTR = LV_CONS_COST. "### ####

  GS_BSEG-WRBTR = LV_CONS_COST. "### ####

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  GS_BSEG-KTOSL = 'BSX'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  GS_BSEG-HKONT = '11051040'. "## ## (BSX)



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "ZMBLNR : #### ##, ZMZEILE : #### ZEILE

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_ZMZEILE.



  APPEND GS_BSEG TO GT_BSEG.



  "===============================================================

  " (5) #) FRL #### ##

  "===============================================================

  P_LV_LINE_ID_B  = P_LV_LINE_ID_B + 1.

  CLEAR GS_BSEG.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = P_LV_LINE_ID_B.



  GS_BSEG-BUZID = 'S'. " S - ##/##/## ####

  GS_BSEG-BSCHL = '86'. "### 86 (	GR\IR Debit ) - Debit, G/L Account

  GS_BSEG-KOART = 'S'.  "G/L Account

  GS_BSEG-SHKZG = 'S'.  "Debit

  GS_BSEG-DMBTR = LV_PROC_COST. "#### ##

  GS_BSEG-WRBTR = LV_PROC_COST. "#### ##

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  GS_BSEG-KTOSL = 'FRL'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  GS_BSEG-HKONT = '95000050'. "### #### (FRL)



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "ZMBLNR : #### ##, ZMZEILE : #### ZEILE

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_ZMZEILE.



  APPEND GS_BSEG TO GT_BSEG.



  "===============================================================

  " (6) #) WRX GR/IR ####

  "===============================================================

  P_LV_LINE_ID_B  = P_LV_LINE_ID_B + 1.

  CLEAR GS_BSEG.



  GS_BSEG-MANDT = SY-MANDT.

  GS_BSEG-BUKRS = GS_BKPF-BUKRS. "####

  GS_BSEG-BELNR = GS_BKPF-BELNR. "######

  GS_BSEG-GJAHR = GS_BKPF-GJAHR. "####

  GS_BSEG-BUZEI = P_LV_LINE_ID_B.



  GS_BSEG-BUZID = 'W'. " W - WRX (GR/IR ##) ##

  GS_BSEG-BSCHL = '96'. "### 96 (	GR\IR Credit ) - Credit, G/L Account

  GS_BSEG-KOART = 'S'.  "G/L Account

  GS_BSEG-SHKZG = 'H'.  "Credit

  GS_BSEG-DMBTR = LV_PROC_COST. "#### ##

  GS_BSEG-WRBTR = LV_PROC_COST. "#### ##

  GS_BSEG-PSWSL = GS_BKPF-WAERS.



  GS_BSEG-KTOSL = 'WRX'. "#### #

  GS_BSEG-VORGN = 'RMWE'. "##### #### (RMWE = ####)



  GS_BSEG-HKONT = '93000030'. "GR/IR ## (WRX)



  "#### (PO##)

  GS_BSEG-LIFNR = P_GS_ITEM-LIFNR.



  "ZMBLNR : #### ##, ZMZEILE : #### ZEILE

  GS_BSEG-ZMBLNR = GF_MBLNR.

  GS_BSEG-ZMZEILE = LV_ZMZEILE.



  APPEND GS_BSEG TO GT_BSEG.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_CELL_STYLE

*&---------------------------------------------------------------------*




FORM SET_CELL_STYLE .

  DATA : LS_STYLE TYPE LVC_S_STYL,

         LT_STYLE LIKE TABLE OF LS_STYLE.



  LOOP AT GT_ITEM_ALV ASSIGNING FIELD-SYMBOL(<FS_ROW>).

    CLEAR : LT_STYLE.



    "543# ## #### ####

    IF <FS_ROW>-BWART = '543'.

      LS_STYLE-FIELDNAME = 'LV_CHECK'.

      LS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.



      APPEND LS_STYLE TO LT_STYLE.

    ENDIF.



    <FS_ROW>-STYLE = LT_STYLE.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  LATOUT_ITEMS

*&---------------------------------------------------------------------*




FORM LATOUT_ITEMS .

  CLEAR : GS_LAYOUT.



  GS_LAYOUT-STYLEFNAME = 'STYLE'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SHOW_FI_LIST

*&---------------------------------------------------------------------*




FORM SHOW_FI_LIST .

  "### 200## ## ## ##### #### ### ###




*  DATA : LO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

*         LO_ALV       TYPE REF TO CL_GUI_ALV_GRID.






  DATA : LS_FIELDCAT TYPE LVC_S_FCAT,

         LT_FIELDCAT TYPE LVC_T_FCAT.



  DATA : LT_TOOLBAR TYPE UI_FUNCTIONS.



  IF GO_CONT_300 IS INITIAL.



    CREATE OBJECT GO_CONT_300

      EXPORTING

        CONTAINER_NAME = 'CC_FI_LIST'.



    CREATE OBJECT GO_ALV_300

      EXPORTING

        I_PARENT = GO_CONT_300.



    "field catalog

    CLEAR : LS_FIELDCAT, LT_FIELDCAT.

    LS_FIELDCAT-COL_POS = 1.

    LS_FIELDCAT-FIELDNAME = 'BELNR'.

    LS_FIELDCAT-COLTEXT = '## ##'.

    APPEND LS_FIELDCAT TO LT_FIELDCAT.



    CLEAR : LS_FIELDCAT.

    LS_FIELDCAT-COL_POS = 2.

    LS_FIELDCAT-FIELDNAME = 'OBJTYPETXT'.

    LS_FIELDCAT-COLTEXT = 'ObjTypeTxt'.

    APPEND LS_FIELDCAT TO LT_FIELDCAT.



    "## ### ###

    APPEND CL_GUI_ALV_GRID=>MC_FC_EXCL_ALL TO LT_TOOLBAR.



    "### ## ## ## - #####, #### ## 400## ##### ..

    PERFORM CLASS_EVENT_300.



    CALL METHOD GO_ALV_300->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IT_TOOLBAR_EXCLUDING = LT_TOOLBAR

      CHANGING

        IT_OUTTAB = GT_FI_LIST

        IT_FIELDCATALOG = LT_FIELDCAT.





  ELSE.

    GO_ALV_300->REFRESH_TABLE_DISPLAY( ).

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_FI_LIST

*&---------------------------------------------------------------------*




FORM GET_FI_LIST  USING    P_MBLNR

                  CHANGING P_LT_FI_LIST LIKE GT_FI_LIST.

  DATA : LS_FI_LIST TYPE TY_FI_LIST.



  "## ### ##### ### #### ####

  SELECT DISTINCT BELNR

  FROM ZMSEG09

  INTO CORRESPONDING FIELDS OF TABLE P_LT_FI_LIST

  WHERE MBLNR = P_MBLNR.



  LOOP AT P_LT_FI_LIST INTO LS_FI_LIST.

    LS_FI_LIST-OBJTYPETXT = '## ##'.



    MODIFY P_LT_FI_LIST FROM LS_FI_LIST INDEX SY-TABIX.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_300

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_300 .

  CREATE OBJECT GO_EVENT_300.



  SET HANDLER GO_EVENT_300->HANDLER_DOUBLE_CLICK_300 FOR GO_ALV_300.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLE_CLICK_300

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DOUBLE_CLICK_300  USING    P_E_ROW TYPE LVC_S_ROW

                                            P_E_COLUMN TYPE LVC_S_COL "#(column) ## ##

                                            P_ES_ROW_NO TYPE LVC_S_ROID.  "#(row) ## ##



  " GT_FI_LIST, GV_SEL_BELNR



  DATA : LS_FI TYPE TY_FI_LIST.



  READ TABLE GT_FI_LIST INTO LS_FI INDEX P_ES_ROW_NO-ROW_ID.

  IF SY-SUBRC <> 0.

    RETURN.

  ENDIF.



  " ### #### ## ##

  GV_SEL_BELNR = LS_FI-BELNR.



  " ## ## #### ##

  CALL SCREEN 400.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PREPARE_FI_DISPLAY

*&---------------------------------------------------------------------*




FORM PREPARE_FI_DISPLAY .

  CLEAR : GT_SEL_MSEG.

  DATA : LS_SEL_MSEG TYPE ZMSEG09.



  "### ##### ### ## ##

  CLEAR : GT_SEL_MSEG.



  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

    SELECT SINGLE *

    FROM ZMSEG09

    INTO CORRESPONDING FIELDS OF LS_SEL_MSEG

    WHERE MBLNR = GS_HEADER_ALV-MBLNR

    AND   ZEILE = GS_ITEM_ALV-ZEILE.



    IF SY-SUBRC = 0.

      APPEND LS_SEL_MSEG TO GT_SEL_MSEG.

    ENDIF.



  ENDLOOP.



  IF GT_SEL_MSEG IS INITIAL.

    MESSAGE '### # ## ### ######.' TYPE 'I'.

    LEAVE TO SCREEN 0.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_BKPF

*&---------------------------------------------------------------------*




FORM GET_BKPF .

  CLEAR : GS_BKPF_400.



  SELECT SINGLE *

  FROM ZBKPF09

  INTO CORRESPONDING FIELDS OF GS_BKPF_400

  WHERE BELNR = GV_SEL_BELNR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SHOW_BSEG_ALV

*&---------------------------------------------------------------------*




FORM SHOW_BSEG_ALV .

  IF GO_CONT_400 IS INITIAL.

    CREATE OBJECT GO_CONT_400

      EXPORTING CONTAINER_NAME = 'CC_BSEG'.



    CREATE OBJECT GO_ALV_400

      EXPORTING I_PARENT = GO_CONT_400.



    PERFORM BUILD_FIELDCAT_400.



    PERFORM LAYOUT_400.



    PERFORM SORT_400.



    CALL METHOD GO_ALV_400->SET_TABLE_FOR_FIRST_DISPLAY




*      EXPORTING

*        IS_LAYOUT = GS_LATOUT_400




      CHANGING

        IT_OUTTAB = GT_BSEG_400_ALV

        IT_SORT   = GT_SORT_400

        IT_FIELDCATALOG = GT_FIELDCAT_400.

  ELSE.

    GO_ALV_400->REFRESH_TABLE_DISPLAY( ).



  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  BUILD_FIELDCAT_400

*&---------------------------------------------------------------------*




FORM BUILD_FIELDCAT_400 .

  CLEAR : GS_FIELDCAT_400, GT_FIELDCAT_400.



  GS_FIELDCAT_400-COL_POS = 1.

  GS_FIELDCAT_400-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT_400-COLTEXT = 'CoCd'. "####

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 2.

  GS_FIELDCAT_400-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT_400-COLTEXT = '##'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 3.

  GS_FIELDCAT_400-FIELDNAME = 'BSCHL'. "###

  GS_FIELDCAT_400-COLTEXT = '#'.

 APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 4.

  GS_FIELDCAT_400-FIELDNAME = 'KOART'. "####

  GS_FIELDCAT_400-COLTEXT = 'SG'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 5.

  GS_FIELDCAT_400-FIELDNAME = 'SHKZG'.

  GS_FIELDCAT_400-COLTEXT = '##/## ###'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 6.

  GS_FIELDCAT_400-FIELDNAME = 'HKONT'.

  GS_FIELDCAT_400-COLTEXT = '##'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 7.

  GS_FIELDCAT_400-FIELDNAME = 'TXT1'.

  GS_FIELDCAT_400-COLTEXT = '##'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 8.

  GS_FIELDCAT_400-FIELDNAME = 'HKONT2'.

  GS_FIELDCAT_400-COLTEXT = 'G/L ##'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 9.

  GS_FIELDCAT_400-FIELDNAME = 'TXT2'.

  GS_FIELDCAT_400-COLTEXT = 'G/L ###'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 10.

  GS_FIELDCAT_400-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT_400-DO_SUM   = 'X'.

  GS_FIELDCAT_400-COLTEXT = '##'.

  GS_FIELDCAT_400-CFIELDNAME = 'PSWSL'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 11.

  GS_FIELDCAT_400-FIELDNAME = 'PSWSL'.

  GS_FIELDCAT_400-COLTEXT = '##'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 12.

  GS_FIELDCAT_400-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT_400-DO_SUM   = 'X'.

  GS_FIELDCAT_400-COLTEXT = '## ## ##'.

  GS_FIELDCAT_400-CFIELDNAME = 'PSWSL2'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT_400-COL_POS = 13.

  GS_FIELDCAT_400-FIELDNAME = 'PSWSL2'.

  GS_FIELDCAT_400-COLTEXT = '## ##'.

  APPEND GS_FIELDCAT_400 TO GT_FIELDCAT_400.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_BSEG

*&---------------------------------------------------------------------*




FORM GET_BSEG .



  DATA : GS_SEL_MSEG TYPE ZMSEG09.



  CLEAR : GT_BSEG_400.






*  IF GV_FI_VIEW_MODE = 'R'. "### ## : #### ##

*    SELECT *

*    FROM ZBSEG09

*    INTO CORRESPONDING FIELDS OF TABLE GT_BSEG_400

*    WHERE BELNR = GV_SEL_BELNR.

*

*    CLEAR : GV_FI_VIEW_MODE.

*

*  ELSE. "## ## : "### ##### '####' ##### #### #






    IF GT_SEL_MSEG IS NOT INITIAL.

      SELECT *

      FROM ZBSEG09

      INTO CORRESPONDING FIELDS OF TABLE GT_BSEG_400

      FOR ALL ENTRIES IN GT_SEL_MSEG

      WHERE BELNR = GV_SEL_BELNR

      AND   ZMBLNR = GT_SEL_MSEG-MBLNR

      AND   ZMZEILE = GT_SEL_MSEg-ZEILE.

    ENDIF.






*  ENDIF.






  "## # # #### GT_BSEG_400_ALV ####

  DATA : LV_SAKNR TYPE ZSKA109-SAKNR.



  CLEAR : GS_BSEG_400, GS_BSEG_400_ALV, GT_BSEG_400_ALV.

  LOOP AT GT_BSEG_400 INTO GS_BSEG_400.

    MOVE-CORRESPONDING GS_BSEG_400 TO GS_BSEG_400_ALV.



    "### ##### ### 0## ### #

    LV_SAKNR = GS_BSEG_400-HKONT.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT = LV_SAKNR

      IMPORTING

        OUTPUT = LV_SAKNR.



    SELECT SINGLE TEXT

    FROM ZSKA109

    INTO GS_BSEG_400_ALV-TXT1

    WHERE SAKNR = LV_SAKNR.



    GS_BSEG_400_ALV-TXT2 = GS_BSEG_400_ALV-TXT1.      "##

    GS_BSEG_400_ALV-HKONT2 = GS_BSEG_400_ALV-HKONT.   "## ##

    GS_BSEG_400_ALV-PSWSL2 = GS_BSEG_400_ALV-PSWSL.    "## ##



    "## ## ##

    IF GS_BSEG_400_ALV-SHKZG = 'H'.

      GS_BSEG_400_ALV-DMBTR = GS_BSEG_400_ALV-DMBTR * -1.

      GS_BSEG_400_ALV-WRBTR = GS_BSEG_400_ALV-WRBTR * -1.

    ENDIF.



    APPEND GS_BSEG_400_ALV TO GT_BSEG_400_ALV.



  ENDLOOP.







ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SORT_400

*&---------------------------------------------------------------------*




FORM SORT_400 .

  CLEAR : GS_SORT_400.



  GS_SORT_400-FIELDNAME = 'SHKZG'.

  GS_SORT_400-DOWN = 'X'.

  GS_SORT_400-SUBTOT = 'X'.



  APPEND GS_SORT_400 TO GT_SORT_400.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  LAYOUT_400

*&---------------------------------------------------------------------*




FORM LAYOUT_400 .

  CLEAR : GS_LATOUT_400.



  GS_LATOUT_400-ZEBRA = 'X'.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FILL_CANCEL_STATUS

*&---------------------------------------------------------------------*




FORM FILL_CANCEL_STATUS .

  DATA : LV_CANCEL_FLAG TYPE C.



  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV.



    SELECT SINGLE ZCANCEL_FLAG

    FROM ZMSEG09

    INTO LV_CANCEL_FLAG

    WHERE MBLNR = GS_HEADER_ALV-MBLNR

    AND   ZEILE = GS_ITEM_ALV-ZEILE

    AND   BWART = '101'.



    IF LV_CANCEL_FLAG = 'X'.

     GS_ITEM_ALV-CANCEL_TEXT = '## ###'.

    ELSE.

     GS_ITEM_ALV-CANCEL_TEXT = '####'.

    ENDIF.



    IF GS_ITEM_ALV-BWART = '101'. "543 ##### ## ####

     MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_REV_BELNR_LIST

*&---------------------------------------------------------------------*




TYPES: TT_REV_BELNR TYPE SORTED TABLE OF ZBKPF09-BELNR

                    WITH UNIQUE KEY TABLE_LINE.



FORM GET_REV_BELNR_LIST  CHANGING P_LT_REV_BELNR TYPE TT_REV_BELNR.





  IF GT_SEL_MSEG IS NOT INITIAL.



    SELECT DISTINCT BELNR

    FROM ZMSEG09

    INTO TABLE P_LT_REV_BELNR

    FOR ALL ENTRIES IN GT_SEL_MSEG

    WHERE LFBNR = GT_SEL_MSEG-MBLNR "####### LFBNR# ## ####ID# ##

    AND   LFPOS = GT_SEL_MSEG-ZEILE "####### LFPOS# ## ######## ##

    AND   BWART = '102'. "## #### ##



  ENDIF.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  BUILD_FCAT_410

*&---------------------------------------------------------------------*




FORM BUILD_FCAT_410 .



  CLEAR : GS_FCAT_410, GT_FCAT_410.



  GS_FCAT_410-FIELDNAME = 'BELNR'.

  GS_FCAT_410-COLTEXT = '######'.



  APPEND GS_FCAT_410 TO GT_FCAT_410.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_410

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_410 .

  CREATE OBJECT GO_EVENT_410.



  SET HANDLER GO_EVENT_410->HANDLER_DOUBLE_CLICK_410 FOR GO_ALV_410.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLE_CLICK_410

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DOUBLE_CLICK_410  USING    P_E_ROW TYPE LVC_S_ROW

                                            P_E_COLUMN TYPE LVC_S_COL "#(column) ## ##

                                            P_ES_ROW_NO TYPE LVC_S_ROID.  "#(row) ## ##





  READ TABLE GT_REV_BELNR INTO GV_SEL_BELNR INDEX P_ES_ROW_NO-ROW_ID.

  IF SY-SUBRC <> 0.

    RETURN.

  ENDIF.



  LEAVE TO SCREEN 0. "410 ##





ENDFORM.