
*&---------------------------------------------------------------------*

*& Report ZEDR09_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_023.



TABLES : ZEDT09_001.



DATA : GS_STUDENT LIKE ZEDT09_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT09_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



IF S_ZCODE IS INITIAL.

  WRITE : / 'S_ZCODE# # ####'.

ENDIF.



PERFORM GET_DATA.



IF GT_STUDENT IS INITIAL.

  WRITE : / 'GT_STUDENT #### # ####'.

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




FORM GET_DATA . "## selection-screen# ## select### ### ##

  SELECT *

  FROM ZEDT09_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE

  AND ZGENDER = P_ZGEN.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WRITE_DATA . "GET_DATA## ### GT_STUDENT LOOP# ##

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.



ENDFORM.