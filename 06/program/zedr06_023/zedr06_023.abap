
*&---------------------------------------------------------------------*

*& Report ZEDR06_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_023.



DATA GS_STUDENT TYPE ZEDT06_001.

DATA GT_STUDENT TYPE TABLE OF ZEDT06_001.



SELECTION-SCREEN BEGIN OF BLOCK SC1.

  SELECT-OPTIONS: S_ZCODE FOR GS_STUDENT-ZCODE.

SELECTION-SCREEN END OF BLOCK SC1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.





START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       ## : ##

*----------------------------------------------------------------------*




FORM GET_DATA.

  CLEAR GT_STUDENT.

  SELECT * FROM ZEDT06_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       ## : ##

*----------------------------------------------------------------------*




FORM MODIFY_DATA.

  CLEAR GS_STUDENT.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZCODE = 'SSU-01'.

      GS_STUDENT-ZPERNR = '01'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       ## : ALV LIST ##

*----------------------------------------------------------------------*




FORM ALV_DISPLAY.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     I_STRUCTURE_NAME               = 'ZEDT06_001'

    TABLES

      T_OUTTAB                      = GT_STUDENT.



  IF SY-SUBRC = 0.

    WRITE :/ '## ##'.

  ENDIF.



ENDFORM.