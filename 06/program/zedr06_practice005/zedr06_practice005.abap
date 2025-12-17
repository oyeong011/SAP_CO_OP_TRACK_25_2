
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE005.



PARAMETERS: P_YEAR LIKE BKPF-GJAHR DEFAULT SY-DATUM+0(4).   " ##

PARAMETERS: P_MONTH LIKE BKPF-MONAT DEFAULT SY-DATUM+4(2).  " #



RANGES GR_ZDATE FOR ZEDT06_100-ZJDATE.






*" ### ####

*INITIALIZATION.

*  P_YEAR = SY-DATUM+0(4).

*  P_MONTH = SY-DATUM+4(2).






CLEAR GR_ZDATE.

GR_ZDATE-SIGN = 'I'.    " INCLUDE

GR_ZDATE-OPTION = 'BT'. " BETWEEN

CONCATENATE P_YEAR P_MONTH '01' INTO GR_ZDATE-LOW. " YYMMDD #### LOW# ##

APPEND GR_ZDATE.



" RP_LAST_DAY_OF_MONTHS### ## ## ## ### ## ##

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN            = GR_ZDATE-LOW

  IMPORTING

    LAST_DAY_OF_MONTH = GR_ZDATE-HIGH

  EXCEPTIONS

    DAY_IN_NO_DATE    = 1

    OTHERS            = 2.



APPEND GR_ZDATE.



" ## ## ### ## ##

IF GR_ZDATE-HIGH IS NOT INITIAL.

  WRITE :/ P_YEAR, '#', P_MONTH, '## #####', GR_ZDATE-HIGH, '###'.

ELSE.

  WRITE :/ '#### ####'.

ENDIF.