
FUNCTION Z_CALC_ZFBDT.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_ZTERM) TYPE  DZTERM

*"     REFERENCE(I_BLDAT) TYPE  DATUM DEFAULT SY-DATUM

*"  EXPORTING

*"     REFERENCE(E_CALC_DATE) TYPE  DATUM

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


  DATA: LV_DATE      TYPE DATUM,

        LV_MONTHS    TYPE I,

        LV_DAYS      TYPE I,

        LV_LAST_DATE TYPE DATUM.



  " ### ## (### ### ## ##)

  IF I_BLDAT IS INITIAL.

    LV_DATE = SY-DATUM.

  ELSE.

    LV_DATE = I_BLDAT.

  ENDIF.



  " #### ### ## ## ##

  CASE I_ZTERM.



      " ==========================================================

      " Type M: # ## ## (##, ##, ### ## ##)

      " ==========================================================

    WHEN 'M001' OR 'M002'. " ## (Current Month)

      LV_MONTHS = 0.



    WHEN 'M003' OR 'M004'. " ## (Next Month)

      LV_MONTHS = 1.



    WHEN 'M005' OR 'M006'. " ### (Month after next)

      LV_MONTHS = 2.



      " ==========================================================

      " Type P: ## ## ## (### + N#)

      " ==========================================================

    WHEN 'P010'.

      LV_DAYS = 10.

    WHEN 'P015'.

      LV_DAYS = 15.

    WHEN 'P020'.

      LV_DAYS = 20.

    WHEN 'P030'.

      LV_DAYS = 30.

    WHEN 'P060'.

      LV_DAYS = 60.

    WHEN 'P090'.

      LV_DAYS = 90.



    WHEN OTHERS.

      " #### ## ### ### ### ## (## ## ##)

      E_CALC_DATE = LV_DATE.

      RETURN.

  ENDCASE.



  " ----------------------------------------------------------

  " ## ## ##

  " ----------------------------------------------------------



  " 1. M ###: ## ## ##

  IF I_ZTERM(1) = 'M'.

    " #### ## # ### (SAP ## ## ##)

    CALL FUNCTION 'RP_CALC_DATE_IN_INTERVAL'

      EXPORTING

        DATE      = LV_DATE

        DAYS      = 0

        MONTHS    = LV_MONTHS

        YEARS     = 0

        SIGNUM    = '+'

      IMPORTING

        CALC_DATE = LV_DATE.



    " ## ## ### ## ### (#: 2# 28#/29#, 30#/31# ## ##)

    CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

      EXPORTING

        DAY_IN            = LV_DATE

      IMPORTING

        LAST_DAY_OF_MONTH = E_CALC_DATE

      EXCEPTIONS

        DAY_IN_NO_DATE    = 1

        OTHERS            = 2.



    " 2. P ###: ## ### ##

  ELSEIF I_ZTERM(1) = 'P'.

    E_CALC_DATE = LV_DATE + LV_DAYS.

  ENDIF.



ENDFUNCTION.