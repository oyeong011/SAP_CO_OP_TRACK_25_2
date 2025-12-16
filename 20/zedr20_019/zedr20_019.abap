
*&---------------------------------------------------------------------*

*& Report ZEDR20_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_019 MESSAGE-ID ZMED20.



TABLES: ZEDT20_001.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT20_001
.

  DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: GV_ZKNAME LIKE ZEDT20_001-ZKNAME.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZCODE FOR ZEDT20_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-20'.

  PARAMETERS: P_ZPERNR LIKE ZEDT20_001-ZPERNR.

  PARAMETERS: P_ZGEN LIKE ZEDT20_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



RANGES R_ZCODE FOR ZEDT20_001-ZCODE.



IF S_ZCODE IS INITIAL.

  MESSAGE I000.

ENDIF.



PERFORM GET_DATA USING S_ZCODE[]

                CHANGING GT_STUDENT.



IF GT_STUDENT IS INITIAL.

  MESSAGE I001.

  EXIT.

ENDIF.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE: / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA USING P_ZCODE LIKE S_ZCODE[]

              CHANGING PT_STUDENT LIKE GT_STUDENT.

  IF P_ZCODE IS INITIAL.

    WRITE:/ '#### ######.'.

  ENDIF.

  SELECT *

    FROM ZEDT20_001

    INTO CORRESPONDING FIELDS OF TABLE PT_STUDENT

    WHERE ZCODE IN P_ZCODE.

ENDFORM.