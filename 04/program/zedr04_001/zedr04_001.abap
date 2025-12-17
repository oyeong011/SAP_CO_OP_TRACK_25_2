
*&---------------------------------------------------------------------*

*& Report ZEDR04_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_001.



" Packed Number : Decimals #### ### ## ##

DATA : gv_num1 TYPE p VALUE '1234'.

DATA : gv_num2 TYPE p DECIMALS 2 VALUE '12.34'.



" Integer: ##. ## ## ## x

DATA : gv_num3 TYPE i VALUE 1234.



" Numeric Text Field : ### C#### ##? ## ## ## ## ##

DATA : gv_num4 TYPE N VALUE 1234.

DATA : gv_num5 TYPE N LENGTH 2 VALUE 1234.

DATA : gv_num6 TYPE N LENGTH 3 VALUE 1234.

DATA : gv_num7 TYPE N LENGTH 4 VALUE 1234.





WRITE : gv_num1.  "           1,234

WRITE :/ gv_num2. "            12.34

WRITE :/ gv_num3. "      1,234

WRITE :/ gv_num4. "4

WRITE :/ gv_num5. "34

WRITE :/ gv_num6. "234

WRITE :/ gv_num7. "1234