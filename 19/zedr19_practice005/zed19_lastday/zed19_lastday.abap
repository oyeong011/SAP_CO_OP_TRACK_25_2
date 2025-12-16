
FUNCTION ZED19_LASTDAY.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_GJAHR) TYPE  BKPF-GJAHR

*"     REFERENCE(I_MONAT) TYPE  BKPF-MONAT

*"  EXPORTING

*"     REFERENCE(E_LASTDAY) TYPE  DATS

*"     REFERENCE(E_MESSAGE) TYPE  CHAR50

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


DATA : LV_FIRST TYPE DATS.



RANGES : R_GJAHR FOR BKPF-GJAHR,

         R_MONAT FOR BKPF-MONAT.



CLEAR R_GJAHR.



R_GJAHR-SIGN = 'I'.

R_MONAT-OPTION = 'EQ'.

R_MONAT-LOW = I_MONAT.

APPEND R_MONAT.



LV_FIRST = |{ I_GJAHR ALPHA = IN }{ I_MONAT ALPHA = IN }01|.



CALL FUNCTION 'LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN = LV_FIRST

  IMPORTING

    LAST_DAY_OF_MONTH = E_lASTDAY.



E_MESSAGE = |{ I_GJAHR }# { I_MONAT }## ##### { E_LASTDAY+0(4) }.{ E_LASTDAY+4(2) }.{ E_LASTDAY+6(2) }###|.







ENDFUNCTION.