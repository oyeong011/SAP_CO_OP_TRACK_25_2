
*&---------------------------------------------------------------------*

*&  Include           ZMM14_003_F02

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

        'MBLNR' '######' '' 10 '' CHANGING GT_FCAT,

        'ZEILE' '##' '' 10 '' CHANGING GT_FCAT,

        'EBELN' '######' '' 10 '' CHANGING GT_FCAT,

        'LIFNR' '#####' '' 10 '' CHANGING GT_FCAT,

        'MATNR' '####' '' 10 '' CHANGING GT_FCAT,

        'MENGE' '####' '' 10 'Q' CHANGING GT_FCAT,

        'MEINS' '##' '' 10 '' CHANGING GT_FCAT,

        'DMBTR' '##' '' 10 'C' CHANGING GT_FCAT,

        'WAERS' '##' '' 10 '' CHANGING GT_FCAT,

        'WERKS' '###' '' 10 '' CHANGING GT_FCAT,

        'LGORT' '####' '' 10 '' CHANGING GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER_DATA_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_HEADER_DATA_200 .



  "####, ####, ###, ###, ####

  SELECT SINGLE A~NAME1 B~GJAHR C~BLDAT C~BUDAT C~BLART

    INTO CORRESPONDING FIELDS OF GS_100

    FROM ZLFA1_14 AS A

    JOIN ZMSEG_14 AS B ON A~LIFNR = B~LIFNR

    JOIN ZMKPF_14 AS C ON B~MBLNR = C~MBLNR

    WHERE B~EBELN = P_EBELN AND B~WERKS = P_WERKS.



  IF GS_100 IS INITIAL.

    MESSAGE '### ##### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM_DATA_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_ITEM_DATA_200 .



  CLEAR GT_OUT.



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_OUT

    FROM ZMSEG_14

    WHERE EBELN = P_EBELN AND WERKS = P_WERKS.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM DELETE_DATA .



  DATA: LT_DEL_MSEG TYPE TABLE OF ZMSEG_14,

        LS_DEL_MSEG TYPE ZMSEG_14.

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

    DELETE FROM ZMSEG_14

      WHERE MBLNR = GS_OUT-MBLNR

        AND MJAHR = GS_OUT-MJAHR

        AND ZEILE = GS_OUT-ZEILE.



    SELECT COUNT(*) FROM ZMSEG_14

      WHERE MBLNR = GS_OUT-MBLNR

        AND MJAHR = GS_OUT-MJAHR.



    IF SY-SUBRC <> 0.  "## ### ### ## ##

      DELETE FROM ZMKPF_14

        WHERE MBLNR = GS_OUT-MBLNR

          AND MJAHR = GS_OUT-MJAHR.

    ENDIF.

  ENDLOOP.



  IF SY-SUBRC = 0.

    COMMIT WORK.

    MESSAGE '## ### #######.' TYPE 'S'.



    PERFORM GET_ITEM_DATA_200.

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