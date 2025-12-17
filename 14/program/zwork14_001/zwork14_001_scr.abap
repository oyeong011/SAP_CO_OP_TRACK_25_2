
*&---------------------------------------------------------------------*

*&  Include           ZWORK14_001_SCR

*&---------------------------------------------------------------------*\






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.



  PARAMETERS : P_DATE TYPE SY-DATUM DEFAULT SY-DATUM OBLIGATORY,

               P_FILE TYPE RLGRAP-FILENAME,

               P_KURST TYPE ZTCURR14-KURST DEFAULT 'M' MODIF ID M1.



SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN FUNCTION KEY 1.  " ### ## ##



INITIALIZATION.

  SSCRFIELDS-FUNCTXT_01 = '### ####'.  " ## ###



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.  " #### ## ###

      SCREEN-INPUT = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM F4_FILENAME CHANGING P_FILE.



AT SELECTION-SCREEN.

  CASE SSCRFIELDS-UCOMM.

    WHEN 'FC01'.  " ### #### ## ##

      PERFORM DOWNLOAD_TEMPLATE.

  ENDCASE.