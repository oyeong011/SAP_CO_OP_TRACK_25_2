
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE005.



RANGES gr_date FOR zedt07_100-zjdate.



PARAMETERS : p_year LIKE bkpf-gjahr DEFAULT sy-datum+0(4). "##

PARAMETERS : p_mon LIKE bkpf-monat DEFAULT sy-datum+4(2). "#



gr_date-sign = 'I'.

gr_date-option = 'BT'.

CONCATENATE p_year p_mon '01' INTO gr_date-low.

APPEND gr_date.



CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS' "## ##

  EXPORTING

    day_in = gr_date-low "##

  IMPORTING

    last_day_of_month = gr_date-high "## ## ### ##

  EXCEPTIONS

    day_in_no_date = 1

    OTHERS = 2.



APPEND gr_date.



IF gr_date-high IS NOT INITIAL.

  WRITE :/ p_year, '#', p_mon, '## #####', gr_date-high, '###.'.

ELSE.

  WRITE :/ '#### ## #####.'.

ENDIF.