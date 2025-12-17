
*&---------------------------------------------------------------------*

*& Report ZEDR04_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_011.



" ## #### TYPE I, P# ##?

DATA :  gv_num1 TYPE i VALUE 5,

        gv_num2 TYPE i VALUE 3,

        gv_num3 TYPE i.



gv_num3 = gv_num1 + gv_num2.

WRITE gv_num3.



gv_num3 = gv_num1 - gv_num2.

WRITE / gv_num3.



gv_num3 = gv_num1 * gv_num2.

WRITE / gv_num3.



gv_num3 = gv_num1 / gv_num2.

WRITE / gv_num3.



gv_num3 = gv_num1 DIV gv_num2.

WRITE / gv_num3.



gv_num3 = gv_num1 MOD gv_num2.

WRITE / gv_num3.



gv_num3 = gv_num1 ** gv_num2.

WRITE / gv_num3.






*        8

*        2

*       15

*        2

*        1

*        2

*      125