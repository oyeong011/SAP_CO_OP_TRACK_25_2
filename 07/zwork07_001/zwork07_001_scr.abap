
*&---------------------------------------------------------------------*

*&  Include           ZWORK07_001_SCR

*&---------------------------------------------------------------------*






"### # # : ####, ###(##)

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS : p_date TYPE c LENGTH 8.

  PARAMETERS : p_file TYPE rlgrap-filename.

  PARAMETERS : p_kurst TYPE kurst DEFAULT 'M' MODIF ID m1 VISIBLE LENGTH 1.

SELECTION-SCREEN END OF BLOCK b1.