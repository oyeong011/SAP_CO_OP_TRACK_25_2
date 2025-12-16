
*&---------------------------------------------------------------------*

*& Report ZEDR08_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_019 MESSAGE-ID ZMED08.



TABLES : ZEDT08_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT08_001
.

  DATA : END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT08_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT08_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT08_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



IF S_ZCODE IS INITIAL.

  MESSAGE I000.

ENDIF.



PERFORM GET_DATA.

IF GT_STUDENT IS INITIAL.

  MESSAGE I001.

  EXIT.

ENDIF.



PERFORM WRITE_DATA.



DATA : Z_MAJOR TYPE C LENGTH 1 VALUE 'E'.

DATA : Z_MAJOR_NAME TYPE C LENGTH 20.



IF Z_MAJOR = 'A'.

  Z_MAJOR_NAME = '#### '.

ELSEIF Z_MAJOR = 'B'.

  Z_MAJOR_NAME = '#### '.

ELSEIF Z_MAJOR = 'C'.

  Z_MAJOR_NAME = '### '.

ELSEIF Z_MAJOR = 'D'.

  Z_MAJOR_NAME = '##### '.

ELSEIF Z_MAJOR = 'E'.

  Z_MAJOR_NAME = '######  '.

ELSEIF Z_MAJOR = 'F'.

  Z_MAJOR_NAME = '### '.

ELSEIF Z_MAJOR = 'G'.

  Z_MAJOR_NAME = '### '.

ELSEIF Z_MAJOR = 'H'.

  Z_MAJOR_NAME = '### '.

ENDIF.



WRITE :/ Z_MAJOR_NAME.



CASE Z_MAJOR.

  WHEN 'A'.

    Z_MAJOR_NAME = '#### '.

  WHEN 'B'.

    Z_MAJOR_NAME = '#### '.

  WHEN 'C'.

    Z_MAJOR_NAME = '### '.

  WHEN 'D'.

    Z_MAJOR_NAME = '##### '.

  WHEN 'E'.

    Z_MAJOR_NAME = '###### '.

  WHEN 'F'.

    Z_MAJOR_NAME = '### '.

  WHEN 'G'.

    Z_MAJOR_NAME = '### '.

  WHEN 'H'.

    Z_MAJOR_NAME = '### '.

ENDCASE.



WRITE :/ Z_MAJOR_NAME.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .






*  SELECT * FROM ZEDT08_001

*    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*    WHERE ZCODE IN S_ZCODE

*    AND ZGENDER = P_ZGEN.




  SELECT *

      INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

      FROM ZEDT08_001.





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



  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.



ENDFORM.