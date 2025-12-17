
FUNCTION ZED01_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

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


CASE I_OPTION.

  WHEN '+'.

    E_RESULT = I_NUM1 + I_NUM2.

  WHEN '-'.

    E_RESULT = I_NUM1 - I_NUM2.

  WHEN '*'.

    E_RESULT = I_NUM1 * I_NUM2.

  WHEN '/'.

    IF I_NUM2 = 0.

      RAISE DIV_ZERO.

      EXIT.

    ENDIF.

    E_RESULT = I_NUM1 / I_NUM2.

  WHEN OTHERS.

    E_MESSAGE = '### ### ######'.

    EXIT.

ENDCASE.











ENDFUNCTION.