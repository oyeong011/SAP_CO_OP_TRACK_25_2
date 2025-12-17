
*&---------------------------------------------------------------------*

*& Report ZEDR09_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT ZEDR09_024 MESSAGE-ID ZMED09. "Message #### ##### ##






* =====================================================================

* 1. CASE ~ ENDCASE#

*   - IF### ## + ### ##

*

* 2. MESSAGE

*   - ##### ### #####, ## ## ## #### ## ## ##

*   - ##, ##### ##### #####, #### ## ## ## ## ### # ##

*   - ## ### #

*       1. MESSAGE# SE91 ###### #### ####.

*          ##, #### ### #### ####, # #### #### ### # #### ###

*       2. MESSAGE-ID# ##### ### ### #####

*       3. MESSAGE ## #####(type)# ####, # ### ## ## ##

*          - I (information, ###) : ### ####, ##### ## ##..

*          - E (error, ##) : ### ###, #### ### ###.

*                             ##, EXIT# ## #### ## ## # ## #### ## ## ##!



* =====================================================================



* 1. CASE#

*  DATA : GS_STUDENT LIKE ZEDT09_002.

*

*  DATA : BEGIN OF GS_WRITE,

*    Z_MAJOR_NAME LENGTH 20 TYPE C,

*  END OF GS_WRITE.

*

*  CASE GS_STUDENT-ZMAJOR.

*    WHEN 'A'.

*      GS_WRITE-Z_MAJOR_NAME = '####'.

*    WHEN 'B'.

*      GS_WRITE-Z_MAJOR_NAME = '####'.

*    WHEN 'C'.

*      GS_WRITE-Z_MAJOR_NAME = '###'.

*    WHEN 'D'.

*      GS_WRITE-Z_MAJOR_NAME = '#####'.

*    WHEN 'E'.

*      GS_WRITE-Z_MAJOR_NAME = '######'.

*    WHEN 'F'.

*      GS_WRITE-Z_MAJOR_NAME = '###'.

*    WHEN 'G'.

*      GS_WRITE-Z_MAJOR_NAME = '###'.

*    WHEN 'h'.

*      GS_WRITE-Z_MAJOR_NAME = '###'.

*  ENDCASE.



* 2. MESSAGE




TABLES : ZEDT09_001.



DATA : GS_STUDENT LIKE ZEDT09_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT09_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



IF S_ZCODE IS INITIAL.

  MESSAGE I000.

  " 000# # ### ### ###

  " ## I,E,W# ## ### ### ## # ###, I# information, E# error, W# warning

  EXIT.

ENDIF.



PERFORM GET_DATA.



IF GT_STUDENT IS INITIAL.

  WRITE : / 'GT_STUDENT #### # ####'.

ENDIF.



PERFORM WRITE_DATA.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA . "## selection-screen# ## select### ### ##

  SELECT *

  FROM ZEDT09_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE

  AND ZGENDER = P_ZGEN.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WRITE_DATA . "GET_DATA## ### GT_STUDENT LOOP# ##

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.



ENDFORM.