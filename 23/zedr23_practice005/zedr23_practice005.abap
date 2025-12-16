
*&---------------------------------------------------------------------*

*& Report ZEDR23_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_PRACTICE005.



DATA : GV_DATE TYPE D,

      GV_LASTDAY TYPE SY-DATUM.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITh FRAME.

  PARAMETERS : P_YEAR TYPE BKPF-GJAHR.

  PARAMETERS : P_MONTH TYPE BKPF-MONAT.

SELECTION-SCREEN END OF BLOCK B1.



RANGES GR_MONTH FOR BKPF-MONAT.

  GR_MONTH-SIGN = 'I'.

  GR_MONTH-OPTION = 'BT'.

  GR_MONTH-LOW = 1.

  GR_MONTH-HIGH = 12.

  APPEND GR_MONTH.



INITIALIZATION.

  P_YEAR = SY-DATUM(4).

  P_MONTH = SY-DATUM+4(2).



START-OF-SELECTION.



IF P_MONTH NOT IN GR_MONTH.

  WRITE : / '### ## ######.'.

  EXIT.

ENDIF.



CONCATENATE P_YEAR P_MONTH '01' INTO GV_DATE.



CALL FUNCTION 'LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = GV_DATE

  IMPORTING

    LAST_DAY_OF_MONTH       = GV_LASTDAY.




* EXCEPTIONS

*   DAY_IN_NO_DATE          = 1

*   OTHERS                  = 2




          .

"IF SY-SUBRC <> 0.




* Implement suitable error handling here




"ENDIF.



WRITE : / P_YEAR, '#', P_MONTH, '## ### ##', GV_LASTDAY, '###.'.