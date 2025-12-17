
*&---------------------------------------------------------------------*

*& Report ZEDR24_020_ALV_LAYOUT

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_020_ALV_LAYOUT.





TABLES ZEDT24_002.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



"ABAP ALV LAYOUT

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.





DATA : GS_STUDENT LIKE ZEDT24_002,

       GT_STUDENT LIKE TABLE OF GS_STUDENT.



"ABAP SORT

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.



PERFORM GET_DATA.

PERFORM ALV_DISPLAY.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT24_002

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

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

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV.

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

  GS_FIELDCAT-COL_POS = '1'.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'. "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

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

    IT_FIELDCAT = GT_FIELDCAT

    IS_LAYOUT = GS_LAYOUT

    IT_SORT = GT_SORT

  TABLES

    T_OUTTAB = GT_STUDENT.

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




*  GS_LAYOUT-NO_VLINE = 'X'.

*  GS_LAYOUT-NO_HLINE = 'X'.

*  GS_LAYOUT-EDIT = 'X'.

*  GS_LAYOUT-TOTAL_BEFORE_ITEMS = 'X'.




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

  GS_SORT-SPOS = 3.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.

  "GS_SORT-DOWN = 'X'.

  "GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.