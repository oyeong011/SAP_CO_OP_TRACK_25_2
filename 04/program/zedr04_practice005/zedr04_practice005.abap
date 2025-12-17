
*&---------------------------------------------------------------------*

*& Report ZEDR04_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_PRACTICE005.



PARAMETERS : P_YEAR TYPE GJAHR DEFAULT SY-DATUM(4).

PARAMETERS : P_MONTH TYPE MONAT DEFAULT SY-DATUM+4(2).



RANGES GR_DATE FOR ZEDT04_100-ZJDATE.



GR_DATE-SIGN = 'I'.

GR_DATE-OPTION = 'BT'.

CONCATENATE P_YEAR P_MONTH '01' INTO GR_DATE-LOW.



CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = GR_DATE-LOW

  IMPORTING

    LAST_DAY_OF_MONTH       = GR_DATE-HIGH.



APPEND GR_DATE.



WRITE : / P_YEAR, '# ', P_MONTH, '## ##### ', GR_DATE-HIGH, '###.'.