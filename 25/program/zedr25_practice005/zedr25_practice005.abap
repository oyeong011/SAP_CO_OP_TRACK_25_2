
*&---------------------------------------------------------------------*

*& Report ZEDR25_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_PRACTICE005.





RANGES: gr_zdate FOR zedt25_100-zjdate.



PARAMETERS: p_gjahr LIKE bkpf-gjahr DEFAULT sy-datum+0(4),

            p_monat LIKE bkpf-monat DEFAULT sy-datum+4(2).





START-OF-SELECTION.



  PERFORM set_date_range.

  PERFORM get_last_day.

  PERFORM display_result.



FORM set_date_range.



  CLEAR gr_zdate.



  gr_zdate-sign   = 'I'.

  gr_zdate-option = 'BT'.



  CONCATENATE p_gjahr p_monat '01' INTO gr_zdate-low.

  APPEND gr_zdate.



ENDFORM.





FORM get_last_day.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in            = gr_zdate-low

    IMPORTING

      last_day_of_month = gr_zdate-high

    EXCEPTIONS

      day_in_no_date    = 1

      OTHERS            = 2.



  MODIFY gr_zdate INDEX 1.



ENDFORM.



FORM display_result.



  IF gr_zdate-high IS NOT INITIAL.

    WRITE: / p_gjahr, '#', p_monat, '## #####', gr_zdate-high+0(4), '.',

             gr_zdate-high+4(2), '.', gr_zdate-high+6(2), '###'.

  ELSE.

    WRITE: / '#### ####'.

  ENDIF.



ENDFORM.