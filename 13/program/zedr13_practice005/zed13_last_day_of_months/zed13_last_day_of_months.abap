
FUNCTION ZED13_LAST_DAY_OF_MONTHS.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(DAY_IN) TYPE  SY-DATUM

*"  EXPORTING

*"     REFERENCE(DAY_OUT) TYPE  SY-DATUM

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


DATA: LV_YEAR(4) TYPE N.

      LV_YEAR = DAY_IN+0(4). "## ## (YYYY)"





CASE DAY_IN+4(2). "### ### # ###"

    WHEN '01'.

      DAY_OUT = DAY_IN(6) && '31'.

    WHEN '02'.

      IF ( LV_YEAR MOD 4 = 0 AND LV_YEAR MOD 100 <> 0 ) OR LV_YEAR MOD 400 = 0.

        DAY_OUT = DAY_IN(6) && '29'. "##"

      ELSE.

        DAY_OUT = DAY_IN(6) && '28'. "##"

      ENDIF.

    WHEN '03'.

      DAY_OUT = DAY_IN(6) && '31'.

    WHEN '04'.

      DAY_OUT = DAY_IN(6) && '30'.

    WHEN '05'.

      DAY_OUT = DAY_IN(6) && '31'.

    WHEN '06'.

      DAY_OUT = DAY_IN(6) && '30'.

    WHEN '07'.

      DAY_OUT = DAY_IN(6) && '31'.

    WHEN '08'.

      DAY_OUT = DAY_IN(6) && '31'.

    WHEN '09'.

      DAY_OUT = DAY_IN(6) && '30'.

    WHEN '10'.

      DAY_OUT = DAY_IN(6) && '31'.

    WHEN '11'.

      DAY_OUT = DAY_IN(6) && '30'.

    WHEN '12'.

      DAY_OUT = DAY_IN(6) && '31'.

   ENDCASE.



ENDFUNCTION.