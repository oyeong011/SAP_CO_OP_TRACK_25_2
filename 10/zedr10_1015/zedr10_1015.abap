
*&---------------------------------------------------------------------*

*& Report ZEDR10_1015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_1015.



CONSTANTS: C_CURR(3) TYPE C VALUE 'KRW'.



DATA: BEGIN OF GS_STUDENT,

        ZCOLOR TYPE C LENGTH 4,

        ZCODE  LIKE ZEDT10_001-ZCODE,

        ZPERNR LIKE ZEDT10_001-ZPERNR,

        ZKNAME LIKE ZEDT10_001-ZKNAME,

        ZENAME LIKE ZEDT10_001-ZENAME,

        ZTEL   LIKE ZEDT10_001-ZTEL,

        ZMNAME LIKE ZEDT10_004-ZMNAME,

        ZSUM   LIKE ZEDT10_004-ZSUM,

        ZGRADE LIKE ZEDT10_004-ZGRADE.

    include structure
ZEDS10_002
.

DATA: END OF GS_STUDENT.



DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

      GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA: GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



DATA: GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA: GT_SORT TYPE SLIS_T_SORTINFO_ALV.



START-OF-SELECTION.

  PERFORM GET_STUDENT_DATA.

  PERFORM MODIFY_DATA.



END-OF-SELECTION.

  PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  GET_STUDENT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_STUDENT_DATA .

  SELECT

    T1~ZCODE

    T1~ZPERNR

    T1~ZKNAME

    T1~ZENAME

    T1~ZTEL

    T4~ZMNAME

    T4~ZSUM

    T4~ZGRADE

    FROM

      ZEDT10_004 AS T4

      INNER JOIN ZEDT10_001 AS T1

          ON T1~ZCODE = T4~ZCODE

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



  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 0.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = 'STATE'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = C_CURR.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-NO_ZERO = 'X'.




*  GS_FIELDCAT-NO_SIGN = 'X'.




  GS_FIELDCAT-EMPHASIZE = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZGRADE'.

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




*  GS_LAYOUT-EDIT = 'X'.




  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'.

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

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

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




*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

*    EXPORTING

*      I_PROGRAM_NAME     = SY-REPID

*      I_INTERNAL_TABNAME = 'GT_STUDENT'

*      I_INCLNAME         = SY-REPID

*    CHANGING

*      CT_FIELDCAT        = GT_FIELDCAT.






  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING




*     I_STRUCTURE_NAME = 'ZEDT10_004'




      IT_FIELDCAT = GT_FIELDCAT

      IS_LAYOUT   = GS_LAYOUT

      IT_SORT     = GT_SORT

    TABLES

      T_OUTTAB    = GT_STUDENT.



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

    IF GS_STUDENT-ZGRADE = 'F'.

      GS_STUDENT-ZCOLOR = '@0A@'.

    ELSEIF GS_STUDENT-ZGRADE > 'C'.

      GS_STUDENT-ZCOLOR = '@09@'.

    ELSE.

      GS_STUDENT-ZCOLOR = '@08@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

  ENDLOOP.

ENDFORM.