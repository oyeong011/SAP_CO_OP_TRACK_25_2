
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE005.



"#### ##

PARAMETERS : P_YEAR TYPE BKPF-GJAHR DEFAULT SY-DATUM(4),

             P_MONTH TYPE BKPF-MONAT DEFAULT SY-DATUM+4(2).



DATA : GV_LAST_DAY TYPE D, "### ## ### ##

       GV_FIRST_DAY TYPE D, "### ## ### ##

       GV_LAST_DAY_FORMAT TYPE C LENGTH 10. "### # ### ##



"RANGE ## ##

RANGES : GR_YEAR FOR BKPF-GJAHR,

         GR_MONTH FOR BKPF-MONAT.



START-OF-SELECTION.

"#### ## ### ## RANGE### ##

GR_YEAR-SIGN = 'I'.

GR_YEAR-OPTION = 'EQ'.

GR_YEAR-LOW = P_YEAR.

APPEND GR_YEAR.



GR_MONTH-SIGN = 'I'.

GR_MONTH-OPTION = 'EQ'.

GR_MONTH-LOW = P_MONTH.

APPEND GR_MONTH.



"YYYYMM01 #### ##

CONCATENATE GR_YEAR-LOW GR_MONTH-LOW '01' INTO GV_FIRST_DAY.



"### ## ## ## ##

CALL FUNCTION 'LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = GV_FIRST_DAY

 IMPORTING

   LAST_DAY_OF_MONTH       = GV_LAST_DAY

 EXCEPTIONS

   DAY_IN_NO_DATE          = 1

   OTHERS                  = 2

          .

IF SY-SUBRC = 0.

  "### ### ##

  WRITE: GV_LAST_DAY TO GV_LAST_DAY_FORMAT USING EDIT MASK '____.__.__'.

  WRITE: / GR_YEAR-LOW, '#', GR_MONTH-LOW, '## #####', GV_LAST_DAY_FORMAT, '###'.

ENDIF.