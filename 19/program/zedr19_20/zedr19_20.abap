
*&---------------------------------------------------------------------*

*& Report ZEDR19_20

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_20.



DATA : BEGIN OF GS_NAME,

  NAME1 TYPE C LENGTH 10,

  DEGREE1 TYPE P DECIMALS 2,

  END OF GS_NAME.



GS_NAME-NAME1 = '##'.

GS_NAME-DEGREE1 = '35.12'.



MOVE GS_NAME-DEGREE1 TO GS_NAME-NAME1.



WRITE :/ GS_NAME-NAME1.

WRITE :/ GS_NAME-DEGREE1.