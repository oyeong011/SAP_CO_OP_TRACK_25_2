
*&---------------------------------------------------------------------*

*& Report ZEDR12_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_005.

DATA: TEXT1 TYPE STRING,

      TEXT2(4) TYPE C.



TEXT1 = 'ABAP'.

TEXT2 = 'abap'.



TRANSLATE TEXT1 TO LOWER CASE.

TRANSLATE TEXT2 TO UPPER CASE.



WRITE: TEXT1.

WRITE:/ TEXT2.