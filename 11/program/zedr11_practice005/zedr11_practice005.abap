
*&---------------------------------------------------------------------*

*& Report ZEDR11_PRACTICE005

*&---------------------------------------------------------------------*




REPORT ZEDR11_PRACTICE005.



" #### ##

PARAMETERS : p_year  TYPE bkpf-gjahr DEFAULT sy-datum(4),

             p_month TYPE bkpf-monat DEFAULT sy-datum+4(2).



" ### ##

DATA : gv_date      TYPE datum,      " ###

       gv_last_date TYPE datum.      " ###



START-OF-SELECTION.



  " ## ## 1# ## ##

  CONCATENATE p_year p_month '01' INTO gv_date.



  " ## ### ## ## ## ## (RP_LAST_DAY_OF_MONTHS)

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in            = gv_date

    IMPORTING

      last_day_of_month = gv_last_date

    EXCEPTIONS

      day_in_no_date    = 1

      OTHERS            = 2.



  " ## ##

  IF sy-subrc = 0.

    WRITE : / p_year, '#', p_month, '## ### ##', gv_last_date, '###.'.

  ELSE.

    WRITE : / '## ## ## ##'.

  ENDIF.