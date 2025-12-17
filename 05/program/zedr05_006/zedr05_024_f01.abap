
*&---------------------------------------------------------------------*

*& Include ZEDR05_024_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*& Form SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT.

  S_ZCODE-SIGN   = 'I'.

  S_ZCODE-OPTION = 'BT'.

  S_ZCODE-LOW    = 'SSU-01'.

  S_ZCODE-HIGH   = 'SSU-99'.

  APPEND S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA.

  SELECT * FROM ZEDT05_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE  IN S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT.

  IF GC_CUSTOM IS NOT INITIAL.

    RETURN.

  ENDIF.



  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME              = 'CON1'

    EXCEPTIONS

      CNTL_ERROR                  = 1

      CNTL_SYSTEM_ERROR           = 2

      CREATE_ERROR                = 3

      LIFETIME_ERROR              = 4

      LIFETIME_DYNPRO_DYNPRO_LINK = 5

      OTHERS                      = 6.



  IF SY-SUBRC <> 0.

    MESSAGE ID SY-MSGID TYPE 'E' NUMBER SY-MSGNO

            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

    RETURN.

  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_CUSTOM

    EXCEPTIONS

      ERROR_CNTL_CREATE = 1

      ERROR_CNTL_INIT   = 2

      ERROR_CNTL_LINK   = 3

      ERROR_DP_CREATE   = 4

      OTHERS            = 5.



  IF SY-SUBRC <> 0.

    MESSAGE ID SY-MSGID TYPE 'E' NUMBER SY-MSGNO

            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG.

  REFRESH GT_FIELDCAT.



  PERFORM ADD_FIELDCAT USING 'ZCOLOR'  '##'     '' '' 'X'  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'ZCODE'   '####' 'X' 'L' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'ZPERNR'  '####' 'X' 'L' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'ZKNAME'  '###'   '' '' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'ZENAME'  '###'   '' '' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'ZGENDER' '##'     '' '' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'ZTEL'    '####' '' 'L' '' 15 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'CRNAME'  '###'   '' '' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'CRDATE'  '###'   '' 'C' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'AENAME'  '###'   '' '' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'AEDATE'  '###'   '' 'C' ''  0 '' '' '' '' ''.

  PERFORM ADD_FIELDCAT USING 'AEZEIT'  '####' '' 'C' ''  0 '' '' '' '' ''.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form ADD_FIELDCAT - ## ###

*&---------------------------------------------------------------------*




FORM ADD_FIELDCAT USING PV_FNAME   TYPE LVC_FNAME

                        PV_TEXT    TYPE SCRTEXT_M

                        PV_KEY     TYPE CHAR01

                        PV_JUST    TYPE CHAR01

                        PV_ICON    TYPE CHAR01

                        PV_OUTLEN  TYPE I

                        PV_EDIT    TYPE CHAR01

                        PV_SUM     TYPE CHAR01

                        PV_CFIELD  TYPE LVC_CFNAME

                        PV_EMPH    TYPE CHAR04

                        PV_NOZERO  TYPE CHAR01.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME  = PV_FNAME.

  GS_FIELDCAT-SCRTEXT_M  = PV_TEXT.

  GS_FIELDCAT-KEY        = PV_KEY.

  GS_FIELDCAT-JUST       = PV_JUST.

  GS_FIELDCAT-ICON       = PV_ICON.

  GS_FIELDCAT-OUTPUTLEN  = PV_OUTLEN.

  GS_FIELDCAT-EDIT       = PV_EDIT.

  GS_FIELDCAT-DO_SUM     = PV_SUM.

  GS_FIELDCAT-CFIELDNAME = PV_CFIELD.

  GS_FIELDCAT-EMPHASIZE  = PV_EMPH.

  GS_FIELDCAT-NO_SIGN    = PV_NOZERO.



  DATA: LV_MAX_COL TYPE I.

  LOOP AT GT_FIELDCAT INTO DATA(LS_FCAT_TMP).

    IF LS_FCAT_TMP-COL_POS > LV_MAX_COL.

      LV_MAX_COL = LS_FCAT_TMP-COL_POS.

    ENDIF.

  ENDLOOP.

  GS_FIELDCAT-COL_POS = LV_MAX_COL + 1.



  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA       = 'X'.

  GS_LAYOUT-CWIDTH_OPT  = 'X'.

  GS_LAYOUT-SEL_MODE    = 'A'.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT.

  REFRESH GT_SORT.

  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-SPOS      = 1.

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY.

  IF GC_GRID IS INITIAL.

    MESSAGE 'ALV Grid ### #### #####.' TYPE 'E'.

    RETURN.

  ENDIF.



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_STUDENT

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT         = GT_SORT

    EXCEPTIONS

      INVALID_PARAMETER_COMBINATION = 1

      PROGRAM_ERROR                 = 2

      TOO_MANY_LINES                = 3

      OTHERS                        = 4.



  IF SY-SUBRC <> 0.

    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

  ENDIF.

ENDFORM.