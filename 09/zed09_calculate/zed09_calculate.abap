
FUNCTION ZED09_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  CHANGING

*"     REFERENCE(P_ZEDT09_001) TYPE  ZEDT09_001 OPTIONAL

*"     REFERENCE(T_ZEDT09_001) TYPE  ZTT_ZEDT09_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


IF I_NUM2 = 0.

  RAISE DIV_ZERO.

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



IF SY-SUBRC = 0.

  E_MESSAGE = '##'.

ELSE.

  E_MESSAGE = '##'.

ENDIF.










*"CHANGING# ### #### ### # # #### -> p_zedt09_001 ### ##

*DATA : L_ZMNAME TYPE ZEDT09_002-ZMNAME.

*

*  IF P_ZEDT09_001 IS NOT INITIAL.

*    SELECT SINGLE ZMNAME

*    FROM ZEDT09_002 INTO L_ZMNAME

*      WHERE ZCODE = P_ZEDT09_001-ZCODE

*      AND   ZPERNR = P_ZEDT09_001-ZPERNR.

*

*    IF SY-SUBRC = 0.

*      E_RESULT = L_ZMNAME.

*      E_MESSAGE = '##'.

*    ELSE.

*     E_MESSAGE = '##'.

*    ENDIF.

*

*  ELSE.

*    E_MESSAGE = '### #### ####'.

*

*ENDIF.





*"#### #### ### ####

*"p_zedt09_001## t_zedt09_001## #####, ##### #### type standard table of zedt09_001 ## ### #### #### #

*"## ### ##### ##



*DATA : LS_ZEDT09_001 LIKE LINE OF T_ZEDT09_001.



*IF T_ZEDT09_001 IS NOT INITIAL.



*  LOOP AT T_ZEDT09_001 INTO LS_ZEDT09_001.

*    "db## zkname# ####, ## ## zkname ## ###

*    "##, zpernr 0# 9###.. 8## #### ####

*    SELECT SINGLE ZKNAME

*      FROM ZEDT09_001

*      INTO LS_ZEDT09_001-ZKNAME

*      WHERE ZCODE  = LS_ZEDT09_001-ZCODE

*      AND ZPERNR  = LS_ZEDT09_001-ZPERNR.



*    MODIFY TABLE T_ZEDT09_001 FROM LS_ZEDT09_001 TRANSPORTING ZKNAME.

*

*    IF SY-SUBRC = 0.

*      E_MESSAGE = '##'.

*    ELSE.

*      E_MESSAGE = '##'.

*      EXIT.

*    ENDIF.

*  ENDLOOP.



*ELSE.

*  E_MESSAGE = '### #### ####'.

*ENDIF.








ENDFUNCTION.