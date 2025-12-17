
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE005.



RANGES GR_ZDATE FOR ZEDT13_001-CRDATE.



PARAMETERS: P_ZYEAR LIKE BKPF-GJAHR DEFAULT SY-DATUM+0(4).

PARAMETERS: P_MONTH LIKE BKPF-MONAT DEFAULT SY-DATUM+4(2).



CLEAR GR_ZDATE.

GR_ZDATE-SIGN = 'I'.

GR_ZDATE-OPTION = 'BT'.



GR_ZDATE-LOW = P_ZYEAR && P_MONTH && '01'. "## ### ## ###"



CALL FUNCTION 'ZED13_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN        =  GR_ZDATE-LOW          "## ### ## ###"

  IMPORTING

    DAY_OUT       =  GR_ZDATE-HIGH.        "## ### ## ##"

APPEND GR_ZDATE.



IF GR_ZDATE-HIGH IS NOT INITIAL.

  WRITE :/ P_ZYEAR,'#', P_MONTH, '## #####',  GR_ZDATE-HIGH, '###'.

ELSE.

  WRITE :/'#### ####'.

ENDIF.