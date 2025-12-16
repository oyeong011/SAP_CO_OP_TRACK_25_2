
*&---------------------------------------------------------------------*

*&  Include           ZMM14_002_F02

*&---------------------------------------------------------------------*

*&  ### FORM

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SCREEN_OUTPUT .



  LOOP AT SCREEN.

    IF P_R1 = 'X'.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 0.

        SCREEN-INVISIBLE = 1.

        MODIFY SCREEN.

      ENDIF.

    ELSEIF P_R2 = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

        SCREEN-INVISIBLE = 1.

        MODIFY SCREEN.

      ENDIF.

    ENDIF.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA .



  CLEAR GT_OUT.



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_OUT

    FROM ZEKKO_14 AS A

    INNER JOIN ZEKPO_14 AS B ON A~EBELN = B~EBELN

    WHERE A~EBELN = P_EBELN AND A~LIFNR = P_LIFNR

      AND A~BUKRS = P_BUKRS.



  IF GT_OUT[] IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .



  CREATE OBJECT GO_DOCKING

      EXPORTING

        REPID                       = SY-REPID

        DYNNR                       = SY-DYNNR

        SIDE                        = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        EXTENSION                   = 2000.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ##' TYPE 'E'.

  ENDIF.



  CREATE OBJECT GO_GRID

    EXPORTING

      I_PARENT = GO_DOCKING.



  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GO_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GT_FCAT, GS_FCAT.



  PERFORM FILL_FCAT USING :

        'EBELP' '##' '' 10 '' CHANGING GT_FCAT,

        'MATNR' '####' '' 10 '' CHANGING GT_FCAT,

        'MAKTX' '###' '' 10 '' CHANGING GT_FCAT,

        'MENGE' 'PO##' '' 10 'Q' CHANGING GT_FCAT,

        'MEINS' '##' '' 10 '' CHANGING GT_FCAT,

        'STPRS' '##' '' 10 'C' CHANGING GT_FCAT,

        'WAERS' '##' '' 10 '' CHANGING GT_FCAT,

        'MWSKZ' '####' '' 10 '' CHANGING GT_FCAT,

        'PRDAT' '###' '' 10 '' CHANGING GT_FCAT,

        'WERKS' '###' '' 10 '' CHANGING GT_FCAT,

        'LGORT' '####' '' 10 '' CHANGING GT_FCAT.




*        '' '# ##' '' 10 '' CHANGING GT_FCAT.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_FCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FILL_FCAT USING PV_FIELD PV_TXT PV_EDIT PV_LEN PV_XFIELD

               CHANGING CT_FCAT TYPE LVC_T_FCAT.



  DATA : LS_FCAT TYPE LVC_S_FCAT.



  LS_FCAT-FIELDNAME = PV_FIELD.

  LS_FCAT-COLTEXT = PV_TXT.

  LS_FCAT-EDIT = PV_EDIT.

  LS_FCAT-OUTPUTLEN = PV_LEN.

  LS_FCAT-JUST = 'R'.

  LS_FCAT-REF_TABLE = 'ZEKPO_14'.

  IF PV_XFIELD = 'Q'.

    LS_FCAT-QFIELDNAME = 'MEINS'.

  ELSEIF PV_XFIELD = 'C'.

    LS_FCAT-CFIELDNAME = 'WAERS'.

  ENDIF.



  APPEND LS_FCAT TO CT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.




*  GS_LAYOUT-NO_TOOLBAR = 'X'.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CALL_METHOD .



  CALL METHOD GO_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_OUT

      IT_FIELDCATALOG = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM REFRESH_ALV .



  DATA: LS_STABLE TYPE LVC_S_STBL.



  " ## ### # ## ## ##

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.