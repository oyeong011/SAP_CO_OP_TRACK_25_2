
*&---------------------------------------------------------------------*

*& Report ZEDR12_SELECTOPTIONS002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_SELECTOPTIONS002.

TABLES: ZEDT12_001.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS : S_ZCODE FOR ZEDT12_001-ZCODE. "SELECT-OPTIONS ### ##. #### ##.

 PARAMETERS: P_ZGEN LIKE ZEDT12_001-ZGENDER.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

 PARAMETERS: P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1. "## 3### ###

 PARAMETERS: P_CH2 AS CHECKBOX MODIF ID M2. "## 3### ###

SELECTION-SCREEN END OF BLOCK B2.



AT SELECTION-SCREEN OUTPUT. "2.SELECTION-SCREEN# #### ## ##.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'. "M2### P_CH2 ### "3. MODIF ID########

      SCREEN-INPUT = '0'."4. ###### INPUT=0 : SCREEN#INPUT#0. #, ##########

      "SCREEN-ACTIVE = '0'.  "### ###.

      "SCREEN-REQUIRED = '1'.  "#### ## ####.

      "SCREEN-OUTPUT = '0'.  "#### ####.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.