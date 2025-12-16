
FUNCTION ZED03_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C OPTIONAL

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

*"     REFERENCE(E_MASSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT03_001 STRUCTURE  ZEDT03_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT03_001) TYPE  ZEDT03_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------


*
Global data declarations



*
Global data declarations


DATA : L_ZMNAME LIKE ZEDT03_002-ZMNAME.




*

*IF P_ZEDT03_001 IS NOT INITIAL.

*  SELECT SINGLE ZMNAME FROM ZEDT03_002 INTO L_ZMNAME

*    WHERE ZCODE = P_ZEDT03_001-ZCODE

*    AND ZPERNR = P_ZEDT03_001-ZPERNR.

*

*    IF SY-SUBRC = 0.

*      E_RESULT = L_ZMNAME.

*      E_MASSAGE = '##'.

*    ELSE.

*      E_MASSAGE = '##'.

*    ENDIF.

*ELSE.

*  E_MASSAGE = '### #### ####.'.

*ENDIF.

*




IF I_NUM2 = 0.

  RAISE DIV_ZERO.

  EXIT.

ENDIF.





CASE I_OPTION.

  WHEN '+'.

    E_RESULT = I_NUM1 + I_NUM2.

  WHEN '-'.

    E_RESULT = I_NUM1 - I_NUM2.

  WHEN '/'.

    E_RESULT = I_NUM1 / I_NUM2.

  WHEN '*'.

    E_RESULT = I_NUM1 * I_NUM2.

  WHEN OTHERS.

    E_MASSAGE = '### ### ######'.

    EXIT.

ENDCASE.








*TABLES : ZEDT03_001.

*

*IF T_ZEDT03_001[] IS NOT INITIAL.

*  LOOP AT T_ZEDT03_001.

*    SELECT SINGLE * FROM ZEDT03_001

*      WHERE ZCODE = T_ZEDT03_001-ZCODE

*      AND ZPERNR = T_ZEDT03_001-ZPERNR.

*

*    MODIFY T_ZEDT03_001 FROM ZEDT03_001.

*

*    IF SY-SUBRC NE 0.

*      E_MASSAGE = '### ##'.

*      EXIT.

*    ENDIF.

*

*  ENDLOOP.

*ELSE.

*  E_MASSAGE = '#### ### ### '.

*ENDIF.








ENDFUNCTION.