
FUNCTION ZED01_LAST_DAY_OF_MONTHS.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_YEAR) TYPE  I DEFAULT 2025

*"     REFERENCE(I_MONTH) TYPE  I DEFAULT 10

*"  EXPORTING

*"     REFERENCE(E_RESULT_DAY)

*"  EXCEPTIONS

*"      NOT_VALID_DATA

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


  IF I_MONTH < 1 OR I_MONTH > 12.

    RAISE NOT_VALID_DATA.

    EXIT.

  ENDIF.



  CASE I_MONTH.

    WHEN 1 OR 3 OR 5 OR 7 OR 8 OR 10 OR 12.

      E_RESULT_DAY  = '31'.

    WHEN 4 OR 6 OR 9 OR 11.

      E_RESULT_DAY = '30'.

    WHEN 2.

      IF ( I_YEAR MOD 4 = 0 AND I_YEAR MOD 100 <> 0 ) OR ( I_YEAR MOD 400 = 0 ).

        E_RESULT_DAY = '29'. " ##

      ELSE.

        E_RESULT_DAY = '28'.

      ENDIF.

  ENDCASE.



ENDFUNCTION.