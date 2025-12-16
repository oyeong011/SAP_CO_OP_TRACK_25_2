
FUNCTION ZED12_CALCULATE.




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

*"      T_ZEDT12_001 STRUCTURE  ZEDT12_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT12_001) TYPE  ZEDT12_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------



*IF I_NUM2 = 0.

*  RAISE DIV_ZERO.

*  EXIT.

*ENDIF.

*

*CASE I_OPTION.

*  WHEN '+'.

*    E_RESULT = I_NUM1 + I_NUM2.

*  WHEN '-'.

*    E_RESULT = I_NUM1 - I_NUM2.

*  WHEN '*'.

*    E_RESULT = I_NUM1 * I_NUM2.

*  WHEN '/'.

*    E_RESULT = I_NUM1 / I_NUM2.

*  WHEN OTHERS.

*    E_MESSAGE = '### ### ######.'.

*    EXIT.

*ENDCASE.



*DATA: L_ZMNAME LIKE ZEDT12_002-ZMNAME.

*

*IF P_ZEDT12_001 IS NOT INITIAL.

*  SELECT SINGLE ZMNAME FROM ZEDT12_002 INTO L_ZMNAME

*    WHERE ZCODE = P_ZEDT12_001-ZCODE

*    AND ZPERNR = P_ZEDT12_001-ZPERNR.

*

*  IF SY-SUBRC = 0.

*    E_RESULT = L_ZMNAME.

*    E_MESSAGE = '##'.

*  ELSE.

*    E_MESSAGE = '##'.

*  ENDIF.

*ELSE.

*  E_MESSAGE = '### #### ####'.

*ENDIF.




*
Global data declarations



*
Global data declarations


TABLES: ZEDT12_001.

DATA: L_ZMNAME LIKE ZEDT12_002-ZMNAME.



IF T_ZEDT12_001[] IS NOT INITIAL.

  LOOP AT T_ZEDT12_001.

  SELECT SINGLE ZKNAME FROM ZEDT12_001 INTO T_ZEDT12_001-ZKNAME

    WHERE ZCODE = P_ZEDT12_001-ZCODE

    AND ZPERNR = P_ZEDT12_001-ZPERNR.



  MODIFY T_ZEDT12_001.



  IF SY-SUBRC = 0.

    E_RESULT = L_ZMNAME.

    E_MESSAGE = '##'.

  ELSE.

    E_MESSAGE = '##'.

  ENDIF.

  ENDLOOP.

ELSE.

  E_MESSAGE = '### #### ####'.

ENDIF.

ENDFUNCTION.