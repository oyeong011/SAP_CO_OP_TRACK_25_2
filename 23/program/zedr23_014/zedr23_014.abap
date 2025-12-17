
*&---------------------------------------------------------------------*

*& Report ZEDR23_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_014 MESSAGE-ID ZMED23.



" CASE [Field].

"   WHEN [Value].



"***MESSAGE***"



TABLES ZEDT23_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT23_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT23_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT23_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT23_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



"*** 1. INITIALIZATION -> ### START-OF-SELECTION ### #.***"

INITIALIZATION.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-20'.

APPEND S_ZCODE.



"*** 2. AT SELECTION-SCREEN ON ***"

"AT SELECTION-SCREEN ON S_ZCODE.

"  IF S_ZCODE-LOW NE 'SSU-01'.

"    MESSAGE '##### SSU-01## #####.' TYPE 'E'.

"  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = '0'.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.





IF S_ZCODE IS INITIAL.

  MESSAGE E000.       " I : ## ###. ## ###. ## #### ###

ENDIF.                " E : ## ###. ## #### #### ##.



"*** 3. START-OF-SELECTION : '##' ### ### ***"

START-OF-SELECTION.

  PERFORM GET_DATA.



IF GT_STUDENT IS INITIAL.

  MESSAGE I001.

  EXIT.

ENDIF.

BREAK-POINT.



"*** 4. END-OF-SELECTION : ## ### ***"

END-OF-SELECTION.

  PERFORM WRITE_DATA.









FORM GET_DATA.

  BREAK-POINT.

  SELECT * FROM ZEDT23_001

    INTO TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.



FORM WRITE_DATA.

  LOOP AT GT_STUDENT INTO DATA(line).

    WRITE : / line-ZCODE, line-ZPERNR, line-ZKNAME, line-ZGENDER.

  ENDLOOP.

ENDFORM.