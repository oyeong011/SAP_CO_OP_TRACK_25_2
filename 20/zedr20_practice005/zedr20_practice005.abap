
*&---------------------------------------------------------------------*

*& Report ZEDR20_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PRACTICE005.



DATA: GV_TARGET TYPE SY-DATUM,

      GV_RESULT TYPE SY-DATUM.

RANGES: GR_DATE FOR SY-DATUM.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS: P_YEAR LIKE BKPF-GJAHR.

  PARAMETERS: P_MONTH LIKE BKPF-MONAT.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

  P_YEAR = SY-DATUM+0(4).

  P_MONTH = SY-DATUM+4(2).



START-OF-SELECTION.

  GR_DATE-SIGN = 'I'.

  GR_DATE-OPTION = 'EQ'.

  CONCATENATE P_YEAR P_MONTH '01' INTO GR_DATE-LOW.

  APPEND GR_DATE.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = GR_DATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = GV_RESULT.

END-OF-SELECTION.



IF SY-SUBRC = 0.

  WRITE:/ P_YEAR, ' # ', P_MONTH, ' ## ##### ', GV_RESULT, ' ###'.

ELSE.

  WRITE:/ '### ######.'.

ENDIF.