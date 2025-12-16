
*&---------------------------------------------------------------------*

*& Report ZEDR01_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_016.








*DATA : GS_STUDENT TYPE ZEDT01_001,

*       GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*RANGES : S_ZCODE FOR ZEDT01_001-ZCODE.

*

*INITIALIZATION.

*S_ZCODE-SIGN = 'I'.

*S_ZCODE-OPTION = 'BT'.

*S_ZCODE-LOW = 'SSU-01'.

*S_ZCODE-HIGH = 'SSU-99'.

*APPEND S_ZCODE.

*

*SELECT * FROM ZEDT01_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*  WHERE ZCODE IN S_ZCODE.

*

*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF SCREEN-GROUP1 = 'SC1'.

*      SCREEN-INPUT = 0.

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.

*

*END-OF-SELECTION.

*  PERFORM ALV_DISPLAY.

*

*

*FORM ALV_DISPLAY .

*CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*  EXPORTING

*    I_STRUCTURE_NAME = 'ZEDT01_001'

*  TABLES

*    T_OUTTAB = GT_STUDENT.

*ENDFORM.






TABLES : ZEDT01_001.



DATA : GS_STUDENT TYPE ZEDT01_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT01_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT01_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT01_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-SIGN = 'I'.

S_ZCODE-OPTION = 'BT'.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



SELECT * FROM ZEDT01_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE.



END-OF-SELECTION.

  PERFORM ALV_DISPLAY.




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

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*






FORM CALL_ALV .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

   TABLES

      T_OUTTAB   = GT_STUDENT.

ENDFORM.