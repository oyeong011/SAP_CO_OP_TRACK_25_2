
*&---------------------------------------------------------------------*

*& Report ZEDR25_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_021.



TABLES : zedt25_001.



DATA : BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4,

  ZCODE LIKE ZEDT25_001-ZCODE,

  ZPERNR LIKE ZEDT25_001-ZPERNR,

  ZKNAME LIKE ZEDT25_001-ZKNAME,

  ZENAME LIKE ZEDT25_001-ZENAME,

  ZGENDER LIKE ZEDT25_001-ZGENDER,

  ZMAJOR LIKE ZEDT25_002-ZMAJOR,

  ZMNAME LIKE ZEDT25_002-ZMNAME,

  END OF GS_STUDENT.



DATA : BEGIN OF GT_STUDENT OCCURS 0,

  ZCOLOR TYPE C LENGTH 4,

  ZCODE LIKE ZEDT25_001-ZCODE,

  ZPERNR LIKE ZEDT25_001-ZPERNR,

  ZKNAME LIKE ZEDT25_001-ZKNAME,

  ZENAME LIKE ZEDT25_001-ZENAME,

  ZGENDER LIKE ZEDT25_001-ZGENDER,

  ZMAJOR LIKE ZEDT25_002-ZMAJOR,

  ZMNAME LIKE ZEDT25_002-ZMNAME,

  END OF GT_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.





SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECT-OPTIONS : s_zcode FOR zedt25_001-zcode.

PARAMETERS : P_ZPERNR LIKE ZEDT25_001-ZCODE.

PARAMETERS : P_ZGEN LIKE ZEDT25_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK b1.





INITIALIZATION.

  S_ZCODE-SIGN = 'I'.

  S_ZCODE-OPTION = 'BT'.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'SC1'.

      screen-input = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM get_data.

  PERFORM MODIFY_DATA.



END-OF-SELECTION.

  PERFORM ALV_DISPLAY.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  SELECT A~ZCODE

         A~ZPERNR

         A~ZKNAME

         A~ZENAME

         A~ZGENDER

         B~ZMAJOR

         B~ZMNAME

    FROM ZEDT25_001 AS A

    INNER JOIN ZEDT25_002 AS B

    ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE A~ZCODE IN S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : GS_SORT, GT_SORT.



  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

      IS_LAYOUT   = GS_LAYOUT

      IT_SORT     = GT_SORT

    TABLES

      T_OUTTAB    = GT_STUDENT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  CLEAR GS_STUDENT.



  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZGENDER = 'M'.

      GS_STUDENT-ZCOLOR = '@0A@'.

    ELSE.

      GS_STUDENT-ZCOLOR = '@08@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR GS_STUDENT.

  ENDLOOP.

ENDFORM.