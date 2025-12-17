
*&---------------------------------------------------------------------*

*&  Include           ZMM15_003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_MBLNR

*&---------------------------------------------------------------------*

*       ##### ## ###### ####

*----------------------------------------------------------------------*




FORM GET_MBLNR .

  "DISTINCT## ## -> ### MBLNR# ### ###.

  SELECT DISTINCT MBLNR

    FROM ZMSEG_15

    INTO TABLE GT_LIST

    WHERE WERKS = P_WERKS

    AND EBELN = P_EBELN

    AND BWART = '101'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_LIST

*&---------------------------------------------------------------------*






FORM CREATE_OBJECT_LIST .

  CREATE OBJECT GC_CUSTOM_LIST

    EXPORTING

      CONTAINER_NAME = 'CON02'.



  CREATE OBJECT GC_GRID_LIST

    EXPORTING

      I_PARENT = GC_CUSTOM_LIST.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_LIST

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_LIST .

  CLEAR : GS_FIELDCAT_LIST, GT_FIELDCAT_LIST.



  GS_FIELDCAT_LIST-COL_POS = 1.

  GS_FIELDCAT_LIST-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT_LIST-COLTEXT = '######'.

  GS_FIELDCAT_LIST-OUTPUTLEN = 20.



  APPEND GS_FIELDCAT_LIST TO GT_FIELDCAT_LIST.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_LIST

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_LIST .

    CALL METHOD GC_GRID_LIST->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_LIST

      IT_FIELDCATALOG               = GT_FIELDCAT_LIST.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_LIST

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_LIST .

  CALL METHOD GC_GRID_LIST->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED

      .



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DOUBLE_CLICK FOR GC_GRID_LIST.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LV_HANDLER_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       ###### #####

*----------------------------------------------------------------------*




FORM LV_HANDLER_DOUBLE_CLICK  USING   P_E_ROW TYPE LVC_S_ROW

                                      P_E_COLUMN TYPE LVC_S_COL.

  DATA : LS_LIST LIKE GS_LIST.



  CLEAR : GT_ALV200.



  "##### ### # ##

  READ TABLE GT_LIST INTO LS_LIST INDEX P_E_ROW-INDEX.

  CHECK SY-SUBRC = 0.



    "DB## ## ##, ### ## #### ###

  PERFORM GET_GR_HEAD USING LS_LIST-MBLNR.



  PERFORM GET_GR_ITEM USING LS_LIST-MBLNR.



  "##### ####

  PERFORM REFRESH_200.



  "#### ####

  CL_GUI_CFW=>SET_NEW_OK_CODE( NEW_CODE = 'DUMMY' ).





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_200

*&---------------------------------------------------------------------*

*       ### ####

*----------------------------------------------------------------------*




FORM REFRESH_200 .

  IF GC_GRID_200 IS BOUND. "### ###### ## (#### ## REFRESH## #### ##)

    GC_GRID_200->REFRESH_TABLE_DISPLAY( ).

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_200

*&---------------------------------------------------------------------*






FORM CREATE_OBJECT_200 .

  CREATE OBJECT GC_CUSTOM_200

    EXPORTING

      CONTAINER_NAME = 'CON01'.



  CREATE OBJECT GC_GRID_200

    EXPORTING

      I_PARENT = GC_CUSTOM_200.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*






FORM FIELD_CATALOG_200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'CHECK'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CHECKBOX = 'X'. "##### ## ##

  GS_FIELDCAT-EDIT = 'X'. " #### ### # ## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT-COLTEXT = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'. "#### ###

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZMSEG_15'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'SHKZG'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZMSEG_15'.

  GS_FIELDCAT-REF_FIELD = 'DMBTR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 17.

  GS_FIELDCAT-FIELDNAME = 'BWART'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_200

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY_200 .

  CALL METHOD GC_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ALV200

      IT_FIELDCATALOG               = GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_GR

*&---------------------------------------------------------------------*

*       ###### ### ## ## (##### #### ##, EKPO#### ##)

*----------------------------------------------------------------------*




