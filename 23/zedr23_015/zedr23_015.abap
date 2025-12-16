
*&---------------------------------------------------------------------*

*& Report ZEDR23_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_015.



DATA : GV_NUM1 TYPE I,

      GV_NUM2 TYPE I,

      GV_OP TYPE C.



DATA : GV_RESULT TYPE I,

      GV_MESSAGE TYPE C LENGTH 20.



GV_NUM1 = '3'.

GV_NUM2 = '5'.

GV_OP = '+'.





CALL FUNCTION 'ZED23_CALCULATE'

  EXPORTING

   I_NUM1          = GV_NUM1

   I_NUM2          = GV_NUM2

    I_OPTION       = GV_OP

 IMPORTING

   E_RESULT        = GV_RESULT

   E_MESSAGE       = GV_MESSAGE

 EXCEPTIONS

   DIV_ZERO        = 1

   OTHERS          = 2

          .

IF SY-SUBRC = 0.




* Implement suitable error handling here




  WRITE : / GV_NUM1, GV_OP, GV_NUM2, '=', GV_RESULT.

ELSEIF SY-SUBRC = 1.

  WRITE : / '0## ## # ####'.

ELSE.

  WRITE : / '##'.

ENDIF.