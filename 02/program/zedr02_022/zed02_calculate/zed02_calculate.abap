
FUNCTION ZED02_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

*"     REFERENCE(E_MESSAGE) TYPE  C

*"     REFERENCE(E_RESULT2) TYPE  C

*"  TABLES

*"      T_ZEDT02_001 STRUCTURE  ZEDT02_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT02_001) TYPE  ZEDT02_001 OPTIONAL

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

"E_RESULT = I_NUM1 / I_NUM2.



"CHANGING TEST




*DATA : L_ZMNAME LIKE ZEDT02_002-ZMNAME.

*

*IF P_ZEDT02_001 IS NOT INITIAL.

*  SELECT SINGLE ZMNAME FROM ZEDT02_002 INTO L_ZMNAME

*    WHERE ZCODE = P_ZEDT02_001-ZCODE

*    AND   ZPERNR = P_ZEDT02_001-ZPERNR.

*

*    IF SY-SUBRC = 0.

*      E_RESULT2 = L_ZMNAME.

*      E_MESSAGE = '##'.

*    ELSE.

*      E_MESSAGE = '##'.

*    ENDIF.

*  ELSE.

*    E_MESSAGE = '### #### ####'.

*ENDIF.






"TABLES SOURCE




*IF T_ZEDT02_001[] IS NOT INITIAL.

*  LOOP AT T_ZEDT02_001.

*    SELECT SINGLE ZKNAME FROM ZEDT02_001 INTO T_ZEDT02_001-ZKNAME

*      WHERE ZCODE = T_ZEDT02_001-ZCODE

*      AND   ZPERNR = T_ZEDT02_001-ZPERNR.

*    MODIFY T_ZEDT02_001.

*

*    IF SY-SUBRC = 0.

*      E_MESSAGE = '##'.

*    ELSE.

*      E_MESSAGE = '##'.

*    ENDIF.

*  ENDLOOP.

*ELSE.

*    E_MESSAGE = '### #### ####'.

*ENDIF.





*TABLES : ZEDT02_001.

*

*IF T_ZEDT02_001[] IS NOT INITIAL.

*  LOOP AT T_ZEDT02_001.

*    SELECT SINGLE * FROM ZEDT02_001

**     INTO T_ZEDT02_001-ZKNAME "### ZEDT02_001# WORK AREA# ### ##

*      WHERE ZCODE = T_ZEDT02_001-ZCODE

*      AND   ZPERNR = T_ZEDT02_001-ZPERNR.

*

*    MODIFY T_ZEDT02_001 FROM ZEDT02_001.

*

*    IF SY-SUBRC NE 0.

*      E_MESSAGE = '### ##'.

*      EXIT.

*    ENDIF.

*  ENDLOOP.

*ELSE.

*    E_MESSAGE = '#### ### ### '.

*ENDIF.




ENDFUNCTION.