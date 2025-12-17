
*&---------------------------------------------------------------------*

*& Report ZEDR20_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_023.



DATA: BEGIN OF GT_STUDENT OCCURS 0,

  "ZCHECKBOX TYPE C,

  ZCOLOR(4),

  ZCODE LIKE ZEDT20_001-ZCODE,

  ZPERNR LIKE ZEDT20_001-ZPERNR,

  ZKNAME LIKE ZEDT20_001-ZKNAME,

  ZENAME LIKE ZEDT20_001-ZENAME,

  ZGENDER LIKE ZEDT20_001-ZGENDER,

  ZMAJOR LIKE ZEDT20_002-ZMAJOR,

  ZMNAME LIKE ZEDT20_002-ZMNAME,

  END OF GT_STUDENT.



DATA: GS_STUDENT LIKE GT_STUDENT.



DATA: GS_FIELDCAT TYPE slis_fieldcat_alv,

      GT_FIELDCAT TYPE slis_t_fieldcat_alv.



PERFORM GET_DATA.

PERFORM FIELD_CATALOG.

PERFORM MODIFY_DATA.

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

  SELECT A~ZCODE

         A~ZPERNR

         A~ZKNAME

         A~ZENAME

         A~ZGENDER

         B~ZMAJOR

         B~ZMNAME

    FROM ZEDT20_001 AS A

    INNER JOIN ZEDT20_002 AS B

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




*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

*    EXPORTING

*      I_PROGRAM_NAME               = SY-REPID

*      I_INTERNAL_TABNAME           = 'GT_STUDENT'

*      I_INCLNAME                   = SY-REPID

*    CHANGING

*      CT_FIELDCAT                  = GT_FIELDCAT.






  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT                       = GT_FIELDCAT

    TABLES

      T_OUTTAB                          = GT_STUDENT.





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

 CLEAR: GT_FIELDCAT, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.




*  GS_FIELDCAT-FIELDNAME = 'ZCHECKBOX'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-CHEKCBOX = 'X'.




  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'R'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-JUST = 'L'.

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

 LOOP AT GT_STUDENT[] INTO GS_STUDENT.

   IF GS_STUDENT-ZPERNR / 8 = 1.

     GS_STUDENT-ZCOLOR = '@0A@'.

   ELSEIF GS_STUDENT-ZPERNR / 8 = 2.

     GS_STUDENT-ZCOLOR = '@09@'.

   ELSE.

     GS_STUDENT-ZCOLOR = '@08@'.

   ENDIF.



   MODIFY GT_STUDENT[] FROM GS_STUDENT INDEX SY-TABIX.

   CLEAR GS_STUDENT.

  ENDLOOP.

ENDFORM.