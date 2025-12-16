
*&---------------------------------------------------------------------*

*& Report ZEDR10_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_PRACTICE005.



DATA: BEGIN OF GS_YEAR_MONTH,

        YEAR  TYPE GJAHR,

        MONTH TYPE MONAT,

      END OF GS_YEAR_MONTH.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS:

  S_YEAR FOR GS_YEAR_MONTH-YEAR NO INTERVALS NO-EXTENSION,

  S_MONTH FOR GS_YEAR_MONTH-MONTH NO INTERVALS NO-EXTENSION.

SELECTION-SCREEN END OF BLOCK B1.



GS_YEAR_MONTH-YEAR = S_YEAR-LOW.

GS_YEAR_MONTH-MONTH = S_MONTH-LOW.



CALL FUNCTION 'ZED10_LASTDAY'

  EXPORTING

    I_YEAR  = GS_YEAR_MONTH-YEAR

    I_MONTH = GS_YEAR_MONTH-MONTH.