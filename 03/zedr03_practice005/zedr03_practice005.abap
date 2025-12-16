
*&---------------------------------------------------------------------*

*& Report ZEDR03_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_PRACTICE005.





RANGES GR_ZDATE FOR ZEDT03_100-ZJDATE.



PARAMETERS : P_GJAHR LIKE BKPF-GJAHR DEFAULT SY-DATUM+0(4).

PARAMETERS : P_MONAT LIKE BKPF-MONAT DEFAULT SY-DATUM+4(2).



CLEAR GR_ZDATE.

GR_ZDATE-SIGN = 'I'.

GR_ZDATE-OPTION = 'BT'.

GR_ZDATE-LOW = |{ P_GJAHR }{ P_MONAT }01|.

APPEND GR_ZDATE.



CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = GR_ZDATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = GR_ZDATE-HIGH

   EXCEPTIONS

     DAY_IN_NO_DATE          = 1

     OTHERS                  = 2.



APPEND GR_ZDATE.





IF GR_ZDATE-HIGH IS NOT INITIAL.

  WRITE :/ P_GJAHR, '#', P_MONAT, '## #####', GR_ZDATE-HIGH, '###'.

ELSE.

  WRITE :/ '#### #### ####'.

ENDIF.