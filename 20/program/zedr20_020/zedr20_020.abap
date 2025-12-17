
*&---------------------------------------------------------------------*

*& Report ZEDR20_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_020.



DATA: GV_NUM1 TYPE I,

      GV_NUM2 TYPE I,

      GV_OPTION TYPE C.

DATA: GV_RESULT TYPE I,

      GV_MESSAGE TYPE C LENGTH 20.

DATA: GV_RESULT_SUM TYPE N,

      GV_MESSAGE_RESULT TYPE C LENGTH 29.



GV_NUM1 = '3'.

GV_NUM2 = '6'.

GV_OPTION = '+'.



CALL FUNCTION 'ZED20_CALCULATE'

  EXPORTING

   I_NUM1             = GV_NUM1

   I_NUM2             = GV_NUM2

   I_OPTION           = GV_OPTION

 IMPORTING

   E_RESULT           = GV_RESULT

   E_MESSAGE          = GV_MESSAGE




* TABLES

*   T_ZEDT20_001       =

* CHANGING

*   P_ZEDT20_001       =




 EXCEPTIONS

   DIV_ZERO           = 1

   OTHERS             = 2

          .

IF SY-SUBRC = 0.

  GV_RESULT_SUM = GV_RESULT.

  CONCATENATE '#### ' GV_RESULT_SUM ' ###' INTO GV_MESSAGE_RESULT.

  WRITE:/ GV_MESSAGE.

  WRITE:/ GV_MESSAGE_RESULT.

ELSEIF SY-SUBRC = 1.

  WRITE:/ '0## ## # ####.'.

ELSE.

  WRITE:/ '##'.

  WRITE:/ GV_MESSAGE.

ENDIF.