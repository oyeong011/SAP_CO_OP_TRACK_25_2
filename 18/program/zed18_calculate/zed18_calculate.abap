
FUNCTION ZED18_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  C

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT18_001 STRUCTURE  ZEDT018_001

*"  CHANGING

*"     REFERENCE(P_ZEDT18_001) TYPE  ZEDT018_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------


*
Global data declarations



*
Global data declarations


tables : zedt018_001.



if t_zedt18_001[] is not INITIAL.

  loop at t_zedt18_001.

    select SINGLE * from zedt018_001

      where zcode = t_zedt18_001-zcode and zpernr = t_zedt18_001-zpernr.



    modify t_zedt18_001 from zedt018_001.



  if sy-subrc ne 0.

    e_message = '### ##'.

    exit.

  ENDIF.

  ENDLOOP.

ELSE.

  e_message = '#### ######.'.

endif.



ENDFUNCTION.