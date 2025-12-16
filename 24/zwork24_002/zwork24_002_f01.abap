
*&---------------------------------------------------------------------*

*&  Include           ZWORK24_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  PA_DATE = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  READ_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM READ_DATA .

  "### ####

  IF PA_DATE IS INITIAL.

    MESSAGE '## ####  ######' TYPE 'E'.

    EXIT.

  ENDIF.



  SELECT * FROM ZTCURR24

    INTO CORRESPONDING FIELDS OF TABLE GT_OUTPUT

    WHERE GDATU = PA_DATE.



  LOOP AT GT_OUTPUT INTO GS_OUTPUT.

    CASE: GS_OUTPUT-FCURR.

      WHEN 'USD'.

        GS_OUTPUT-SORT_KEY = '1'.

      WHEN 'JPY'.

        GS_OUTPUT-SORT_KEY = '2'.

      WHEN 'EUR'.

        GS_OUTPUT-SORT_KEY = '3'.

      WHEN 'CAD'.

        GS_OUTPUT-SORT_KEY = '4'.

      WHEN 'CNY'.

        GS_OUTPUT-SORT_KEY = '5'.

      WHEN 'VND'.

        GS_OUTPUT-SORT_KEY = '6'.

      WHEN 'HKD'.

        GS_OUTPUT-SORT_KEY = '7'.

      WHEN 'AUD'.

        GS_OUTPUT-SORT_KEY = '8'.

    ENDCASE.

    MODIFY GT_OUTPUT FROM GS_OUTPUT.

  ENDLOOP.

  SORT GT_OUTPUT BY SORT_KEY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME = 'CON1'.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_CUSTOM.



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

  CLEAR : GS_FC, GT_FC.



  GS_FC-COL_POS = 1.

  GS_FC-FIELDNAME = 'KURST'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 2.

  GS_FC-FIELDNAME = 'FCURR'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 3.

  GS_FC-FIELDNAME = 'TCURR'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 4.

  GS_FC-FIELDNAME = 'GDATU'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 5.

  GS_FC-FIELDNAME = 'UKURS'.

  GS_FC-COLTEXT = '##'.

  GS_FC-OUTPUTLEN = 15.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 6.

  GS_FC-FIELDNAME = 'FFACT'.

  GS_FC-COLTEXT = '########'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 7.

  GS_FC-FIELDNAME = 'TFACT'.

  GS_FC-COLTEXT = '########'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 8.

  GS_FC-FIELDNAME = 'WRITER'.

  GS_FC-COLTEXT = '###'.

  GS_FC-OUTPUTLEN = 8.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 9.

  GS_FC-FIELDNAME = 'EDATE'.

  GS_FC-COLTEXT = '###'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

  "## ###

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    CHANGING

      IT_OUTTAB = GT_OUTPUT

      IT_FIELDCATALOG = GT_FC

      IT_SORT = GT_SORT.



  IF SY-SUBRC <> 0.

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




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  "### ### #

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  "## ##

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



  IF SY-SUBRC <> 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  LOOP AT GT_OUTPUT INTO GS_OUTPUT.

    GS_OUTPUT-WRITER = SY-UNAME.

    GS_OUTPUT-EDATE = SY-DATUM.

    MODIFY GT_OUTPUT FROM GS_OUTPUT.

  ENDLOOP.



ENDFORM.