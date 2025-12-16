
*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_F03

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INQUIRY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INQUIRY .

  DATA: LT_MSEG_DOCS TYPE TABLE OF ZEDT06_MSEG,

        LS_MSEG_DOC TYPE ZEDT06_MSEG,

        LT_MKPF_DOCS TYPE TABLE OF ZEDT06_MKPF,

        LS_MKPF_DOC TYPE ZEDT06_MKPF.



  "------------------------------------------------------------

  " 1. MSEG## ### ##(MBLNR/MJAHR) ## ##

  "------------------------------------------------------------

  SELECT MBLNR

         MJAHR

         EBELN

         WERKS

    FROM ZEDT06_MSEG

    INTO CORRESPONDING FIELDS OF TABLE LT_MSEG_DOCS

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.



  IF LT_MSEG_DOCS IS INITIAL.

    MESSAGE '## ##### ## ### ####.' TYPE 'S'.

    EXIT.

  ENDIF.



  "------------------------------------------------------------

  " 2. MKPF## ## #### ## ## (BUDAT ##)

  "------------------------------------------------------------

  SELECT *

    FROM ZEDT06_MKPF

    INTO TABLE LT_MKPF_DOCS

    FOR ALL ENTRIES IN LT_MSEG_DOCS

    WHERE MBLNR = LT_MSEG_DOCS-MBLNR

      AND MJAHR = LT_MSEG_DOCS-MJAHR.



  IF LT_MKPF_DOCS IS INITIAL.

    MESSAGE '## ##(MKPF) ### ## # ####.' TYPE 'E'.

  ENDIF.



  "------------------------------------------------------------

  " 3. ## ##(BUDAT ## DESC) ##

  "------------------------------------------------------------

  SORT LT_MKPF_DOCS BY BUDAT DESCENDING.



  READ TABLE LT_MKPF_DOCS INTO LS_MKPF_DOC INDEX 1.



  " MKPF # ## GS_MKPF# ##

  GS_MKPF = LS_MKPF_DOC.



  GS_MKPF_DISP-MBLNR = LS_MKPF_DOC-MBLNR.

  GS_MKPF_DISP-MJAHR = LS_MKPF_DOC-MJAHR.

  GS_MKPF_DISP-BLART = LS_MKPF_DOC-BLART.

  GS_MKPF_DISP-BLDAT = LS_MKPF_DOC-BLDAT.

  GS_MKPF_DISP-BUDAT = LS_MKPF_DOC-BUDAT.



  "------------------------------------------------------------

  " 4. ### ### ### ## (GT_MSEG)

  "------------------------------------------------------------

  CLEAR GT_MSEG_ALV.



  SELECT *

    FROM ZEDT06_MSEG

    INTO CORRESPONDING FIELDS OF TABLE GT_MSEG_ALV

    WHERE EBELN = P_EBELN

      AND WERKS = P_WERKS.



  "------------------------------------------------------------

  " 5. ## ##(300# ###) ##

  "------------------------------------------------------------

  CALL SCREEN 300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_300 .



  " ## ###### ## ### ## (## ## ##)

  IF GC_CUSTOM_300 IS INITIAL.



    CREATE OBJECT GC_CUSTOM_300

      EXPORTING

        CONTAINER_NAME = 'CON1'.  " Screen 300# ## Custom Control ##



    CREATE OBJECT GC_GRID_300

      EXPORTING

        I_PARENT = GC_CUSTOM_300.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT_300 .



  CLEAR : GS_FIELDCAT_300, GT_FIELDCAT_300.



  " 1. #### (MBLNR)

  GS_FIELDCAT_300-COL_POS   = 1.

  GS_FIELDCAT_300-FIELDNAME = 'SEL'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  GS_FIELDCAT_300-CHECKBOX = 'X'.

  GS_FIELDCAT_300-EDIT = 'X'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 2. #### (MBLNR)

  GS_FIELDCAT_300-COL_POS   = 2.

  GS_FIELDCAT_300-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT_300-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 3. #### (MJAHR)

  GS_FIELDCAT_300-COL_POS   = 3.

  GS_FIELDCAT_300-FIELDNAME = 'MJAHR'.

  GS_FIELDCAT_300-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 4. ##### (ZEILE)

  GS_FIELDCAT_300-COL_POS   = 4.

  GS_FIELDCAT_300-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT_300-SCRTEXT_M = '### ##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 5. #### (MATNR)

  GS_FIELDCAT_300-COL_POS   = 5.

  GS_FIELDCAT_300-FIELDNAME = 'MATNR'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 6. ### (WERKS)

  GS_FIELDCAT_300-COL_POS   = 6.

  GS_FIELDCAT_300-FIELDNAME = 'WERKS'.

  GS_FIELDCAT_300-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 7. #### (LGORT)

  GS_FIELDCAT_300-COL_POS   = 7.

  GS_FIELDCAT_300-FIELDNAME = 'LGORT'.

  GS_FIELDCAT_300-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 8. ## (MENGE)

  GS_FIELDCAT_300-COL_POS   = 8.

  GS_FIELDCAT_300-FIELDNAME = 'MENGE'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 9. ## (MEINS)

  GS_FIELDCAT_300-COL_POS   = 9.

  GS_FIELDCAT_300-FIELDNAME = 'MEINS'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 10. ## (DMBTR)

  GS_FIELDCAT_300-COL_POS   = 10.

  GS_FIELDCAT_300-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 10. ## (WAERS)

  GS_FIELDCAT_300-COL_POS   = 11.

  GS_FIELDCAT_300-FIELDNAME = 'WAERS'.

  GS_FIELDCAT_300-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 12. ###### (EBELN)

  GS_FIELDCAT_300-COL_POS   = 12.

  GS_FIELDCAT_300-FIELDNAME = 'EBELN'.

  GS_FIELDCAT_300-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



  " 13. #### (BUKRS)

  GS_FIELDCAT_300-COL_POS   = 13.

  GS_FIELDCAT_300-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT_300-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT_300 TO GT_FIELDCAT_300.

  CLEAR GS_FIELDCAT_300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_300 .



  CLEAR GS_LAYOUT_300.



  GS_LAYOUT_300-ZEBRA = 'X'.     " ###

  GS_LAYOUT_300-CWIDTH_OPT = 'X'. " ## ## # ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT_300.



  CLEAR GT_SORT_300.

  CLEAR GS_SORT_300.



  GS_SORT_300-FIELDNAME = 'ZEILE'.

  GS_SORT_300-UP = 'X'.



  APPEND GS_SORT_300 TO GT_SORT_300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_300 .



  CALL METHOD GC_GRID_300->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT_300

    CHANGING

      IT_OUTTAB       = GT_MSEG_ALV

      IT_FIELDCATALOG = GT_FIELDCAT_300

      IT_SORT         = GT_SORT_300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PO_CANCLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GR_CANCEL .



  DATA: LT_CANCEL TYPE STANDARD TABLE OF TY_MSEG,

        LS_CANCEL TYPE TY_MSEG.



  " 1. ### ## ##

  LOOP AT GT_MSEG_ALV INTO LS_CANCEL WHERE SEL = 'X'.

    APPEND LS_CANCEL TO LT_CANCEL.

  ENDLOOP.



  IF LT_CANCEL IS INITIAL.

    MESSAGE '### ## ### #####.' TYPE 'E'.

    EXIT.

  ENDIF.



  " 2. ## ###(MSEG) ##

  LOOP AT LT_CANCEL INTO LS_CANCEL.

    DELETE FROM ZEDT06_MSEG

      WHERE MBLNR = LS_CANCEL-MBLNR

        AND MJAHR = LS_CANCEL-MJAHR

        AND ZEILE = LS_CANCEL-ZEILE.

  ENDLOOP.



  " 3. ##(MKPF) ##

  PERFORM DELETE_MKPF_IF_EMPTY USING LT_CANCEL.



  " 4. FI ## ## ##

