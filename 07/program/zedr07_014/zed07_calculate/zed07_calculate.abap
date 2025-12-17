
FUNCTION ZED07_CALCULATE.




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

*"      T_ZEDT07_001 STRUCTURE  ZEDT07_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT07_001) TYPE  ZEDT07_001 OPTIONAL

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

    E_MESSAGE = '### ### ######'.

    EXIT.

ENDCASE.






*DATA : L_ZMNAME LIKE ZEDT07_002-ZMNAME.

*

*IF P_ZEDT07_001 IS NOT INITIAL.

*  SELECT SINGLE ZMNAME FROM ZEDT07_002 INTO L_ZMNAME

*  WHERE ZCODE = P_ZEDT07_001-ZCODE

*  AND ZPERNR = P_ZEDT07_001-ZPERNR.

*

*  IF SY-SUBRC = 0.

*    E_RESULT = L_ZMNAME.

*    E_MESSAGE = '##'.

*  ELSE.

*    E_MESSAGE = '##'.

*  ENDIF.

*ELSE.

*  E_MESSAGE = '### #### ####.'.

*ENDIF.





*TABLES : ZEDT07_001.

*

*IF T_ZEDT07_001[] IS NOT INITIAL.

*  LOOP AT T_ZEDT07_001.

*    SELECT SINGLE * FROM ZEDT07_001 "INTO T_ZEDT07_001-ZKNAME

*    WHERE ZCODE = T_ZEDT07_001-ZCODE

*    AND ZPERNR = T_ZEDT07_001-ZPERNR.

*

*    MODIFY T_ZEDT07_001 FROM ZEDT07_001.

*

*    IF SY-SUBRC NE 0. "= 0.

*      "E_MESSAGE = '##'.

*      E_MESSAGE = '### ##'.

*    "ELSE.

*      "E_MESSAGE = '##'.

*      EXIT.

*    ENDIF.

*  ENDLOOP.

*ELSE.

*  "E_MESSAGE = '### #### ####.'.

*  E_MESSAGE = '#### ######.'.

*ENDIF.








ENDFUNCTION.