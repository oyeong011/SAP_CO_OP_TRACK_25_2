
*&---------------------------------------------------------------------*

*& Report ZEDR08_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_PRACTICE005.



" ### ### ## ##### ## (## / #)

PARAMETERS: P_GJAHR LIKE BKPF-GJAHR DEFAULT SY-DATUM+0(4).

PARAMETERS: P_MONAT LIKE BKPF-MONAT DEFAULT SY-DATUM+4(2).



" ## ### ### RANGE TABLE ##

RANGES GR_DATE FOR ZEDT08_100-ZJDATE.



" ### ## ## ## (INCLUDE)

GR_DATE-SIGN = 'I'.

" ## ## ## (BETWEEN)

GR_DATE-OPTION = 'BT'.

" ### ## 01# ### ### #### GR_DATE-LOW# ####

CONCATENATE P_GJAHR P_MONAT '01' INTO GR_DATE-LOW.

" ### ## ### GR_DATE ## #### ####

APPEND GR_DATE.



" RP_LAST_DAY_OF_MONTHS ### #### ## ## ### ### ###

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = GR_DATE-LOW

 IMPORTING

   LAST_DAY_OF_MONTH       = GR_DATE-HIGH

 EXCEPTIONS

   DAY_IN_NO_DATE          = 1

   OTHERS                  = 2

          .



" #### #### ##

IF SY-SUBRC <> 0.

  WRITE :/'#### ####'.

  EXIT.

ELSE. " #### ##

  IF GR_DATE-HIGH IS NOT INITIAL. " ## ### HIGH ## #### ###

    WRITE :/ P_GJAHR,'#', P_MONAT, '## #####',  GR_DATE-HIGH, '###'.

  ELSE.

    WRITE :/'#### ####'.

  ENDIF.

ENDIF.