
FUNCTION ZED04_CALCULATE.




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

*"      T_ZEDT04_001 STRUCTURE  ZEDT04_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT04_001) TYPE  ZEDT04_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


" 6. EXCEPTION ##



IF I_NUM2 = 0.

  RAISE DIV_ZERO.  " ####

  EXIT.

ENDIF.



" 8. TEST DATA



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



" 10. CHANGING TEST






*DATA : L_ZMNAME LIKE ZEDT04_002-ZMNAME.

*

*IF P_ZEDT04_001 IS NOT INITIAL.

*  SELECT SINGLE ZMNAME FROM ZEDT04_002 INTO L_ZMNAME

*    WHERE ZCODE = P_ZEDT04_001-ZCODE

*    AND ZPERNR = P_ZEDT04_001-ZPERNR.

*

*  IF SY-SUBRC = 0.

*    E_RESULT = L_ZMNAME.  " E_RESULT# C#### ## ##

*    E_MESSAGE = '##'.

*  ELSE.

*    E_MESSAGE = '##'.

*  ENDIF.

*ELSE.

*  E_MESSAGE = '### #### ####.'.

*ENDIF.






" 11. TABLE SOURCE




*IF T_ZEDT04_001[] IS NOT INITIAL.

*  LOOP AT T_ZEDT04_001.

*    SELECT SINGLE ZKNAME FROM ZEDT04_001 INTO T_ZEDT04_001-ZKNAME

*      WHERE ZCODE = T_ZEDT04_001-ZCODE

*      AND ZPERNR = T_ZEDT04_001-ZPERNR. " # SELECT### T_ZEDT04_001# ##

*

*    MODIFY T_ZEDT04_001.

*

*    IF SY-SUBRC = 0.

*      E_MESSAGE = '##'.

*    ELSE.

*      E_MESSAGE = '##'.

*      EXIT.

*    ENDIF.

*  ENDLOOP.

*ELSE.

*  E_MESSAGE = '### #### ####.'.

*ENDIF.






ENDFUNCTION.