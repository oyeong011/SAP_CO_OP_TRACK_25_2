
*&---------------------------------------------------------------------*

*& Report ZEDR24_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_001.



"1. Predefined ABAP Type

DATA : gv_num1 TYPE P VALUE '1234',

       gv_num2 TYPE P DECIMALS 2 VALUE '12.34'.



DATA : gv_num3 TYPE I VALUE 1234.



DATA : gv_num4 TYPE N VALUE 1234,

       gv_num5 TYPE N LENGTH 2 VALUE 1234,

       gv_num6 TYPE N LENGTH 3 VALUE 1234,

       gv_num7 TYPE N LENGTH 4 VALUE 1234.



WRITE : gv_num1,

        / gv_num2,

        / gv_num3,

        / gv_num4,

        / gv_num6,

        / gv_num7.



"-------------------------------------------------

"2. Predefined ABAP Type

DATA : gv_text1 VALUE 'A', "### c# ##

       gv_text2 LENGTH 3 TYPE C VALUE 'ABC',

       gv_text3(5) TYPE C VALUE 'ABCDE'.



DATA : gv_text4 TYPE STRING VALUE 'ABCDE'.



DATA : gv_len TYPE I.

DATA : gv_time TYPE T.

DATA : gv_date TYPE D.



gv_time = SY-UZEIT.

gv_date = SY-DATUM.

gv_len = STRLEN( gv_text3 ).



WRITE : gv_text1,

        / gv_text2,

        / gv_text3,

        / gv_text4,

        / gv_len,

        / gv_time,

        / gv_date.