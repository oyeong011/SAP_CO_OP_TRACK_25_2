
*&---------------------------------------------------------------------*

*& Include ZEDR10_PRACTICE009_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-T01.



  " 1. #### (Select-Options)

  SELECT-OPTIONS : S_PERNR FOR ZEDT10_102-ZPERNR.



  " 2. #### (Select-Options as Parameter)

  " #### ##: '##### ### ##### ##' -> OBLIGATORY ## [4]

  SELECT-OPTIONS : S_DATBI FOR ZEDT10_102-DATAB NO INTERVALS NO-EXTENSION OBLIGATORY.



  " 3. #### (Select-Options)

  SELECT-OPTIONS : S_DEP FOR ZEDT10_102-ZDEPCODE NO INTERVALS NO-EXTENSION.



SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-T02.



  " 4. ### ## ## (Checkbox)

  PARAMETERS : P_ZFLAG AS CHECKBOX.



SELECTION-SCREEN END OF BLOCK B2.