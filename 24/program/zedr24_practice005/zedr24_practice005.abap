
*&---------------------------------------------------------------------*

*& Report ZEDR24_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_PRACTICE005.

RANGES GR_MONTH FOR BKPF-GJAHR.



GR_MONTH-SIGN = 'I'.

GR_MONTH-OPTION = 'BT'.

GR_MONTH-LOW = '1'.

GR_MONTH-HIGH = '12'.

APPEND GR_MONTH.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  PARAMETERS : S_YEAR LIKE BKPF-GJAHR.

  PARAMETERS : S_MONTH LIKE BKPF-MONAT.

SELECTION-SCREEN END OF BLOCK B1.



"2. ## ## ###

INITIALIZATION.

  S_YEAR = SY-DATUM(4).

  S_MONTH = SY-DATUM+4(2).

  DATA : FULL_DAY TYPE D,

         RESULT_DAY TYPE SY-DATUM.



  CONCATENATE S_YEAR S_MONTH '01' INTO FULL_DAY.



START-OF-SELECTION.

  IF S_MONTH IN GR_MONTH.

    CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = FULL_DAY

    IMPORTING

      LAST_DAY_OF_MONTH = RESULT_DAY.

  ELSE.

    MESSAGE '# ### #### ####' TYPE 'E'.

  ENDIF.



  WRITE :/ S_YEAR, '#', S_MONTH, '## #####', RESULT_DAY, '###'.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   # ### #### ####