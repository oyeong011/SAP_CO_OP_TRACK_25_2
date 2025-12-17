
*&---------------------------------------------------------------------*

*& Report ZEDR15_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_PRACTICE005.



""#### ##

PARAMETERS : P_YEAR TYPE BKPF-GJAHR.

PARAMETERS : P_MONTH TYPE BKPF-MONAT.



"## ## / ### ### ## RANGE TABLE




*RANGE TABLE# #### ##### ###### #### ### # ##!!




RANGES : GR_DAY FOR SY-DATUM.



GR_DAY-SIGN = 'I'.

GR_DAY-OPTION = 'BT'.

CONCATENATE P_YEAR P_MONTH '01' INTO GR_DAY-LOW.

APPEND GR_DAY.





"'RP_LAST_DAY_OF_MONTHS' - ## # ### ## #### ##

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN = GR_DAY-LOW

  IMPORTING

    LAST_DAY_OF_MONTH = GR_DAY-HIGH.

APPEND GR_DAY.



"##

WRITE : / P_YEAR, '# ', P_MONTH, '## ##### ', GR_DAY-HIGH, '###'.








*"etc)RANGE ## ##..

*"#### ###

*PARAMETERS : P_YEAR TYPE BKPF-GJAHR.

*PARAMETERS : P_MONTH TYPE BKPF-MONAT.

*

*"## ## / ### ### ## ##

*DATA : GV_DAY TYPE SY-DATUM.

*DATA : GV_LDAY TYPE SY-DATUM.

*

*"##### ### ## ## ## ## ##

*CONCATENATE P_YEAR P_MONTH '01' INTO GV_DAY.

*

*"'RP_LAST_DAY_OF_MONTHS' - ## # ### ## #### ##

*CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

*  EXPORTING

*    DAY_IN = GV_DAY

*  IMPORTING

*    LAST_DAY_OF_MONTH = GV_LDAY.

*

*"##

*WRITE : / P_YEAR, '# ', P_MONTH, '## ##### ', GV_LDAY, '###'.