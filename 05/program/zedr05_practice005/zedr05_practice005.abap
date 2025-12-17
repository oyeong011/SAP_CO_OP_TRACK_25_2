
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_PRACTICE005.

DATA: BEGIN OF GS_YEAR_MONTH,

        YEAR  TYPE GJAHR,

        MONTH TYPE MONAT,

      END OF GS_YEAR_MONTH.

RANGES GR_ZDATE FOR ZEDT05_100-ZJDATE.



DATA: GR_ZDATE_LOW  TYPE SY-DATUM,

      GR_ZDATE_HIGH TYPE SY-DATUM.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS:

  S_YEAR FOR GS_YEAR_MONTH-YEAR DEFAULT SY-DATUM(4) NO INTERVALS NO-EXTENSION,

  S_MONTH FOR GS_YEAR_MONTH-MONTH DEFAULT SY-DATUM+4(2) NO INTERVALS NO-EXTENSION.

SELECTION-SCREEN END OF BLOCK B1.



START-OF-SELECTION.

  DATA: LV_START_DATE TYPE SY-DATUM,

        LV_END_DATE   TYPE SY-DATUM.



  CONCATENATE S_YEAR-LOW S_MONTH-LOW '01' INTO LV_START_DATE.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN              = LV_START_DATE

    IMPORTING

      LAST_DAY_OF_MONTH   = LV_END_DATE

    EXCEPTIONS

      OTHERS              = 1.



  IF SY-SUBRC = 0.

    GR_ZDATE-SIGN   = 'I'.

    GR_ZDATE-OPTION = 'BT'.

    GR_ZDATE-LOW    = LV_START_DATE.

    GR_ZDATE-HIGH   = LV_END_DATE.

    APPEND GR_ZDATE.



    WRITE: / S_YEAR-LOW, '#', S_MONTH-LOW, '## #####', GR_ZDATE-HIGH, '###'.

  ELSE.

    WRITE: / '## ### ######. ### #/## #####.'.

  ENDIF.