
*&---------------------------------------------------------------------*

*& Report ZEDR24_016_MSG

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_016_MSG MESSAGE-ID ZEDM24.



TABLES : ZEDT24_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT24_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT24_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT24_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT24_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



PERFORM GET_DATA.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  IF GT_STUDENT IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.

ENDFORM.