
*&---------------------------------------------------------------------*

*& Report ZEDR15_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_021.



TABLES : ZEDT15_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT15_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT15_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT15_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT15_001-ZGENDER DEFAULT 'M'.

SELECTION-SCREEN END OF BLOCK B1.



"selection screen# ### # ## ## # ###

INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'. "S_ZCODE # ###

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



"## selection table# #### ##




*AT SELECTION-SCREEN ON END OF S_ZCODE.

*  LOOP AT S_ZCODE.

*    IF S_ZCODE-LOW NE 'SSU-01'.

*      MESSAGE '##### SSU-01## #####' TYPE 'E'.

*    ENDIF.

*  ENDLOOP.






"selection screen### layout## ##

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



"####(f8)# ### ###(select### #### ##)/intialization# # # ##

START-OF-SELECTION.

  PERFORM GET_DATA.



"## #### ## # ### ##

END-OF-SELECTION.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT15_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.