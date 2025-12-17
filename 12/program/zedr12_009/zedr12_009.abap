
*&---------------------------------------------------------------------*

*& Report ZEDR12_009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_009.

DATA: TEXT1 TYPE STRING,

      TEXT2(4) TYPE C,

      TEXT3(4) TYPE C.



TEXT1 ='AB'.

TEXT2 ='AP'.



CONCATENATE TEXT1 TEXT2 INTO TEXT3.



WRITE: TEXT1.

WRITE:/ TEXT2.

WRITE:/ TEXT3.