
*&---------------------------------------------------------------------*

*& Report ZEDR02_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_021.



"20250929 REPORT EVENT ##



TABLES : ZEDT02_001.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT02_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT02_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT02_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT02_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



"INITIALIZATION ### START-OF-SELECTION ##

INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



"ON FIELD: SELECTION SCREEN## #### ## ### ## ##




*AT SELECTION-SCREEN ON S_ZCODE.

*  IF S_ZCODE-LOW NE 'SSU-01'.

*    MESSAGE '##### SSU-01## #####.' TYPE 'E'.

*  ENDIF.






"ON END OF FIELD: SELECTION SCREEN## ## ## ## ### # ## SELECTION TABLE# #### ##




*AT SELECTION-SCREEN ON END OF S_ZCODE.

*  LOOP AT S_ZCODE.

*    IF S_ZCODE-LOW NE 'SSU-01'.

*      MESSAGE '##### SSU-01## #####.' TYPE 'E'.

*    ENDIF.

*  ENDLOOP.






"OUTPUT: SELECTION SCREEN ### LAYOUT ### ##

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



"#### ## ### ### ######## ## ## ## SELECT ### ###

START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



"SELECT#### ## #### ## # ### WRITE #### ## ##




*END-OF-SELECTION.




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

  SELECT * FROM ZEDT02_001

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

    WRITE: / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



ENDFORM.