
*&---------------------------------------------------------------------*

*& Report ZEDR02_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_022.



"FUNCTION PROGRAM ##



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



CALL FUNCTION 'ZED02_CALCULATE'

  EXPORTING

   I_NUM1             = GV_NUM1

   I_NUM2             = GV_NUM2

    I_OPTION           = GV_OP

 IMPORTING

   E_RESULT           = GV_RESULT

   E_MESSAGE          = GV_MESSAGE




*   E_RESULT2          =

* TABLES

*   T_ZEDT02_001       =

* CHANGING

*   P_ZEDT02_001       =




 EXCEPTIONS

   DIV_ZERO           = 1

   OTHERS             = 2

          .

IF SY-SUBRC = 0.

  GV_RESULT_SUM = GV_RESULT.

  CONCATENATE '####' GV_RESULT_SUM '###' INTO GV_MESSAGE_RESULT.

  WRITE: / GV_MESSAGE.

  WRITE: / GV_MESSAGE_RESULT.

ELSEIF SY-SUBRC = 1.

  WRITE: / '0## ## # ####'.

ELSE.

  WRITE: / '##'.

  WRITE: / GV_MESSAGE.

ENDIF.