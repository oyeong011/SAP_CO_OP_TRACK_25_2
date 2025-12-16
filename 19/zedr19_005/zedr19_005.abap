
*&---------------------------------------------------------------------*

*& Report ZEDR19_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_005.



DATA : TEXT1 TYPE STRING,

           TEXT2(4) TYPE C.



TEXT1 = 'ABAP'.

TEXT2 = 'abap'.



TRANSLATE TEXT1 To LOWER CASE.

TRANSLATE TEXT2 To UPPER CASE.

WRITE : TEXT1.

WRITE :/ TEXT2.