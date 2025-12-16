
REPORT ZEDR13_051 MESSAGE-ID ZMED13.



TABLES : ZEDT13_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT13_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT13_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT13_001-ZPERNR.




*  PARAMETERS : P_ZGEN LIKE ZEDT13_001-ZGENDER DEFAULT 'M'.




  PARAMETERS : P_ZGEN LIKE ZEDT13_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-09'.

APPEND S_ZCODE.






*AT SELECTION-SCREEN ON S_ZCODE.

*  IF S_ZCODE-LOW NE 'SSU-01'.

*    MESSAGE '##### SSU-01## #####' TYPE 'E'.

*  ENDIF.



*AT SELECTION-SCREEN ON END OF S_ZCODE.

*  LOOP AT S_ZCODE.

*    IF S_ZCODE-LOW NE 'SSU-01'.

*      MESSAGE '##### SSU-01## #####' TYPE 'E'.

*    ENDIF.

*  ENDLOOP.



*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF SCREEN-GROUP1 = 'SC1'.

*      SCREEN-INPUT = 0.

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.






START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM WRITE_DATA.










*IF S_ZCODE IS INITIAL.

**  MESSAGE E000.

*  MESSAGE I000. "#### ## ### ##

**  EXIT. "### ### ########## SCREEN## ###

*ENDIF.



*PERFORM GET_DATA.

*IF GT_STUDENT IS INITIAL.

*  MESSAGE I001.

*  EXIT.

*ENDIF.



*PERFORM WRITE_DATA.

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