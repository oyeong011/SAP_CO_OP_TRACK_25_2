
*&---------------------------------------------------------------------*

*& Report ZEDR018_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_PRACTICE005.



RANGES : GR_DATE FOR SY-DATUM.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

PARAMETERS: S_YEAR TYPE BKPF-GJAHR DEFAULT SY-DATUM+0(4).

PARAMETERS : S_MONTH TYPE BKPF-MONAT DEFAULT SY-DATUM+4(2).

SELECTION-SCREEN END OF BLOCK B1.



CLEAR GR_DATE.

GR_DATE-SIGN = 'I'.

GR_DATE-OPTION = 'BT'.

CONCATENATE S_YEAR S_MONTH '01' INTO GR_DATE-LOW.

APPEND GR_DATE.



CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN            = GR_DATE-LOW

  IMPORTING

    LAST_DAY_OF_MONTH = GR_DATE-HIGH.





IF SY-SUBRC eq 0.

  IF GR_DATE-HIGH IS NOT INITIAL. "### ## ###

    WRITE :/ S_YEAR, '#', S_MONTH, '## ### ##', GR_DATE-HIGH, '###.'.

  ENDIF.

ENDIF.