
*&---------------------------------------------------------------------*

*& Report ZEDR24_017_PROGRAM_STRUCTURE

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_017_PROGRAM_STRUCTURE MESSAGE-ID ZEDM24.



TABLES : ZEDT24_001.



"0. SCREEN ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT24_001-ZCODE.

  PARAMETERS : P_PERNR LIKE ZEDT24_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT24_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



"1. INITIALIZATION

INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-09'.



DATA : GS_STUDENT LIKE ZEDT24_001,

       GT_STUDENT LIKE TABLE OF GS_STUDENT.

APPEND S_ZCODE.



"2. AT SELECTION-SCREEN

"2-1. ON




*AT SELECTION-SCREEN ON S_ZCODE.

*  IF S_ZCODE-LOW NE 'SSU-01'.

*    MESSAGE '##### SSU-01## #####' TYPE 'E'.

*  ENDIF.






"2-2. ON END OF FIELD




*AT SELECTION-SCREEN ON END OF S_ZCODE.

*  LOOP AT S_ZCODE.

*    IF S_ZCODE-LOW NE 'SSU-01'.

*      MESSAGE '##### SSU-01## #####' TYPE 'E'.

*    ENDIF.

*  ENDLOOP.






"2-3. OUTPUT

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



"3. START-OF-SELECTION

START-OF-SELECTION.

  PERFORM GET_DATA.

END-OF-SELECTION.

  PERFORM WRITE_DATA.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT24_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

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