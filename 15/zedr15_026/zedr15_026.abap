
*&---------------------------------------------------------------------*

*& Report ZEDR15_026

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_026.






*DATA : BEGIN OF GT_STUDENT OCCURS 0, "#### ## ######

**  ZCHECKBOX TYPE C, "##### #### ## ##

*  ZCODE LIKE ZEDT15_001-ZCODE, "####

*  ZPERNR LIKE ZEDT15_001-ZPERNR, "####

*  ZKNAME LIKE ZEDT15_001-ZKNAME, "##

*  ZENAME LIKE ZEDT15_001-ZENAME, "###

*  ZGENDER LIKE ZEDT15_001-ZGENDER, "##

*  ZMAJOR LIKE ZEDT15_002-ZMAJOR, "##

*  ZMNAME LIKE ZEDT15_002-ZMNAME, "###

*  END OF GT_STUDENT.






DATA : BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4, "### ### #### ## ##

  ZCODE LIKE ZEDT15_001-ZCODE, "####

  ZPERNR LIKE ZEDT15_001-ZPERNR, "####

  ZKNAME LIKE ZEDT15_001-ZKNAME, "##

  ZENAME LIKE ZEDT15_001-ZENAME, "###

  ZGENDER LIKE ZEDT15_001-ZGENDER, "##

  ZMAJOR LIKE ZEDT15_002-ZMAJOR, "##

  ZMNAME LIKE ZEDT15_002-ZMNAME, "###

  END OF GS_STUDENT.

  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



  DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

  DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

  PERFORM FIELD_CATALOG.

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

    FROM ZEDT15_001 AS A

    INNER JOIN ZEDT15_002 AS B

    ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.



    GS_STUDENT-ZCODE = 'SSU-50'. "####

    GS_STUDENT-ZENAME = ''.

    APPEND GS_STUDENT TO GT_STUDENT.



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




*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE' "## #### ### ####### ##

*  EXPORTING

*    I_PROGRAM_NAME = SY-REPID "## #### ##### #### ### ##

*    I_INTERNAL_TABNAME = 'GT_STUDENT'

*    I_INCLNAME = SY-REPID

*  CHANGING

*    CT_FIELDCAT = GT_FIELDCAT. "GT_STUDENT# #### GT_FIELDCAT# ##






  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT = GT_FIELDCAT

  TABLES

    T_OUTTAB = GT_STUDENT.

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




*  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

*  GS_FIELDCAT-COL_POS = 1.

*  GS_FIELDCAT-FIELDNAME = 'ZCHECKBOX'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-CHECKBOX = 'X'.

*  GS_FIELDCAT-EDIT = 'X'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.






  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

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

    IF GS_STUDENT-ZENAME IS INITIAL. "#### #### ### ##### ## ##

      GS_STUDENT-ZCOLOR = '@0A@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR GS_STUDENT.

  ENDLOOP.

ENDFORM.