
*&---------------------------------------------------------------------*

*&  Include           ZMM15_004_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_BELNR

*&---------------------------------------------------------------------*

*       ##### ## ###### ####

*----------------------------------------------------------------------*




FORM GET_BELNR .

  SELECT DISTINCT BELNR

    FROM ZRSEG_15

    INTO TABLE GT_LIST

    WHERE WERKS = P_WERKS

    AND EBELN = P_EBELN.

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

  GS_FIELDCAT_LIST-FIELDNAME = 'BELNR'.

  GS_FIELDCAT_LIST-COLTEXT = '######'.

  GS_FIELDCAT_LIST-OUTPUTLEN = 20.



  APPEND GS_FIELDCAT_LIST TO GT_FIELDCAT_LIST.

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

*&      Form  LV_HANDLER_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       ###### #####

*----------------------------------------------------------------------*

*      -->P_E_ROW  text

*      -->P_E_COLUMN  text

*----------------------------------------------------------------------*




FORM LV_HANDLER_DOUBLE_CLICK  USING    P_E_ROW TYPE LVC_S_ROW

                                      P_E_COLUMN TYPE LVC_S_COL.

  DATA : LS_LIST LIKE GS_LIST.



  CLEAR : GT_ALV_200.



  "##### ### # ##

  READ TABLE GT_LIST INTO LS_LIST INDEX P_E_ROW-INDEX.

  CHECK SY-SUBRC = 0.



    "DB## ##, ### ## #### ###

  PERFORM GET_IV_HEAD USING LS_LIST-BELNR.



  PERFORM GET_IV_ITEM USING LS_LIST-BELNR.



  "##### ####

  PERFORM REFRESH_200.



  "### ## ## ### ## PBO ## ##

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING

      NEW_CODE = 'REFRESH'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_IV_HEAD

*&---------------------------------------------------------------------*




FORM GET_IV_HEAD  USING    P_BELNR.

  SELECT SINGLE BELNR GJAHR BLDAT BUDAT BLART WAERS

    INTO (G_BELNR2, G_GJAHR2, G_BLDAT2, G_BUDAT2, G_BLART2, G_WAERS2)

    FROM ZRBKP_15

    WHERE BELNR = P_BELNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_IV_ITEM

*&---------------------------------------------------------------------*




FORM GET_IV_ITEM  USING    P_BELNR.

  CLEAR : GT_ALV_200.

  SELECT

    A~BELNR

    A~GJAHR

    A~BUZEI

    A~EBELN

    A~EBELP

    A~MATNR

    A~WERKS

    B~MAKTX

    A~WRBTR

    A~MENGE

    A~MEINS

    A~NETPR

    A~SGTXT

    A~DMBTR

    A~SHKZG

    INTO CORRESPONDING FIELDS OF TABLE GT_ALV_200

    FROM ZRSEG_15 AS A

    INNER JOIN ZEKPO_15 AS B

    ON A~EBELN = B~EBELN AND A~MATNR = B~MATNR AND A~WERKS = B~WERKS

    WHERE BELNR = P_BELNR.



  LOOP AT GT_ALV_200 INTO GS_ALV_200.

    GS_ALV_200-WAERS = G_WAERS2.

    MODIFY GT_ALV_200 FROM GS_ALV_200.

  ENDLOOP.

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

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



   CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

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

      IT_OUTTAB                     = GT_ALV_200

      IT_FIELDCATALOG               = GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_INVOICE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CANCEL_INVOICE .

  DATA : LT_DEL_RSEG TYPE TABLE OF ZRSEG_15,

         LS_DEL_RSEG TYPE ZRSEG_15,

         LV_BELNR    TYPE ZRSEG_15-BELNR,

         LV_COUNT    TYPE I.



  CALL METHOD GC_GRID_200->CHECK_CHANGED_DATA.



  LOOP AT GT_ALV_200 INTO GS_ALV_200 WHERE CHECK = 'X'.

    " ### ## ##

    LS_DEL_RSEG-MANDT = SY-MANDT.

    LS_DEL_RSEG-BELNR = GS_ALV_200-BELNR.

    LS_DEL_RSEG-GJAHR = GS_ALV_200-GJAHR.

    LS_DEL_RSEG-BUZEI = GS_ALV_200-BUZEI.



    APPEND LS_DEL_RSEG TO LT_DEL_RSEG.

  ENDLOOP.



  IF LT_DEL_RSEG IS INITIAL.

    MESSAGE '#### ### #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  DELETE ZRSEG_15 FROM TABLE LT_DEL_RSEG.



  IF SY-SUBRC = 0.

    COMMIT WORK.

    MESSAGE '##### #######' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '### ### ######' TYPE 'S'.

  ENDIF.



  LEAVE TO SCREEN 0.

ENDFORM.