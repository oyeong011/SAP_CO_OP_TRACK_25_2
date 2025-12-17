
*&---------------------------------------------------------------------*

*& Report ZEDR022_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_016 MESSAGE-ID ZMED22."##### ##### #### ###, f5# ## ##



TABLES : ZEDT022_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT022_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT022_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT022_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT022_001-ZGENDER DEFAULT 'M'.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



AT SELECTION-SCREEN ON S_ZCODE.

  LOOP AT SCREEN.

    IF S_ZCODE-LOW NE 'SSU-01'.

      MESSAGE '##### SSU-01## #####' TYPE 'E'.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM GET_DATA.



IF S_ZCODE IS INITIAL.

  MESSAGE I000.

ENDIF.



PERFORM GET_DATA.

IF GT_STUDENT IS INITIAL.

  MESSAGE I001.

  EXIT.

  ENDIF.

PERFORM WRITE_DATA.



FORM GET_DATA.



SELECT * FROM ZEDT022_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.

  "WHERE ZCODE IN S_ZCODE

  "AND ZGENDER = P_ZGEN.

ENDFORM.






* ### ## #### ##




FORM WRITE_DATA.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

    ENDLOOP.

ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### SSU-01## #####