
*&---------------------------------------------------------------------*

*& Report ZEDR12_DO_6

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DO_6.

DATA: BEGIN OF GS_NAME,

  NAME1 TYPE C LENGTH 10,

  NAME2 TYPE C LENGTH 10,

  END OF GS_NAME.



  GS_NAME-NAME1 ='###'.

  GS_NAME-NAME2 ='##'.



WRITE GS_NAME-NAME2 TO GS_NAME-NAME1.



WRITE: GS_NAME-NAME1.

WRITE:/ GS_NAME-NAME2.