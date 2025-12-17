
FUNCTION ZED10_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I OPTIONAL

*"     REFERENCE(I_NUM2) TYPE  I OPTIONAL

*"     REFERENCE(I_OPTION) TYPE  C OPTIONAL

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  C

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT10_001 STRUCTURE  ZEDT10_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT10_001) TYPE  ZEDT10_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"      ZCX_ZED10_

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


  IF I_NUM2 = 0 AND I_OPTION ='/'.

    RAISE DIV_ZERO.

    EXIT.

  ENDIF.



  IF I_NUM1 IS NOT INITIAL AND I_NUM2 IS NOT INITIAL.

    CASE I_OPTION.

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

    WRITE:/ 'FUCNTION EXIT'.

    EXIT.

  ENDIF.



  DATA: L_ZMANAME LIKE ZEDT10_002-ZMNAME.



  IF P_ZEDT10_001 IS NOT INITIAL.

    SELECT SINGLE ZMNAME FROM ZEDT10_002 INTO L_ZMANAME

      WHERE ZCODE  = P_ZEDT10_001-ZCODE

      AND   ZPERNR = P_ZEDT10_001-ZPERNR.



    IF SY-SUBRC = 0.

      E_RESULT  = L_ZMANAME.

      E_MESSAGE = '##'.

    ELSE.

      E_MESSAGE = '##'.

    ENDIF.

    WRITE:/ 'FUCNTION EXIT'.

    EXIT.

  ELSE.

    E_MESSAGE = '### #### ####.'.

  ENDIF.



  IF T_ZEDT10_001[] IS NOT INITIAL.

    LOOP AT T_ZEDT10_001.

      SELECT SINGLE ZKNAME FROM ZEDT10_001

        INTO T_ZEDT10_001-ZKNAME

        WHERE ZCODE = T_ZEDT10_001-ZCODE

        AND   ZPERNR = T_ZEDT10_001-ZPERNR.



      MODIFY T_ZEDT10_001.



      IF SY-SUBRC = 0.

        E_RESULT  = 'TABLE ####!'.

        E_MESSAGE = '##'.

      ELSE.

        E_MESSAGE = '##'.

        EXIT.

      ENDIF.

    ENDLOOP.

    WRITE:/ 'FUCNTION EXIT'.

    EXIT.

  ELSE.

    E_MESSAGE = '### #### ###!'.

  ENDIF.





ENDFUNCTION.