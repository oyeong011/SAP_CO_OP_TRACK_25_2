
*&---------------------------------------------------------------------*

*& Report ZEDR12_FUNCTIONALV001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_FUNCTIONALV001.

TABLES: ZEDT12_001.




* ALV-LIST




DATA: GS_STUDENT TYPE ZEDT12_001.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA: GV_ZCODE LIKE ZEDT12_001-ZCODE.

DATA: GV_ZKNAME LIKE ZEDT12_001-ZKNAME.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZCODE FOR ZEDT12_001-ZCODE.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-20'.

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

 " PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .



  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

    EXPORTING

      I_STRUCTURE_NAME = 'ZEDT12_001'

    TABLES

      T_OUTTAB = GT_STUDENT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA. "FORMAL PARAM(## ##). Subroutine## #, # ##

  SELECT * FROM ZEDT12_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM. "ENDFORM## Subroutine## #, # ##