"  PERFORM CREATE_REVERSE_FI_DOC USING LT_CANCEL.



  COMMIT WORK.



  MESSAGE '## ### #######.' TYPE 'S'.



  " 5. ALV ####### ### ## ##

  LOOP AT LT_CANCEL INTO LS_CANCEL.

    DELETE GT_MSEG_ALV

      WHERE MBLNR = LS_CANCEL-MBLNR

        AND MJAHR = LS_CANCEL-MJAHR

        AND ZEILE = LS_CANCEL-ZEILE.

  ENDLOOP.



  PERFORM REFRESH_300.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_MKPF_IF_EMPTY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LT_CANCEL  text

*----------------------------------------------------------------------*




FORM DELETE_MKPF_IF_EMPTY USING PT_CANCEL TYPE STANDARD TABLE.



  DATA: LS_CANCEL TYPE TY_MSEG,

        LV_CNT TYPE I.



  LOOP AT PT_CANCEL INTO LS_CANCEL.



    SELECT COUNT(*) INTO LV_CNT

      FROM ZEDT06_MSEG

      WHERE MBLNR = LS_CANCEL-MBLNR

        AND MJAHR = LS_CANCEL-MJAHR.



    IF LV_CNT = 0.

      DELETE FROM ZEDT06_MKPF

        WHERE MBLNR = LS_CANCEL-MBLNR

          AND MJAHR = LS_CANCEL-MJAHR.

    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT_300.



  CREATE OBJECT GO_EVT_300.



  SET HANDLER GO_EVT_300->HANDLER_DATA_CHANGED FOR GC_GRID_300.



  CALL METHOD GC_GRID_300->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_300

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_300.



  DATA: LS_STABLE TYPE LVC_S_STBL.



  IF GC_GRID_300 IS INITIAL.

    RETURN.

  ENDIF.



  CALL METHOD GC_GRID_300->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.