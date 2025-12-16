
*&---------------------------------------------------------------------*

*& Report ZEDR09_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_PRACTICE005.



"1. #### - #### ##, # ##

PARAMETERS : P_ZYEAR TYPE BKPF-GJAHR DEFAULT SY-DATUM+0(4).

PARAMETERS : P_ZMON  TYPE BKPF-MONAT DEFAULT SY-DATUM+4(2).



RANGES : GR_ZMON FOR SY-DATUM.



GR_ZMON-SIGN   = 'I'.

GR_ZMON-OPTION = 'BT'.

"# ## ### ## ###

CONCATENATE P_ZYEAR P_ZMON '01' INTO GR_ZMON-LOW.



"2. #### ## #, ##### ## ### ### # ###

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  =   GR_ZMON-LOW

  IMPORTING

    LAST_DAY_OF_MONTH       =   GR_ZMON-HIGH.



IF SY-SUBRC = 0.

  WRITE : / P_ZYEAR , '# ', P_ZMON, '## ### ## ', GR_ZMON-HIGH, '###'.

ENDIF.