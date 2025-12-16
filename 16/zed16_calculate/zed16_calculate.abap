
FUNCTION zed16_calculate.




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

*"      T_ZEDT16_001 STRUCTURE  ZEDT16_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT16_001) TYPE  ZEDT16_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


  IF i_num2 = 0.

    RAISE div_zero.

    EXIT.

  ENDIF.



  CASE i_option.

    WHEN '+'.

      e_result = i_num1 + i_num2.

      e_message = '##'.

    WHEN '-'.

      e_result = i_num1 - i_num2.

      e_message = '##'.

    WHEN '*'.

      e_result = i_num1 * i_num2.

      e_message = '##'.

    WHEN '/'.

      e_result = i_num1 / i_num2.

      e_message = '##'.

    WHEN OTHERS.

      e_message = '### ### ######'.

      EXIT.

  ENDCASE.




*



*  DATA : l_zmname LIKE zedt16_002-zmname.

*

*  IF p_zedt16_001 IS NOT INITIAL.

*    SELECT SINGLE zmname FROM zedt16_002 INTO l_zmname

*      WHERE zcode = p_zedt16_001-zcode

*      AND zpernr = p_zedt16_001-zpernr.

*

*    IF sy-subrc = 0.

*      e_result = l_zmname.

*      e_message = '##'.

*    ELSE.

*      e_message = '##'.

*    ENDIF.

*  ELSE.

*    e_message = '### #### ####'.

*  ENDIF.





*  TABLES : zedt16_001.

*

*  IF t_zedt16_001[] IS NOT INITIAL.

*    LOOP AT t_zedt16_001.

*      SELECT SINGLE * FROM zedt16_001

*       WHERE zcode = t_zedt16_001-zcode

*       AND zpernr = t_zedt16_001-zpernr.

*

*      MODIFY t_zedt16_001 FROM zedt16_001.

*

*      IF sy-subrc NE 0.

*        e_message = '### ##'.

*        EXIT.

*      ENDIF.

*    ENDLOOP.

*

*  ELSE.

*    e_message = '#### ### ### '.

*  ENDIF.








ENDFUNCTION.