
*&---------------------------------------------------------------------*

*& Report ZEDR04_068

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_068.



TABLES ZEDT04_001.  " SELECT-OPTIONS ## ## ##



DATA GS_STUDENT TYPE ZEDT04_001.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.  " 1. ### ### #### ###

  SELECT-OPTIONS S_ZCODE FOR ZEDT04_001-ZCODE DEFAULT 'SSU-01' MODIF ID M1.         " ## ## 3##




*                                             DEFAULT 'SSU-01' SIGN I OPTION EQ             " ###

*                                             DEFAULT 'SSU-01' SIGN E OPTION EQ

*                                             DEFAULT 'SSU-01' TO 'SSU-99' SIGN I OPTION BT " ###

*                                             NO INTERVALS NO-EXTENSION

*                                             VISIBLE LENGTH 3




  PARAMETERS P_ZGEN LIKE ZEDT04_001-ZGENDER MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M3.

  PARAMETERS P_CH2 AS CHECKBOX MODIF ID M4.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.  " 2. (#### ## # ### ## ##)

  PARAMETERS P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B3.



" 3. SELECTION-SCREEN# #### ## ##

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.  " 4. MODIF ID# ## ### ##




*   IF SCREEN-NAME = 'P_ZGEN'.




      IF P_R1 = 'X'.

        " 5. ### # ## (SE11 -> DATA TYPE -> SCREEN ##)

        SCREEN-ACTIVE = '1'.       " M2 ### # ##




*       SCREEN-INPUT = '0'.        " ## ##

*       SCREEN-REQUIRED = '1'.     " ## ## ##

*       SCREEN-OUTPUT = '0'.       " TEXT ELEMENT ## # ##

*       SCREEN-INTENSIFIED = '1'.  " ## ##(1# ###)

*       SCREEN-DISPLAYED_3D = '1'. " ## ##(##### ###)

*       SCREEN-INVISIBLE = '1'.    " ### ASTER#




      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.  " ## ##

  ENDLOOP.



" ## ### #### ## ##

SELECT * FROM ZEDT04_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE    " SELECT-OPTIONS ### IN

  AND ZGENDER = P_ZGEN.     " PARAMETERS ### EQ



IF GT_STUDENT[] IS NOT INITIAL.

  CLEAR : GS_STUDENT.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.

ELSE.

  WRITE / '### ##'.

ENDIF.