
FUNCTION ZED17_CALCULATE.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_NUM1) TYPE  I DEFAULT 3

*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5

*"     REFERENCE(I_OPTION) TYPE  C OPTIONAL

*"  EXPORTING

*"     REFERENCE(E_RESULT) TYPE  I

*"     REFERENCE(E_MESSAGE) TYPE  C

*"  TABLES

*"      T_ZEDT17_001 STRUCTURE  ZEDT17_001 OPTIONAL

*"  CHANGING

*"     REFERENCE(P_ZEDT17_001) TYPE  ZEDT17_001 OPTIONAL

*"  EXCEPTIONS

*"      DIV_ZERO

*"----------------------------------------------------------------------



** 6. exception


*
Global data declarations



*
Global data declarations


if i_num2 = 0.

  raise div_zero.

  exit.

endif.



if sy-subrc = 0.

  e_message = '##'.

else.

  e_message = '##'.

endif.



case i_option.

  when '+'.

    e_result = i_num1 + i_num2.

  when '-'.

    e_result = i_num1 - i_num2.

  when '*'.

    e_result = i_num1 * i_num2.

  when '/'.

    e_result = i_num1 / i_num2.

    exit.

endcase.






*** 9. changing source

*data : l_zmname like zedt17_002-zmname.

*if p_zedt17_001 is not initial.

*  select single zmname from zedt17_002 into l_zmname " changing## ### #### ### # # ####.

*    where zcode = p_zedt17_001-zcode

*    and zpernr = p_zedt17_001-zpernr.

*

*    if sy-subrc = 0.

*      e_result = l_zmname.

*      e_message = '##'.

*    else.

*      e_message = '##'.

*    endif.

*else.

*    e_message = '### #### ####'.

*endif.



*** 11. TABLES Source

*tables : zedt17_001.

*if t_zedt17_001[] is not initial.

*  loop at t_zedt17_001.

*    select single * from zedt17_001

**      into t_zedt17_001-zkname " tables# #### db#### ### ### work area# ####,

*                                " into# ### zedt17_001# work area# #### ###

*      where zcode = t_zedt17_001-zcode

*      and zpernr = t_zedt17_001-zpernr.

*

*      modify t_zedt17_001 from zedt17_001.

*

*      if sy-subrc ne 0.

*        e_message = '### ##'.

*        exit.

*      endif.

*  endloop.

*else.

*  e_message = '#### ### ###'.

*endif.










ENDFUNCTION.