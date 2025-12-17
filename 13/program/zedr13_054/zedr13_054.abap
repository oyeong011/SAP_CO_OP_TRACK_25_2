
*&---------------------------------------------------------------------*

*& Report ZEDR13_054

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_054.



TABLES : ZEDT13_002.



DATA : GS_STUDENT TYPE ZEDT13_002,

       GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV,

       GT_SORT TYPE SLIS_T_SORTINFO_ALV.



SELECT * FROM ZEDT13_002

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.





PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM CALL_ALV.

  PERFORM ALV_SORT.



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

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-NO_ZERO = 'X'.

  GS_FIELDCAT-NO_SIGN = 'X'.




*  GS_FIELDCAT-OUTPUTLEN = 20.

*  GS_FIELDCAT-EMPHASIZE = 'X'.




  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

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

  GS_LAYOUT-NO_COLHEAD = 'X'.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_VLINE = 'X'.

  GS_LAYOUT-NO_HLINE = 'X'.

  GS_LAYOUT-EDIT = 'X'.

  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'.

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

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IS_LAYOUT                      = GS_LAYOUT

    IT_FIELDCAT                    = GT_FIELDCAT

    IT_SORT                        = GT_SORT

  TABLES

    T_OUTTAB                       = GT_STUDENT.

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

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.




*  GS_SORT-DOWN = 'X'.




  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.