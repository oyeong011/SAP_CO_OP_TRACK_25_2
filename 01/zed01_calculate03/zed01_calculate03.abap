
FUNCTION ZED01_CALCULATE03.




*"--------------------------------------------------------------------

*"*"Local Interface:

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  C

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT01_001 STRUCTURE  ZEDT01_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT01_001) TYPE  ZEDT01_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"--------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


TABLES : ZEDT01_001.



IF T_ZEDT01_001[] IS NOT INITIAL.

  LOOP AT T_ZEDT01_001.

    SELECT SINGLE * FROM ZEDT01_001

      WHERE ZCODE = P_ZEDT01_001-ZCODE

      AND   ZPERNR = P_ZEDT01_001-ZPERNR.



    MODIFY T_ZEDT01_001 FROM ZEDT01_001.



    IF SY-SUBRC NE 0.

      E_MESSAGE = '### ##'.

      EXIT.

    ENDIF.

  ENDLOOP.

ELSE.

  E_MESSAGE = '#### ### ### '.

ENDIF.



ENDFUNCTION.