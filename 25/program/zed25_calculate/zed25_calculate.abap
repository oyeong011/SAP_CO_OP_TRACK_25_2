
FUNCTION ZED25_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

*"     REFERENCE(E_MASSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT25_001 STRUCTURE  ZEDT25_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT25_001) TYPE  ZEDT25_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------



*  IF I_NUM2 = 0.

*    RAISE DIV_ZERO.

*    EXIT.

*  ENDIF.

*

*  CASE I_OPTION.

*    WHEN '+'.

*      E_RESULT = I_NUM1 + I_NUM2.

*    WHEN '-'.

*      E_RESULT = I_NUM1 - I_NUM2.

*    WHEN '*'.

*      E_RESULT = I_NUM1 * I_NUM2.

*    WHEN '/'.

*      E_RESULT = I_NUM1 / I_NUM2.

*    WHEN OTHERS.

*      E_MESSAGE = '### ### ######.'.

*      EXIT.

*  ENDCASE.



*  DATA : l_zmname LIKE zedt25_002-zmname.

*

*  IF p_zedt25_001 IS NOT INITIAL.

*    SELECT SINGLE zmname FROM zedt25_002 INTO l_zmname

*      WHERE zcode = p_zedt25_001-zcode

*      AND zpernr = p_zedt25_001-zpernr.

*

*    IF sy-subrc = 0.

*      E_RESULT = l_zmname.

*     E_MESSAGE = '##'.

*    ELSE.

*      E_MESSAGE = '##'.

*    ENDIF.

*  ELSE.

*    E_MESSAGE = '### #### ####'.

*  ENDIF.




*
Global data declarations



*
Global data declarations


TABLES : ZEDT25_001.



IF T_ZEDT25_001[] IS NOT INITIAL.

  LOOP AT T_ZEDT25_001.

    SELECT SINGLE * FROM ZEDT25_001

      WHERE ZCODE = T_ZEDT25_001-ZCODE

      AND ZPERNR = T_ZEDT25_001-ZPERNR.



    MODIFY T_ZEDT25_001 FROM ZEDT25_001.



    IF SY-SUBRC NE 0.

      E_MASSAGE = '### ##'.

      EXIT.

    ENDIF.



  ENDLOOP.

ELSE.

  E_MASSAGE = '#### ### ### '.

ENDIF.





ENDFUNCTION.