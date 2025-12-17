
*&---------------------------------------------------------------------*

*& Report ZEDR018_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_001.



DATA:gv_text1 TYPE c LENGTH 1 VALUE 'A'.

DATA:gv_text2 TYPE c LENGTH 3 VALUE 'ABC'.

DATA:gv_text3 TYPE c LENGTH 5 VALUE 'ABCDE'.

DATA:gv_text4 TYPE string     VALUE 'ABCDE'.

DATA:gv_len   TYPE i.



DATA gv_time TYPE t.

DATA gv_date TYPE d.



gv_time = sy-uzeit.

gv_date = sy-datum.



gv_len = strlen( gv_text3 ).





WRITE : GV_TEXT1.

WRITE :/ gv_text2.

WRITE :/ gv_text3.

WRITE :/ gv_text4.

WRITE :/ gv_len.

WRITE :/ gv_time.

WRITE :/ gv_date.





DATA:TEXT1 TYPE STRING,

 TEXT2(4) TYPE C.

 TEXT1 ='ABAP'.

 TEXT2 = 'B'.

shift TEXT2 by 2 places.

write:/ text2.