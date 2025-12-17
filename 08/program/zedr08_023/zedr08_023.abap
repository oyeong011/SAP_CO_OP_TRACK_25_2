
*&---------------------------------------------------------------------*

*& Report ZEDR08_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_023.



TABLES : ZEDT08_001.



DATA : GS_STUDENT TYPE ZEDT08_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT08_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT08_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT08_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.