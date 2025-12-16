
FUNCTION zfm_zpernr_pad.




*"  IMPORTING

*"     VALUE(i_zpernr) TYPE zedt11_001-zpernr

*"  EXPORTING

*"     VALUE(e_zpernr) TYPE zedt11_001-zpernr


*
Global data declarations



*
Global data declarations


  DATA lv TYPE zedt11_001-zpernr.

  lv = i_zpernr.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING  input  = lv

    IMPORTING  output = lv.

  e_zpernr = lv.

ENDFUNCTION.