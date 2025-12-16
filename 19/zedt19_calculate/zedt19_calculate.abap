
FUNCTION ZEDT19_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  C

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT19_0001 STRUCTURE  ZEDT19_0001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT19_0001) TYPE  ZEDT19_0001 OPTIONAL

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

  WHEN OTHERS.

    E_MESSAGE = '### ### ######'.

    EXIT.

ENDCASE.



TABLES : ZEDT19_0001.





IF P_ZEDT19_0001 IS NOT INITIAL.

  LOOP AT T_ZEDT19_0001.

    SELECT SINGLE * FROM ZEDT19_0001

      WHERE ZCODE = T_ZEDT19_0001-ZCODE

      AND   ZPERNR = T_ZEDT19_0001-ZPERNR.



    MODIFY T_ZEDT19_0001 FROM ZEDT19_0001.



  IF SY-SUBRC NE 0.

    E_MESSAGE = '### ##'.

    EXIT.

  ENDIF.

ENDLOOP.

ELSE.

  E_MESSAGE = '#### ### ###.'.



ENDIF.



ENDFUNCTION.