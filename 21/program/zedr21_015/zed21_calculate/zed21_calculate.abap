
FUNCTION zed21_calculate.




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

*"      T_ZEDT21_001 STRUCTURE  ZEDT21_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT21_001) TYPE  ZEDT21_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


  " ------------------------------

  " 1. ## #### ##

  " ------------------------------

  IF i_num2 = 0 AND i_option = '/'.

    RAISE div_zero.

  ENDIF.



  CASE i_option.

    WHEN '+'.

      e_result = i_num1 + i_num2.

    WHEN '-'.

      e_result = i_num1 - i_num2.

    WHEN '*'.

      e_result = i_num1 * i_num2.

    WHEN '/'.

      e_result = i_num1 / i_num2.

    WHEN OTHERS.

      e_message = '### ### #####'.

      RETURN.

  ENDCASE.







DATA : L_ZMNAME LIKE ZEDT21_002-ZMNAME21.



IF P_ZEDT21_001 IS NOT INITIAL.

  SELECT SINGLE ZMNAME21 FROM ZEDT21_002 INTO L_ZMNAME

    WHERE ZCODE21 = P_ZEDT21_001-ZCODE21

    AND ZPERNR21 = P_ZEDT21_001-ZPERNR21.



    IF SY-SUBRC = 0.

      E_RESULT = L_ZMNAME.

      E_MESSAGE = '##'.

      ELSE.

        E_MESSAGE = '##'.

       ENDIF.

       ELSE.

         E_MESSAGE = '### #### ####.'.

       ENDIF.





ENDFUNCTION.