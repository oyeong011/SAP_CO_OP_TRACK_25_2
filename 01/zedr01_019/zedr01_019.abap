
*&---------------------------------------------------------------------*

*& Report ZEDR01_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_019.



TABLES : ZEDT01_002.



DATA : BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4,

  ZCHECKBOX TYPE C,

  ZCODE LIKE ZEDT01_001-ZCODE,

  ZPERNR LIKE ZEDT01_001-ZPERNR,

  ZKNAME LIKE ZEDT01_001-ZKNAME,

  ZENAME LIKE ZEDT01_001-ZENAME,

  ZGENDER LIKE ZEDT01_001-ZGENDER,

  ZMAJOR LIKE ZEDT01_002-ZMAJOR,

  ZMNAME LIKE ZEDT01_002-ZMNAME,

  END OF GS_STUDENT.



DATA : BEGIN OF GT_STUDENT OCCURS 0,

  ZCOLOR TYPE C LENGTH 4,

  ZCHECKBOX TYPE C,

  ZCODE LIKE ZEDT01_001-ZCODE,

  ZPERNR LIKE ZEDT01_001-ZPERNR,

  ZKNAME LIKE ZEDT01_001-ZKNAME,

  ZENAME LIKE ZEDT01_001-ZENAME,

  ZGENDER LIKE ZEDT01_001-ZGENDER,

  ZMAJOR LIKE ZEDT01_002-ZMAJOR,

  ZMNAME LIKE ZEDT01_002-ZMNAME,

  END OF GT_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.






*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  SELECT-OPTIONS : S_ZCODE FOR ZEDT01_002-ZCODE.

*  PARAMETERS : P_ZPERNR LIKE ZEDT01_002-ZPERNR.

*SELECTION-SCREEN END OF BLOCK B1.

*

*INITIALIZATION.

*S_ZCODE-SIGN = 'I'.

*S_ZCODE-OPTION = 'BT'.

*S_ZCODE-LOW = 'SSU-01'.

*S_ZCODE-HIGH = 'SSU-99'.

*APPEND S_ZCODE.



*END-OF-SELECTION.






PERFORM GET_DATA.

PERFORM MODIFY_DATA.

PERFORM ALV_DISPLAY.




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

    FROM ZEDT01_001 AS A

    INNER JOIN ZEDT01_002 AS B

    ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .



  PERFORM FIELD_CATALOG.

  PERFORM CALL_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'. "# ### ## ### ###### ###

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

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-NO_OUT = 'X'. "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

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

  GS_FIELDCAT-FIELDNAME = 'ZCHECKBOX'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*






FORM CALL_ALV .




*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

*    EXPORTING

*      I_PROGRAM_NAME               = SY-REPID

*      I_INTERNAL_TABNAME           = 'GT_STUDENT'

*      I_INCLNAME                   = SY-REPID

*    CHANGING

*      CT_FIELDCAT                  = GT_FIELDCAT.






  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

   TABLES

     T_OUTTAB   = GT_STUDENT.

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