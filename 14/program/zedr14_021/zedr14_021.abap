
*&---------------------------------------------------------------------*

*& Report ZEDR14_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_021 MESSAGE-ID ZMED14.



TABLES : ZEDT00_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT00_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE GS_STUDENT.



"CASE~ENDCASE




*CASE GS_STUDENT-Z_MAJOR.

*  WHEN 'A'.

*    GS_STUDENT-Z_MAJOR-NAME = '#### '.

*  WHEN 'B'.

*    GS_STUDENT-Z_MAJOR-NAME = '#### '.

*  WHEN 'C'.

*    GS_STUDENT-Z_MAJOR-NAME = '### '.

*  ENDCASE.






"MESSAGE

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT00_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



IF S_ZCODE IS INITIAL.

  MESSAGE E000.

  MESSAGE I000.

ENDIF.



PERFORM GET_DATA.

IF GT_STUDENT IS INITIAL.

  MESSAGE I001.

  EXIT.

ENDIF.

PERFORM WRITE_DATA.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WRITE_DATA .



ENDFORM.