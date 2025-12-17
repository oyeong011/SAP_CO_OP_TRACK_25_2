
*&---------------------------------------------------------------------*

*& REPORT ZTEST01_02

*&---------------------------------------------------------------------*




REPORT ZTEST01_02.



DATA: EXTERNAL LIKE BAPICURR-BAPICURR.

EXTERNAL = '100'.



CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'

  EXPORTING

    CURRENCY            = 'KRW'

    AMOUNT_EXTERNAL     = EXTERNAL

    MAX_NUMBER_OF_DIGITS       = 15

  IMPORTING

    AMOUNT_INTERNAL     = EXTERNAL.



WRITE : EXTERNAL.