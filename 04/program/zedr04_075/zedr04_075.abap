
*&---------------------------------------------------------------------*

*& Report ZEDR04_075

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_075.



" ZEDR04_072 ##



TABLES : ZEDT04_001.  " SELECT-OPTIONS# #### ##



DATA GS_STUDENT TYPE ZEDT04_001.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



" ## ####. FUNCTION 'REUSE_ALV_GRID_DISPLAY'## ###

DATA GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT04_001-ZCODE.    " ## ## #### SELECT-OPTIONS#

  PARAMETERS : P_ZPERNR LIKE ZEDT04_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT04_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.





INITIALIZATION. " ### ##. START-OF-SELECTION ### ##.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



AT SELECTION-SCREEN OUTPUT. " ## ## ### ### ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION. " ### F8 ### SELECT## #### ##

  PERFORM GET_DATA.

END-OF-SELECTION. " ### F8 ### SELECT## #### ### #




*  PERFORM WRITE_DATA.  " ## ## ALV_DISPLAY ##




  PERFORM ALV_DISPLAY.



" SUBROUTINE ##






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT04_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*FORM WRITE_DATA .

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*  ENDLOOP.

*ENDFORM.



*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .



" 1. ALV_LIST




*CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'  " ABAP DICTIONARY## ELEMENT# FIELD ## ## ##### ##

*  EXPORTING

*    I_STRUCTURE_NAME               = 'ZEDT04_001'

*  TABLES

*    T_OUTTAB                       = GT_STUDENT.    " ### ### ###






" 2. ALV-GRID

PERFORM FIELD_CATALOG.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT                       = GT_FIELDCAT   " ### ## ## #### ##




*    I_STRUCTURE_NAME                  = 'ZEDT04_001'  " ABAP DICTIONARY## ELEMENT# FIELD ## ## ##### ##




  TABLES

    T_OUTTAB                          = GT_STUDENT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  " SE11 -> TYPE GROUP -> SLIS(SAP LIST) ##

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-seltext_m = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.