
*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  RECEIVING_PROCESSING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RECEIVING_PROCESSING .

  " 1. ## ## #### ##.

  PERFORM SELECT_OPEN_PO.



  " 2. ## ###

  CALL SCREEN 200.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  A

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_OPEN_PO .

  " 1. PO##(EKPO & EKKO)

  SELECT * FROM ZEDT06_EKPO

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO

    WHERE EBELN = P_EBELN

    AND WERKS = P_WERKS.

  SELECT SINGLE * FROM ZEDT06_EKKO

    INTO CORRESPONDING FIELDS OF GS_EKKO

    WHERE EBELN = P_EBELN.



  " 2. MSEG ## #### ## ##

  SELECT * FROM ZEDT06_MSEG

    INTO CORRESPONDING FIELDS OF TABLE GT_MSEG

    WHERE EBELN = P_EBELN

    AND WERKS = P_WERKS.



  " 3. #### - ###### > 0# ### ##.

  LOOP AT GT_EKPO INTO GS_EKPO.



    LOOP AT GT_MSEG INTO GS_MSEG

      WHERE EBELN = GS_EKPO-EBELN

      AND MATNR = GS_EKPO-MATNR.



      GS_EKPO-MENGE = GS_EKPO-MENGE - GS_MSEG-MENGE.

    ENDLOOP.



    GS_EKPO-WAERS = GS_EKKO-WAERS.

    GS_EKPO-MENGE_IN = GS_EKPO-MENGE.

    GS_EKPO-MENGE_MAX = GS_EKPO-MENGE.



    IF GS_EKPO-MENGE > 0.

      MODIFY GT_EKPO FROM GS_EKPO.

    ELSE.

      DELETE GT_EKPO INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  B

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POST_GR_FOR_SELECTED .

  DATA : LV_STORE_CNT TYPE I, " ##

         LV_MBLNR LIKE GS_MSEG-MBLNR,       " ######.

         LV_MJAHR TYPE ZEDT06_MKPF-MJAHR,   " ####

         LV_BUZEI TYPE ZEDT06_MSEG-ZEILE,   " #####

         LV_DMBTR TYPE ZEDT06_MSEG-DMBTR.   " ##



  DATA: LV_ERROR TYPE ABAP_BOOL.

  CLEAR LV_ERROR.



  " 0. ## ## ##

  READ TABLE GT_EKPO TRANSPORTING NO FIELDS

    WITH KEY SEL = 'X'.



  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'E'.

    RETURN.

  ENDIF.



  "---------------------------------------------------------------

  " 2. ######(MBLNR) ##

  "---------------------------------------------------------------

  SELECT MAX( MBLNR ) INTO LV_MBLNR

    FROM ZEDT06_MKPF

    WHERE MBLNR LIKE '5%'.



  IF LV_MBLNR IS INITIAL.

    LV_MBLNR = '5000000000'.

  ELSE.

    LV_MBLNR = LV_MBLNR + 1.

  ENDIF.



  LV_MJAHR = SY-DATUM(4).





  "---------------------------------------------------------------

  " 3. MKPF INSERT : ## ## ##

  "---------------------------------------------------------------

  CLEAR GS_MKPF.



  GS_MKPF-MBLNR = LV_MBLNR.       " ######

  GS_MKPF-MJAHR = LV_MJAHR.       " ####

  GS_MKPF-BLART = 'WE'.           " ####

  GS_MKPF-BLDAT = GS_EKKO-BEDAT.  " ###

  GS_MKPF-BUDAT = P_BUDAT.        " ###



  INSERT ZEDT06_MKPF FROM GS_MKPF.





  "---------------------------------------------------------------

  " 4. ### PO ## LOOP # MSEG INSERT

  "---------------------------------------------------------------

  LV_BUZEI = 10.

  CLEAR GT_MSEG.



  LOOP AT GT_EKPO INTO GS_EKPO WHERE SEL = 'X'.



    " 4-1. ## ##

    LV_STORE_CNT = GS_EKPO-MENGE.

    " 4-2. ## = ## * ##.

    LV_DMBTR = GS_EKPO-BPRME * LV_STORE_CNT.



    " 4-3. MSEG ##

    CLEAR : GS_MSEG.



    GS_MSEG-MBLNR = LV_MBLNR.

    GS_MSEG-MJAHR = LV_MJAHR.

    GS_MSEG-ZEILE = LV_BUZEI.

    GS_MSEG-MATNR = GS_EKPO-MATNR.

    GS_MSEG-WERKS = GS_EKPO-WERKS.

    GS_MSEG-LGORT = GS_EKPO-LGORT.

    GS_MSEG-LIFNR = GS_EKKO-LIFNR.

    GS_MSEG-WAERS = GS_EKKO-WAERS.

    GS_MSEG-MENGE = LV_STORE_CNT.

    GS_MSEG-MEINS = GS_EKPO-MEINS.

    GS_MSEG-EBELN = GS_EKPO-EBELN.

    GS_MSEG-BUKRS = GS_EKKO-BUKRS.

    GS_MSEG-GJAHR = LV_MJAHR.

    GS_MSEG-BELNR = LV_MBLNR.

    GS_MSEG-SHKZG = 'S'.

    GS_MSEG-DMBTR = LV_DMBTR.



    APPEND GS_MSEG TO GT_MSEG.



    LV_BUZEI = LV_BUZEI + 10.



  ENDLOOP.



  INSERT ZEDT06_MSEG FROM TABLE GT_MSEG.



  " FI ##

  IF LV_ERROR IS INITIAL.

    PERFORM CREATE_FI_DOC_FOR_GR

      USING LV_MBLNR LV_MJAHR GS_EKKO-BUKRS.

  ENDIF.



  IF LV_ERROR IS INITIAL.

    COMMIT WORK.

    MESSAGE '## # ## ### #######.' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ## ## ## # ### ######.' TYPE 'E'.

  ENDIF.



  IF LV_ERROR IS INITIAL.

    COMMIT WORK.



    PERFORM POPUP_SUCCESS_AND_BACK.



  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ## ## ## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POPUP_SUCCESS_AND_BACK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POPUP_SUCCESS_AND_BACK.



  DATA: LV_ANSWER TYPE C.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR      = '## ##'

      TEXT_QUESTION = '## ### #######. ## #### ########?'

      TEXT_BUTTON_1 = '##'

      DEFAULT_BUTTON = '1'

    IMPORTING

      ANSWER        = LV_ANSWER.



  IF LV_ANSWER = '1'.

    " Selection Screen## ##

    LEAVE TO SCREEN 0.

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




FORM CREATE_OBJECT_200 .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000 .



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT_200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'SEL'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MENGE_IN'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'BPRME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_200 .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*    EXPORTING

*      IS_LAYOUT                     =




    CHANGING

      IT_OUTTAB                     = GT_EKPO

      IT_FIELDCATALOG               = GT_FIELDCAT.






*      IT_SORT                       =




  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

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



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT_200 .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT_200.





  IF GC_GRID IS INITIAL.

    RETURN.   " ## Grid ## ### ## ##

  ENDIF.





  IF GO_EVT_200 IS INITIAL.

    CREATE OBJECT GO_EVT_200.

    SET HANDLER GO_EVT_200->HANDLER_DATA_CHANGED FOR GC_GRID.



    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_200.



  DATA: LS_STABLE TYPE LVC_S_STBL.



  IF GC_GRID IS INITIAL.

    RETURN.

  ENDIF.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.