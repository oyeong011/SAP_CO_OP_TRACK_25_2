
*&---------------------------------------------------------------------*

*&  Include           ZMM14_004_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_200 .



  CREATE OBJECT GO_CUSTOM_200

    EXPORTING

      CONTAINER_NAME = 'CC_ALV_200'.



  CREATE OBJECT GO_GRID_200

    EXPORTING

      I_PARENT = GO_CUSTOM_200.



  CREATE OBJECT GO_EVENT_200.

  SET HANDLER GO_EVENT_200->HANDLE_DATA_CHANGED FOR GO_GRID_200.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .



  CLEAR : GT_FCAT, GS_FCAT.



  PERFORM FILL_FCAT USING :

        'ZCHECK' '##' 'X' 5 'CH' CHANGING GT_FCAT,

        'BELNR' '######' '' 10 '' CHANGING GT_FCAT,

        'GJAHR' '####' '' 10 '' CHANGING GT_FCAT,

        'BUZEI' '####' '' 10 '' CHANGING GT_FCAT,

        'MENGE' '##' '' 10 'Q' CHANGING GT_FCAT,

        'BSTME' '##' '' 10 '' CHANGING GT_FCAT,

        'WRBTR' '##' '' 10 'C' CHANGING GT_FCAT,

        'WMWST' '##' '' 10 'C' CHANGING GT_FCAT,

        'TOTAL' '# ##' '' 10 'C' CHANGING GT_FCAT,

        'WAERS' '##' '' 10 '' CHANGING GT_FCAT,

        'MWSKZ' '####' '' 10 '' CHANGING GT_FCAT,

        'EBELN' '####' '' 10 '' CHANGING GT_FCAT,

        'EBELP' '######' '' 10 '' CHANGING GT_FCAT,

        'MATNR' '####' '' 10 '' CHANGING GT_FCAT,

        'MAKTX' '###' '' 10 '' CHANGING GT_FCAT,

        'WERKS' '###' '' 10 '' CHANGING GT_FCAT,

        'SGTXT' '####' '' 10 '' CHANGING GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER_DATA_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_HEADER_DATA_200 .



  GS_100-EBELN = P_EBELN.  "####

  GS_100-WERKS = P_WERKS.  "###



  SELECT SINGLE A~NAME1 B~BUDAT

    INTO CORRESPONDING FIELDS OF GS_100

    FROM ZLFA1_14 AS A

    JOIN ZRBKP_14 AS B ON A~LIFNR = B~LIFNR

    WHERE B~EBELN = P_EBELN.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM_DATA_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_ITEM_DATA_200 .



  CLEAR GT_OUT.



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_OUT

    FROM ZRSEG_14

    WHERE EBELN = P_EBELN AND WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '### ## ### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  LOOP AT GT_OUT INTO GS_OUT.

    GS_OUT-TOTAL = GS_OUT-WRBTR + GS_OUT-WMWST.

    MODIFY GT_OUT FROM GS_OUT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM DELETE_DATA .



  DATA: LT_DEL_RSEG TYPE TABLE OF ZRSEG_14,

        LS_DEL_RSEG TYPE ZRSEG_14.

  DATA: LV_COUNT TYPE I.

  DATA: LV_ANS TYPE C.



  CALL METHOD GO_GRID_200->CHECK_CHANGED_DATA.



  LOOP AT GT_OUT INTO GS_OUT WHERE ZCHECK = 'X'.

    LV_COUNT = LV_COUNT + 1.

  ENDLOOP.



  IF LV_COUNT = 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'W'.

    EXIT.

  ENDIF.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR       = '## ##'

      TEXT_QUESTION  = '### ## ### ########? (## ##)'

      TEXT_BUTTON_1  = '#'

      TEXT_BUTTON_2  = '###'

      DISPLAY_CANCEL_BUTTON = ''

    IMPORTING

      ANSWER         = LV_ANS.



  IF LV_ANS <> '1'.

    EXIT.

  ENDIF.



  LOOP AT GT_OUT INTO GS_OUT WHERE ZCHECK = 'X'.

    DELETE FROM ZRSEG_14

      WHERE BELNR = GS_OUT-BELNR

        AND GJAHR = GS_OUT-GJAHR

        AND BUZEI = GS_OUT-BUZEI.



    SELECT COUNT(*) FROM ZRSEG_14   "## # ###

      WHERE BELNR = GS_OUT-BELNR

        AND GJAHR = GS_OUT-GJAHR.



    IF SY-SUBRC <> 0.  "## ### ### ## ##

      DELETE FROM ZRBKP_14

        WHERE BELNR = GS_OUT-BELNR

          AND GJAHR = GS_OUT-GJAHR.

    ELSE.




*      UPDATE ZRBKP_14  "## # ##, ## ##

*        SET RMWWR = RMWWR - ( GS_OUT-WRBTR + GS_OUT-WMWST )

*            WMWST = WMWST - GS_OUT-WMWST

*        WHERE BELNR = GS_OUT-BELNR

*          AND GJAHR = GS_OUT-GJAHR.




      DATA: LS_UPDATE_RBKP TYPE ZRBKP_14.

      " 1. ## ## #### #####.

      SELECT SINGLE * INTO LS_UPDATE_RBKP

        FROM ZRBKP_14

        WHERE BELNR = GS_OUT-BELNR

          AND GJAHR = GS_OUT-GJAHR.

      IF SY-SUBRC = 0.

        LS_UPDATE_RBKP-RMWWR = LS_UPDATE_RBKP-RMWWR - ( GS_OUT-WRBTR + GS_OUT-WMWST ).

        LS_UPDATE_RBKP-WMWST = LS_UPDATE_RBKP-WMWST - GS_OUT-WMWST.



        UPDATE ZRBKP_14 FROM LS_UPDATE_RBKP.

      ENDIF.

    ENDIF.

  ENDLOOP.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE '## ### #######.' TYPE 'S'.



    DELETE GT_OUT WHERE ZCHECK = 'X'.

    PERFORM REFRESH_ALV_200.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_200 .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_TOOLBAR = 'X'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CALL_METHOD_200 .



  CALL METHOD GO_GRID_200->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_OUT

      IT_FIELDCATALOG = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM REFRESH_ALV_200 .



  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID_200->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.