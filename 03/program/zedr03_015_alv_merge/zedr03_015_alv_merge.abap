
*&---------------------------------------------------------------------*

*& Report ZEDR03_014_ALV_FUNCTION

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_015_ALV_MERGE.



TABLES : ZEDT00_001.



DATA : BEGIN OF GT_STUDENT OCCURS 0,

  ZCOLOR TYPE C LENGTH 4,

  ZCODE LIKE ZEDT00_001-ZCODE,

  ZPERNR LIKE ZEDT00_001-ZCODE,

  ZKNAME LIKE ZEDT00_001-ZCODE,

  ZENAME LIKE ZEDT00_001-ZCODE,

  ZGENDER LIKE ZEDT00_001-ZCODE,

  ZMAJOR LIKE ZEDT00_001-ZCODE,

  ZMNAME LIKE ZEDT00_001-ZCODE,

  END OF GT_STUDENT.



DATA : GS_FIELDCAT TYPE slis_fieldcat_alv.

DATA : GT_FIELDCAT TYPE slis_t_fieldcat_alv.

DATA : GS_LAYOUT TYPE slis_layout_alv.

DATA : GS_SORT TYPE slis_sortinfo_alv.

DATA : GT_SORT TYPE slis_t_sortinfo_alv.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT00_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



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

  SELECT A~ZCODE

         A~ZPERNR

         A~ZKNAME

         A~ZENAME

         A~ZGENDER

         B~ZMAJOR

         B~ZMNAME

     FROM ZEDT00_001 AS A

     INNER JOIN ZEDT00_002 AS B

     ON A~ZCODE = B~ZCODE

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

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-OUTPUTLEN = 10.

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

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

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

  CLEAR GT_STUDENT.



  LOOP AT GT_STUDENT INTO GT_STUDENT.

    IF GT_STUDENT-ZENAME IS INITIAL.

      GT_STUDENT-ZCOLOR = '@OA@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GT_STUDENT INDEX SY-TABIX.

    CLEAR GT_STUDENT.

  ENDLOOP.

ENDFORM.