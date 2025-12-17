
*&---------------------------------------------------------------------*

*& Report ZEDR21_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR21_PRACTICE005.






*& ##: #### ### ## #### ## ## ### ### ##

*& ## Function Module: RP_LAST_DAY_OF_MONTHS

*&---------------------------------------------------------------------*






"----------------------------------------------------------------------

" 1. ## ##

"----------------------------------------------------------------------

" RANGE ##: ## ##(ZJDATE ## ##)

RANGES : GR_DATE_RANGE FOR ZEDT00_100-ZJDATE.



" ### ## #### ####

" (#### ### ## SY-DATUM ##)

PARAMETERS: P_YEAR  LIKE BKPF-GJAHR DEFAULT SY-DATUM+0(4),  " ##

            P_MONTH LIKE BKPF-MONAT DEFAULT SY-DATUM+4(2).  " #



"----------------------------------------------------------------------

" 2. RANGE ### # ### ##

"----------------------------------------------------------------------

CLEAR GR_DATE_RANGE.

GR_DATE_RANGE-SIGN   = 'I'.     " Include ##

GR_DATE_RANGE-OPTION = 'BT'.    " Between ##



" ## ### ## # YYYYMM01 ### ##

CONCATENATE P_YEAR P_MONTH '01' INTO GR_DATE_RANGE-LOW.



"----------------------------------------------------------------------

" 3. ## ### ## ## (Function Module ##)

"----------------------------------------------------------------------

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN            = GR_DATE_RANGE-LOW          " ### (###)

  IMPORTING

    LAST_DAY_OF_MONTH = GR_DATE_RANGE-HIGH         " ## ## ### ##

  EXCEPTIONS

    DAY_IN_NO_DATE    = 1

    OTHERS            = 2.



APPEND GR_DATE_RANGE.



"----------------------------------------------------------------------

" 4. ## ##

"----------------------------------------------------------------------

IF GR_DATE_RANGE-HIGH IS NOT INITIAL.

  WRITE: / P_YEAR, '#', P_MONTH, '## #####',

           GR_DATE_RANGE-HIGH, '###.'.

ELSE.

  WRITE: / '#### ####.'.

ENDIF.