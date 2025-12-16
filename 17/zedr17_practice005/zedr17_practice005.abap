
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_PRACTICE005.



" #/# #### (bkpf ## ##)

parameters : p_year type bkpf-gjahr default sy-datum(4). " yyyy

parameters : p_month type bkpf-monat default sy-datum+4(2). " dd



" ## ### ##

data : gv_input_date type sy-datum.

data : gv_output_date type sy-datum.



" bkpf ## #### range table ##

ranges : gr_year for bkpf-gjahr.

ranges : gr_month for bkpf-monat.



clear gr_year.

gr_year-sign = 'I'.

gr_year-option = 'EQ'.

gr_year-low = p_year.

append gr_year.



clear gr_month.

gr_month-sign = 'I'.

gr_month-option = 'EQ'.

gr_month-low = p_month.

append gr_month.



concatenate p_year p_month '01' into gv_input_date.



" ## ## ### # ##

call function 'RP_LAST_DAY_OF_MONTHS'

  exporting

    day_in = gv_input_date

  importing

    last_day_of_month = gv_output_date.



write : gr_year-low, '#', gr_month-low, '## ##### ', gv_output_date, '###'.