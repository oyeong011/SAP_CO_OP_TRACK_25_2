
*&---------------------------------------------------------------------*

*& Report ZEDR25_18

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_18.



TABLES : zedt25_001.



DATA : BEGIN OF gs_student.

    include structure
zedt25_001
.

DATA : END OF gs_student.

DATA : gt_student LIKE TABLE OF gs_student.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.





SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECT-OPTIONS : s_zcode FOR zedt25_001-zcode.

PARAMETERS : P_ZPERNR LIKE ZEDT25_001-ZCODE.

PARAMETERS : P_ZGEN LIKE ZEDT25_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK b1.





INITIALIZATION.

  s_zcode-low = 'ssu-01'.

  s_zcode-high = 'ssu-99'.

  APPEND s_zcode.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'SC1'.

      screen-input = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM get_data.




*  PERFORM modify_data.






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

SELECT * FROM zedt25_001

    INTO CORRESPONDING FIELDS OF TABLE gt_student

  WHERE zcode IN s_zcode.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*FORM MODIFY_DATA .

*

*

*ENDFORM.






FORM ALV_DISPLAY.




*CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*  EXPORTING

*    I_STRUCTURE_NAME = 'ZEDT25_001'

*  TABLES

*    T_OUTTAB = GT_STUDENT.






  PERFORM FIELD_CATALOG.

  PERFORM CALL_ALV.

ENDFORM.





FORM FIELD_CATALOG.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.





FORM CALL_ALV .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

   TABLES

      T_OUTTAB   = GT_STUDENT.

ENDFORM.