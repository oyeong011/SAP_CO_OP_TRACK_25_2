
*&---------------------------------------------------------------------*

*& Report ZEDR05_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_002.

TABLES : ZEDT05_002.



DATA : BEGIN OF GS_STUDENT OCCURS 0,

  ZCOLOR TYPE C LENGTH 4,




*  ZCHECKBOX TYPE C,




  ZCODE LIKE ZEDT05_001-ZCODE,

  ZPERNR LIKE ZEDT05_001-ZPERNR,

  ZKNAME LIKE ZEDT05_001-ZKNAME,

  ZENAME LIKE ZEDT05_001-ZENAME,

  ZGENDER LIKE ZEDT05_001-ZGENDER,

  ZMAJOR LIKE ZEDT05_002-ZMAJOR,

  ZMNAME LIKE ZEDT05_002-ZMNAME,

  END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.








*data : gs_student type zedt05_002,

*      gt_student like table of gs_student.






DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

      GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV

      .

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT05_002-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT05_002-ZPERNR.




*  PARAMETERS : P_ZGEN LIKE ZEDT05_002-ZGENDER MODIF ID SC1.




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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_DISPLAY .



  PERFORM FIELD_CATALOG.



  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

    exporting

      I_PROGRAM_NAME         =     SY-REPID"

      I_INTERNAL_TABNAME     =     'GT_STUDENT'

      I_INCLNAME             =     SY-REPID

    changing

      CT_FIELDCAT            =     GT_FIELDCAT.

    .

  if sy-subrc <> 0.

  endif.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    exporting

        IT_FIELDCAT = GT_FIELDCAT




*        IS_LAYOUT = GS_LAYOUT

*        IT_SORT = GT_SORT




    tables

      T_OUTTAB                 =     GT_STUDENT.

    .

  if sy-subrc <> 0.

  endif.



endform.

form FIELD_CATALOG .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.




*  GS_FIELDCAT-CHECKBOX ='X'.




  GS_FIELDCAT-ICON = 'X'.




*  GS_FIELDCAT-EDIT = 'X'.




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




*  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

*  GS_FIELDCAT-SELTEXT_M = '##'.




  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'R'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.






*




  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMGUBUN'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.







  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-NO_ZERO = 'X'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_DATA .




*  SELECT * FROM ZEDT05_002 INTO TABLE GT_STUDENT.




  SELECT A~ZCODE

        A~ZPERNR

        A~ZKNAME

        A~ZENAME

        A~ZGENDER

        B~ZMAJOR

        B~ZMNAME

    FROM ZEDT05_001 AS A

    INNER JOIN ZEDT05_002 AS B

    ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_LAYOUT .

  GS_LAYOUT-NO_COLHEAD = 'X'.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_VLINE = 'X'.

  GS_LAYOUT-NO_HLINE = 'X'.

  GS_LAYOUT-EDIT = 'X'.

  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_SORT .

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

endform.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form MODIFY_DATA .

  CLEAR GS_STUDENT.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZENAME IS INITIAL.

      GS_STUDENT-ZCOLOR = '@0A@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR GS_STUDENT.

  ENDLOOP.

endform.