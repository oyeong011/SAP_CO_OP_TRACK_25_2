
FUNCTION ZED01_CALCULATE02.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  C

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT01_001 STRUCTURE  ZEDT01_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT01_001) TYPE  ZEDT01_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


DATA : L_ZMNAME LIKE ZEDT01_002-ZMNAME.



IF P_ZEDT01_001 IS NOT INITIAL.

  SELECT SINGLE ZMNAME FROM ZEDT01_002 INTO L_ZMNAME

    WHERE ZCODE = P_ZEDT01_001-ZCODE

    AND   ZPERNR = P_ZEDT01_001-ZPERNR.



    IF SY-SUBRC = 0.

      E_RESULT = L_ZMNAME.

      E_MESSAGE = '##'.

    ELSE.

      E_MESSAGE = '##'.

    ENDIF.

ELSE.

  E_MESSAGE = '### #### ####'.

ENDIF.



ENDFUNCTION.