
FUNCTION ZED05_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C OPTIONAL

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT05_001 STRUCTURE  ZEDT05_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT05_001) TYPE  ZEDT05_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


TABLES : ZEDT05_001.

DATA : L_ZMNAME LIKE ZEDT05_002-ZMNAME.






*IF T_ZEDT05_001[] IS NOT INITIAL.

*  LOOP AT T_ZEDT05_001.

*   SELECT SINGLE * FROM ZEDT05_001

*     WHERE ZCODE = T_ZEDT05_001-ZCODE

*     AND ZPERNR = T_ZEDT05_001-ZPERNR.

*

*     MODIFY T_ZEDT05_001 FROM ZEDT05_001.

*     IF SY-SUBRC NE 0.

*       E_MESSAGE = '### ##'.

*       EXIT.

*     ENDIF.

*  ENDLOOP.

*ELSE.

*  E_MESSAGE = '#### ### ###.'.

*ENDIF.

*






if I_NUM2 = 0.

  RAISE DIV_ZERO.

  EXIT.

ENDIF.



IF SY-SUBRC = 0.

  WRITE : /'##'.

ELSE.

  WRITE : /'##'.

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