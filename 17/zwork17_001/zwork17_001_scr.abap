
*&---------------------------------------------------------------------*

*&  Include           ZWORK17_001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

PARAMETERS: p_pdate TYPE sy-datum,                    " ####(=####)

            p_kurst TYPE tcurr-kurst DEFAULT 'M',                " ####(###)

            p_file  TYPE rlgrap-filename LOWER CASE OBLIGATORY.  " ## ##(F4 ##)

SELECTION-SCREEN END OF BLOCK b1.



" ### #### ##

SELECTION-SCREEN PUSHBUTTON  /1(20) btn1 USER-COMMAND tmpl.      " ### ####



INITIALIZATION.

  p_kurst = c_kurst.                                             " ## #### ##

  p_file  = 'C:\Users\USER\Desktop\ZWORK17_001_TEMPLATE.xlsx'.   " ## ## ## ##

  btn1 = '### ####'.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-name = 'P_KURST'.

      screen-input = 0.   " #### ####

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



" #### F4 ###

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  PERFORM f4_file.



" ### ## ##

AT SELECTION-SCREEN.

  IF sy-ucomm = 'TMPL'.

    PERFORM download_template.  " ### ## ####

    CLEAR sy-ucomm.

  ENDIF.