
*&---------------------------------------------------------------------*

*& Report ZEDR04_074

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_074.



DATA : GV_NUM1 TYPE I,

       GV_NUM2 TYPE I,

       GV_OP TYPE C.

DATA : GV_RESULT TYPE I,

       GV_MESSAGE TYPE C LENGTH 20.

DATA : GV_RESULT_SUM TYPE N,

       GV_MESSAGE_RESULT TYPE C LENGTH 20.



GV_NUM1 = '3'.

GV_NUM2 = '5'.

GV_OP = '+'.



" SE37 OR SE80 ##

CALL FUNCTION 'ZED04_CALCULATE'

  EXPORTING

    I_NUM1             = GV_NUM1

    I_NUM2             = GV_NUM2

    I_OPTION           = GV_OP

  IMPORTING

    E_RESULT           = GV_RESULT

    E_MESSAGE          = GV_MESSAGE




* CHANGING

*   P_ZEDT04_001       =




  EXCEPTIONS

    DIV_ZERO           = 1

    OTHERS             = 2

          .

IF SY-SUBRC = 0.

  GV_RESULT_SUM = GV_RESULT.

  CONCATENATE '####' GV_RESULT_SUM '###' INTO GV_MESSAGE_RESULT.

  WRITE : / GV_MESSAGE.

  WRITE : / GV_MESSAGE_RESULT.

ELSEIF SY-SUBRC = 1.

  WRITE : / '0## ## # ####.'.

ELSE.

  WRITE : / '##'.

  WRITE : / GV_MESSAGE.

ENDIF.