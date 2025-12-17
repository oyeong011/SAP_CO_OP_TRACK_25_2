
*&---------------------------------------------------------------------*

*& Report ZEDR21_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR21_014 MESSAGE-ID ZMED21.

TABLES : ZEDT21_001.

"MESSAGE ##






*DATA : BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT21_001.

*  DATA : END OF GS_STUDENT.

*

* DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "MULTIPLE SELECTION ### ##

 SELECT-OPTIONS : S_ZCODE FOR ZEDT21_001-ZCODE21.

  PARAMETERS : Z_PERNR LIKE ZEDT21_001-ZPERNR21.

  PARAMETERS : P_ZGEN LIKE ZEDT21_001-ZGUBUN21. "MATCHCODE# ### #### SEARCH HELP## ### ##

SELECTION-SCREEN END OF BLOCK B1.




*

*"SELECTION-SCREEN ###

*INITIALIZATION.

*S_ZCODE-LOW = 'SSU-02'.

*S_ZCODE-HIGH = 'SSU-99'.

*APPEND S_ZCODE.

*

*"### ## #### ERROR ##

*AT SELECTION-SCREEN ON S_ZCODE.

*  IF S_ZCODE-LOW NE 'SSU-01'.

*    MESSAGE '##### SSU-01### ##' TYPE 'E'.

*    ENDIF.






"MESSAGE ##




*IF S_ZCODE IS INITIAL.

*  MESSAGE E000.

*  ENDIF.