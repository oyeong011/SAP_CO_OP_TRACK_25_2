
*&---------------------------------------------------------------------*

*& Report ZEDR06_027

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_027.



" ## ##### ### ### ###

DATA : BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4,

  ZCHECKBOX TYPE C,

  ZCODE LIKE ZEDT06_001-ZCODE,

  ZPERNR LIKE ZEDT06_001-ZPERNR,

  ZKNAME LIKE ZEDT06_001-ZKNAME,

  ZENAME LIKE ZEDT06_001-ZENAME,

  ZGENDER LIKE ZEDT06_001-ZGENDER,

  ZMAJOR LIKE ZEDT06_002-ZMAJOR,

  ZMNAME LIKE ZEDT06_002-ZMNAME,

  END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



" ## #### ##.

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.





START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.






*&-------------------------------------------------------------------

*&  FORM GET_DATA

*&-------------------------------------------------------------------




FORM GET_DATA.

  SELECT

      A~ZCODE

      A~ZPERNR

      A~ZKNAME

      A~ZENAME

      A~ZGENDER

      B~ZMAJOR

      B~ZMNAME

    FROM ZEDT06_001 AS A

    INNER JOIN ZEDT06_002 AS B

    ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

ENDFORM.






*&-------------------------------------------------------------------

*&  FORM MIDIFY_DATA.

*&-------------------------------------------------------------------




FORM MODIFY_DATA.

  CLEAR GS_STUDENT.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZENAME IS INITIAL.

      GS_STUDENT-ZCOLOR = '@0A@'.

    ELSE.

      GS_STUDENT-ZCOLOR = '@08@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR GS_STUDENT.

  ENDLOOP.

ENDFORM.








*&-------------------------------------------------------------------

*&  FORM CALL_ALV.

*&-------------------------------------------------------------------




FORM FIELD_CATALOG.



  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

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

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SELTEXT_M = '####'.

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



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZCHECKBOX'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.






*&-------------------------------------------------------------------

*&  FORM ALV_DISPLAY

*&-------------------------------------------------------------------




FORM ALV_DISPLAY.

  PERFORM FIELD_CATALOG.

  PERFORM CALL_ALV.

ENDFORM.






*&-------------------------------------------------------------------

*&  FORM CALL_ALV.

*&-------------------------------------------------------------------




FORM CALL_ALV.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT                       = GT_FIELDCAT

    TABLES

     T_OUTTAB                          = GT_STUDENT.

ENDFORM.