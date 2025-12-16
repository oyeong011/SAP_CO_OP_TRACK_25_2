
*&---------------------------------------------------------------------*

*& Report ZEDR06_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_020 MESSAGE-ID ZMED06.






*&---------------------------------------------------------------------*




" CASE-ENDCASE

DATA : BEGIN OF GS_STUDENT002.

  include structure
ZEDT06_002
.

  DATA : END OF GS_STUDENT002.

DATA : GT_STUDENT002 LIKE TABLE OF GS_STUDENT002.



DATA : GS_WRITE LIKE GS_STUDENT002.



SELECT SINGLE * FROM ZEDT06_002

  INTO GS_STUDENT002

  WHERE ZCODE = 'SSU-06'.





CASE GS_STUDENT002-ZMAJOR.

  WHEN 'A'.

    GS_WRITE-ZMNAME = '####'.

  WHEN 'B'.

    GS_WRITE-ZMNAME = 'B'.

  WHEN 'C'.

    GS_WRITE-ZMNAME = 'C'.

  WHEN 'D'.

    GS_WRITE-ZMNAME = 'D'.

  WHEN 'E'.

    GS_WRITE-ZMNAME = 'E'.

  WHEN 'F'.

    GS_WRITE-ZMNAME = 'F'.

ENDCASE.



WRITE :/ GS_WRITE-ZMNAME.






*&---------------------------------------------------------------------*




" CASE-ENDCASE

TABLES ZEDT06_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT06_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS S_ZCODE FOR ZEDT06_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT06_001-ZCODE.

  PARAMETERS : P_ZGEN LIKE ZEDT06_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



IF S_ZCODE IS INITIAL.

  MESSAGE I000.

  EXIT.

ENDIF.



PERFORM GET_DATA.

IF GT_STUDENT IS INITIAL.

  MESSAGE I001.

  EXIT.

ENDIF.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZGENDER.

ENDLOOP.



FORM GET_DATA.

  SELECT * FROM ZEDT06_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.