FORM CANCEL_GR .

  DATA : LV_CNT TYPE I.

  DATA : LV_MBLNR TYPE ZMSEG_15-MBLNR, "######

         LV_ZEILE TYPE ZMSEG_15-ZEILE. "### ##



  "DB ### ## ## ##

  DATA : LS_ZMKPF TYPE ZMKPF_15,

         LT_ZMSEG TYPE TABLE OF ZMSEG_15,

         LS_ZMSEG TYPE ZMSEG_15.



  "EKPO #### ##

  DATA : LT_EKPO_UPD TYPE TABLE OF ZEKPO_15,

         LS_EKPO_UPD TYPE ZEKPO_15.



  DATA : LS_ZMAT TYPE ZMAT_15.





  "1. #### ###

  "### ##### ### #### ###

  CALL METHOD GC_GRID_200->CHECK_CHANGED_DATA.



  "### ### ### ###

  LOOP AT GT_ALV200 INTO GS_ALV200 WHERE CHECK = 'X'.

    "###

    ADD 1 TO LV_CNT.

  ENDLOOP.



  "## ### 0## ## ##

  IF LV_CNT = 0.

    MESSAGE '### #### #### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "2. ## #### ## (##)

    PERFORM CREATE_MBLNR CHANGING LV_MBLNR.



  "3. ## ### (ZMKPF_15)

  LS_ZMKPF-MBLNR = LV_MBLNR. "######

  LS_ZMKPF-MJAHR = SY-DATUM(4). "####

  LS_ZMKPF-BLART = 'WE'. "####

  LS_ZMKPF-BLDAT = SY-DATUM. "###

  LS_ZMKPF-BUDAT = SY-DATUM. "###



  "4. ####  ### ## (###)

  LOOP AT GT_ALV200 INTO DATA(LS_ALV) WHERE CHECK = 'X'.

    ADD 1 TO LV_ZEILE. "### ## ##.



    CLEAR : LS_ZMSEG.

    LS_ZMSEG-MBLNR = LV_MBLNR. "######

    LS_ZMSEG-MJAHR = SY-DATUM(4). "####

    LS_ZMSEG-ZEILE = LV_ZEILE. "#####



    LS_ZMSEG-MATNR = LS_ALV-MATNR. "####

    LS_ZMSEG-WERKS = LS_ALV-WERKS. "###

    LS_ZMSEG-LGORT = LS_ALV-LGORT. "####

    LS_ZMSEG-LIFNR = LS_ALV-LIFNR. "#####

    LS_ZMSEG-WAERS = LS_ALV-WAERS. "###

    LS_ZMSEG-MENGE = LS_ALV-MENGE. "######

    LS_ZMSEG-MEINS = LS_ALV-MEINS. "##

    LS_ZMSEG-EBELN = LS_ALV-EBELN. "######

    LS_ZMSEG-BUKRS = LS_ALV-BUKRS. "####



    LS_ZMSEG-GJAHR = SY-DATUM(4). "####

    LS_ZMSEG-BELNR = LV_MBLNR. "#### (####### #### ####)

    LS_ZMSEG-SHKZG = 'H'. "###(## S# ####)



    LS_ZMSEG-DMBTR = LS_ALV-DMBTR. "##

    LS_ZMSEG-BWART = '102'. "####



    APPEND LS_ZMSEG TO LT_ZMSEG.





   "5. EKPO #### ##

    "key# ####

    SELECT SINGLE * FROM ZEKPO_15 INTO LS_EKPO_UPD

    WHERE EBELN = LS_ALV-EBELN

    AND WERKS = LS_ALV-WERKS.



    IF SY-SUBRC = 0.

      LS_EKPO_UPD-WEMNG = LS_EKPO_UPD-WEMNG - LS_ALV-MENGE.



      "#### ### ##

      IF LS_EKPO_UPD-WEMNG < LS_EKPO_UPD-MENGE.

        LS_EKPO_UPD-ELIKZ = ''.

      ENDIF.



      APPEND LS_EKPO_UPD TO LT_EKPO_UPD.

    ENDIF.

    "+ ##### #### ##

    SELECT SINGLE * FROM ZMAT_15 INTO LS_ZMAT

      WHERE ZMATNR = GS_ALV200-MATNR

      AND ZWERKS = GS_ALV200-WERKS

      AND ZLGORT = GS_ALV200-LGORT.



    IF SY-SUBRC = 0.

      LS_ZMAT-MENGE = LS_ZMAT-MENGE + GS_ALV200-MENGE.



      IF LS_ZMAT-MENGE < 0.

        ROLLBACK WORK.

        MESSAGE '### #### ### # ####.' TYPE 'E'.

        EXIT.

      ENDIF.



      MODIFY ZMAT_15 FROM LS_ZMAT.



      IF SY-SUBRC <> 0.

        ROLLBACK WORK.

        MESSAGE '##### #### # ## ##' TYPE 'E'.

        EXIT.

      ENDIF.

    ENDIF.

  ENDLOOP.







"6. DB## ##

  "## ##

  INSERT ZMKPF_15 FROM LS_ZMKPF.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## # ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  "### ##

  INSERT ZMSEG_15 FROM TABLE LT_ZMSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '### ## # ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  IF LT_EKPO_UPD IS NOT INITIAL.

    UPDATE ZEKPO_15 FROM TABLE LT_EKPO_UPD. "KEY # #### ## ####

    IF SY-SUBRC <> 0.

      ROLLBACK WORK.

      MESSAGE '#### #### # ## ##' TYPE 'E'.

      EXIT.

    ENDIF.

  ENDIF.



  COMMIT WORK AND WAIT.

  MESSAGE |#### #######. { LV_MBLNR }## #######| TYPE 'S'.



  LEAVE TO SCREEN 0.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_GR_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_MBLNR

*----------------------------------------------------------------------*




FORM GET_GR_ITEM  USING    P_MBLNR.

  CLEAR : GT_ALV200.

  SELECT

    A~ZEILE

    B~MAKTX

    A~MATNR

    A~WERKS

    A~LGORT

    A~LIFNR

    A~WAERS

    A~MENGE

    A~MEINS

    A~EBELN

    A~BUKRS

    A~GJAHR

    A~BELNR

    A~SHKZG

    A~DMBTR

    A~BWART

    INTO CORRESPONDING FIELDS OF TABLE GT_ALV200

    FROM ZMSEG_15 AS A

    INNER JOIN ZEKPO_15 AS B

    ON A~EBELN = B~EBELN AND A~MATNR = B~MATNR AND A~WERKS = B~WERKS

    WHERE MBLNR = P_MBLNR AND BWART = '101'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_GR_HEAD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_MBLNR

*----------------------------------------------------------------------*




FORM GET_GR_HEAD  USING    P_MBLNR.

  SELECT SINGLE MJAHR BLART BLDAT BUDAT

    INTO (GV_MJAHR, GV_BLART, GV_BLDAT, GV_BUDAT)

    FROM ZMKPF_15

    WHERE MBLNR = P_MBLNR.

ENDFORM.