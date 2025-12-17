
*&---------------------------------------------------------------------*

*&  Include           ZEDR10_1028_F01

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



  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .



  SELECT *

    FROM ZEDT10_001 AS T1

    INNER JOIN ZEDT10_002 AS T2

      ON T2~ZCODE = T1~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE T1~ZCODE IN S_ZCODE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR GS_FIELDCAT.

  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 0.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

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

  CLEAR GS_STUDENT.



  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZENAME IS INITIAL.

      GS_STUDENT-ZCOLOR = '@0A@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR GS_STUDENT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR GT_SORT.

  CLEAR GS_SORT.

  GS_SORT-FIELDNAME = 'ZCODE'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IS_LAYOUT = GS_LAYOUT

    IT_SORT = GT_SORT

    IT_FIELDCAT = GT_FIELDCAT

  TABLES

    T_OUTTAB = GT_STUDENT.

ENDFORM.