
*&---------------------------------------------------------------------*

*& Report ZEDR09_027

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_027.






* =====================================================================

* function_program :abap ###### function module ## ##





* =====================================================================






"function ### ##### ### ### ## ### dump error

DATA : GV_NUM1 TYPE I,

       GV_NUM2 TYPE I,

       GV_OP TYPE C.



DATA : GV_RESULT TYPE I,

       GV_MSG TYPE C LENGTH 20.



DATA : GV_RESULT_SUM TYPE N,

       GV_MSG_RESULT TYPE C LENGTH 20.



GV_NUM1 = '3'.

GV_NUM2 = '5'.

GV_OP = '+'.



"pattern# ## ## ##

CALL FUNCTION 'ZED09_CALCULATE'  "### p13~ ##### ## ### ## #, ## ## #### > service tool > goto source code, # service > save #### as test data(se37)## ### ### ## ##

  EXPORTING

    I_NUM1             = GV_NUM1

    I_NUM2             = GV_NUM2

    I_OPTION           = GV_OP

  IMPORTING

    E_RESULT           = GV_RESULT

    E_MESSAGE          = GV_MSG




* CHANGING

*   P_ZEDT09_001       =

*   T_ZEDT09_001       =




 EXCEPTIONS

    DIV_ZERO           = 1  "sy-subrc = 1### #. # exception ##

    OTHERS             = 2

          .



IF SY-SUBRC = 0.

  GV_RESULT_SUM = GV_RESULT.

  CONCATENATE '####' GV_RESULT_SUM '###' INTO GV_MSG_RESULT.

  WRITE : / GV_MSG.

  WRITE : / GV_MSG_RESULT.



ELSEIF SY-SUBRC = 1.

  WRITE : / '0## ## # ####'.

ELSE.

  WRITE : / '##'.

  WRITE : / GV_MSG.



ENDIF.