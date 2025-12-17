
*&---------------------------------------------------------------------*

*& Report ZEDR19_19

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_19.



DATA : BEGIN OF GS_NAME,

  NAME1 TYPE C LENGTH 10,

  NAME2 TYPE C LENGTH 10,

  END OF GS_NAME.



GS_NAME-NAME1 = '###'.

GS_NAME-NAME2 = '##'.



MOVE GS_NAME-NAME2 TO GS_NAME-NAME1.



WRITE :/ GS_NAME-NAME1.

WRITE :/ GS_NAME-NAME2.