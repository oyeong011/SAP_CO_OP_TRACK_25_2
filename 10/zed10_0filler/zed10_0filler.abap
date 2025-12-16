
FUNCTION ZED10_0FILLER.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_ZPERNR) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_ZPERNR) TYPE  C

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


E_ZPERNR = |{ I_ZPERNR ALPHA = IN  WIDTH = 10 }|.



ENDFUNCTION.