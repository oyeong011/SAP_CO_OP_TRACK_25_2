
*&---------------------------------------------------------------------*

*& Report ZEDR17_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_014.



data : gv_num1 type i,

      gv_num2 type i,

      gv_op type c.

data : gv_result type i,

      gv_message(20).

data : gv_result_sum type n,

      gv_message_result(20).



gv_num1 = '3'.

gv_num2 = '5'.

gv_op = '+'.



call function 'ZED17_CALCULATE'

 EXPORTING

   I_NUM1             = gv_num1

   I_NUM2             = gv_num2

   I_OPTION           = gv_op

 IMPORTING

   E_RESULT           = gv_result

   E_MESSAGE          = gv_message




* TABLES

*   T_ZEDT17_001       =

* CHANGING

*   P_ZEDT17_001       =




 EXCEPTIONS

   DIV_ZERO           = 1

   OTHERS             = 2

          .

if sy-subrc = 0.

  gv_result_sum = gv_result.

  concatenate '####' gv_result_sum '###' into gv_message_result.

  write : / gv_message.

  write : / gv_message_result.

elseif sy-subrc = 1.

  write : / '0## ## # ####'.

else.

  write : / '##'.

  write : / gv_message.

endif.