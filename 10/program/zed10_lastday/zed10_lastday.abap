
FUNCTION ZED10_LASTDAY.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_YEAR) TYPE  GJAHR

*"     REFERENCE(I_MONTH) TYPE  MONAT

*"----------------------------------------------------------------------






*
Global data declarations



*
Global data declarations


DATA: LV_LAST_DATE TYPE DATUM,

      LV_NEXT_MONTH_DAY TYPE DATUM.

" ### ## ##

DATA: LV_NEXT_MONTH_YEAR TYPE GJAHR,

      LV_NEXT_MONTH TYPE MONAT.



IF I_MONTH = 12.

  LV_NEXT_MONTH = 1.

  LV_NEXT_MONTH_YEAR = I_YEAR + 1.

ELSE.

  LV_NEXT_MONTH = I_MONTH + 1.

  LV_NEXT_MONTH_YEAR = I_YEAR.

ENDIF.



LV_NEXT_MONTH_DAY = LV_NEXT_MONTH_YEAR && LV_NEXT_MONTH && '01'.

LV_LAST_DATE = LV_NEXT_MONTH_DAY - 1.



WRITE: I_YEAR.

WRITE: '#'.

WRITE: I_MONTH.

WRITE: '## ##### '.

WRITE: LV_LAST_DATE.

WRITE: '###.'.






*E_LAST_DATE = LV_LAST_DATE.






ENDFUNCTION.