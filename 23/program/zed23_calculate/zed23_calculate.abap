
FUNCTION ZED23_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 1

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 1

*"     REFERENCE(I_OPTION) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------


*
Global data declarations



*
Global data declarations


IF I_NUM2 = 0.

  RAISE DIV_ZERO.

  EXIT.

ENDIF.



CASE I_OPTION.

  WHEN '+'.

    E_RESULT = I_NUM1 + I_NUM2.

  WHEN '-'.

    E_RESULT = I_NUM1 - I_NUM2.

  WHEN '*'.

    E_RESULT = I_NUM1 * I_NUM2.

  WHEN '/'.

    E_RESULT = I_NUM1 / I_NUM2.

  WHEN OTHERS.

    E_MESSAGE = '### ### ######.'.

    EXIT.

ENDCASE.





ENDFUNCTION.