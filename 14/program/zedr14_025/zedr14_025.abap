
*&---------------------------------------------------------------------*

*& Report ZEDR14_025

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_025.



"ALV #### ##



TABLES : ZEDT00_002.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV,

       GT_SORT TYPE SLIS_T_SORTINFO_ALV.



DATA : GS_STUDENT TYPE ZEDT00_002,

       GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT00_002-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT00_002-ZPERNR.

SELECTION-SCREEN END OF BLOCK B1.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .



  SELECT * FROM ZEDT00_002

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.



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




*  PERFORM ALV_LAYOUT.

*  PERFORM ALV_SORT.




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




*    IS_LAYOUT = GS_LAYOUT

*    IT_SORT = GT_SORT




  TABLES

    T_OUTTAB = GT_STUDENT.



  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

  EXPORTING

    I_PROGRAM_NAME = SY-REPID

    I_INTERNAL_TABNAME = 'GT_STUDENT'

    I_INCLNAME = SY-REPID

  CHANGING

    CT_FIELDCAT = GT_FIELDCAT.



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

  GS_SORT-DOWN = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.