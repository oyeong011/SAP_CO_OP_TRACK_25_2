
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_practice005.



PARAMETERS: p_gjahr TYPE bkpf-gjahr DEFAULT sy-datum+0(4),

            p_monat TYPE bkpf-monat DEFAULT sy-datum+4(2).



RANGES: r_date FOR bkpf-budat.



DATA : lv_first TYPE d,

       lv_last  TYPE d,

       lv_out   TYPE c LENGTH 10.



START-OF-SELECTION.



  CONCATENATE p_gjahr p_monat '01' INTO lv_first.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in            = lv_first

    IMPORTING

      last_day_of_month = lv_last.



  CLEAR r_date.

  r_date-sign   = 'I'.

  r_date-option = 'BT'.

  r_date-low    = lv_first.

  r_date-high   = lv_last.

  APPEND r_date.



  WRITE r_date-high TO lv_out USING EDIT MASK '____.__.__'.

  WRITE: / p_gjahr, '# ', p_monat, '## ##### ', lv_out, ' ###.'.