
*&---------------------------------------------------------------------*

*& Report ZEDR25_017

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_017.



DATA : gv_num1 TYPE i,

       gv_num2 TYPE i,

       gv_op   TYPE c.



DATA : gv_result  TYPE i,

       gv_message TYPE c LENGTH 20.



DATA : gv_result_sum     TYPE n,

       gv_message_result TYPE c LENGTH 20.



gv_num1 = '3'.

gv_num2 = '5'.

gv_op = '+'.



CALL FUNCTION 'ZED25_CALCULATE'

  EXPORTING

    i_num1    = gv_num1

    i_num2    = gv_num2

    i_option  = gv_op

  IMPORTING

    e_result  = gv_result

    e_message = gv_message



  EXCEPTIONS

    div_zero  = 1

    OTHERS    = 2.

IF sy-subrc = 0.

  gv_result_sum = gv_result.

  CONCATENATE '####' gv_result_sum '###' INTO gv_message_result.

  WRITE :/ gv_message.

  WRITE :/ gv_message_result.

ELSEIF sy-subrc = 1.

  WRITE :/ '0## ## # ####.'.

ELSE.

  WRITE :/ '##'.

  WRITE :/ gv_message.

ENDIF.