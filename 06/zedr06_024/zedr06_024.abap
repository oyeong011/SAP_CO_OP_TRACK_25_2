
*&---------------------------------------------------------------------*

*& Report ZEDR06_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_024.



TABLES ZEDT06_002.



DATA : GS_STUDENT TYPE ZEDT06_002.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT06_002-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT06_002-ZPERNR.

SELECTION-SCREEN END OF BLOCK B1.





START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.






*&-------------------------------------------------------------------

*&  FORM ALV_DISPLAY

*&-------------------------------------------------------------------




FORM ALV_DISPLAY.

  PERFORM FIELD_CATALOG.

  PERFORM CALL_ALV.

ENDFORM.








*&-------------------------------------------------------------------

*&  FORM ALV_DISPLAY

*&-------------------------------------------------------------------




FORM FIELD_CATALOG.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

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



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-NO_ZERO = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-EDIT_MASK = '____-__-__'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.






*&-------------------------------------------------------------------

*&  FORM CALL_ALV

*&-------------------------------------------------------------------




FORM CALL_ALV.



    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

   TABLES

      T_OUTTAB                      = GT_STUDENT.



  IF SY-SUBRC = 0.

    WRITE :/ '## ##'.

  ENDIF.



ENDFORM.








*&-------------------------------------------------------------------

*&  GET_DATA

*&-------------------------------------------------------------------




FORM GET_DATA.

  CLEAR GT_STUDENT.

  SELECT * FROM ZEDT06_002

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.






*&-------------------------------------------------------------------

*&  MODIFY_DATA

*&-------------------------------------------------------------------




FORM MODIFY_DATA.

  CLEAR GS_STUDENT.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZCODE = 'SSU-01'.

      GS_STUDENT-ZPERNR = '01'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT.

  ENDLOOP.

ENDFORM.