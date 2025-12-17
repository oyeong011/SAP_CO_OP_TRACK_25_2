
*&---------------------------------------------------------------------*

*& Report ZEDR07_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_014.



DATA : gv_num1 TYPE i,

       gv_num2 TYPE i,

       gv_op TYPE c.



DATA : gv_result TYPE i,

       gv_message TYPE c LENGTH 20.



DATA : gv_result_sum TYPE n,

       gv_message_result TYPE c LENGTH 20.



gv_num1 = '3'.

gv_num2 = '0'.

gv_op = '+'.



CALL FUNCTION 'ZED07_CALCULATE'

  EXPORTING

               I_NUM1             = gv_num1

               I_NUM2             =  gv_num2

                I_OPTION          = gv_op

  IMPORTING

               E_RESULT           = gv_result

               E_MESSAGE          = gv_message




*             TABLES

*               T_ZEDT07_001       =

*             CHANGING

*               P_ZEDT07_001       =




            EXCEPTIONS

               DIV_ZERO           = 1

               OTHERS             = 2

                      .

IF SY-SUBRC = 0.

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