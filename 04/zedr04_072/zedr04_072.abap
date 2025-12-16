
*&---------------------------------------------------------------------*

*& Report ZEDR04_072

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_072 MESSAGE-ID ZMED04. " MESSAGE ### ##



TABLES : ZEDT04_001.  " SELECT-OPTIONS# #### ##



DATA GS_STUDENT TYPE ZEDT04_001.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT04_001-ZCODE.    " ## ## #### SELECT-OPTIONS#

  PARAMETERS : P_ZPERNR LIKE ZEDT04_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT04_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.





INITIALIZATION. " ### ##. START-OF-SELECTION ### ##.

  " SELECT-OPTIONS : S_ZCODE FOR ZEDT04_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-99'. # ## ##

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



AT SELECTION-SCREEN ON S_ZCODE. " #### # ## # ##

  IF S_ZCODE-LOW NE 'SSU-01'.

    MESSAGE '##### SSU-01## #####.' TYPE 'E'. " ERROR

  ENDIF.






*AT SELECTION-SCREEN ON END OF S_ZCODE. " SELECTION TABLE# # ## # ##?

*  LOOP AT S_ZCODE.

*    IF S_ZCODE-LOW NE 'SSU-01'.

*      MESSAGE '## ##### SSU-01## #####.' TYPE 'E'.

*    ENDIF.

*  ENDLOOP.



*AT SELECTION-SCREEN OUTPUT. " ## ## ### ### ##

*  LOOP AT SCREEN.

*    IF SCREEN-GROUP1 = 'SC1'.

*      SCREEN-INPUT = 0.

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.






START-OF-SELECTION. " ### F8 ### SELECT## #### ##

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.   " !##

    EXIT.

  ENDIF.



  PERFORM GET_DATA.



  IF GT_STUDENT IS INITIAL.

    MESSAGE I001.

    EXIT.

  ENDIF.



END-OF-SELECTION.

  PERFORM WRITE_DATA.





" SUBROUTINE ##






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT04_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*




FORM WRITE_DATA .

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.

ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### SSU-01## #####.