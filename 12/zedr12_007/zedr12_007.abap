
*&---------------------------------------------------------------------*

*& Report ZEDR12_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_007.

DATA: TEXT1 TYPE STRING,

      TEXT2(8) TYPE C,

      TEXT3(8) TYPE C.



TEXT1 = 'AB  AP'.

TEXT2 = 'AB  AP'.

TEXT3 = 'AB  AP'.



CONDENSE TEXT1.

CONDENSE TEXT2 NO-GAPS.



WRITE: TEXT1.

WRITE:/ TEXT2.

WRITE:/ TEXT3.