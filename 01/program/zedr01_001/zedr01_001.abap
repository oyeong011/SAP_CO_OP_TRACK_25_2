
REPORT 2025-09-05_DATATYPE_01 .



DATA : gv_num1 TYPE p VALUE '1234'  .

DATA : gv_num2 TYPE p DECIMALS 2 VALUE '12.34'.



DATA : gv_num3 TYPE i VALUE 1234.



DATA : gv_num4 TYPE N VALUE 1234.

DATA : gv_num5 TYPE N LENGTH 2 VALUE 1234.

DATA : gv_num6 TYPE N LENGTH 3 VALUE 1234.

DATA : gv_num7 TYPE N LENGTH 4 VALUE 1234.





WRITE : gv_num1.

WRITE :/ gv_num2.

WRITE :/ gv_num3.

WRITE :/ gv_num4.

WRITE :/ gv_num5.

WRITE :/ gv_num6.

WRITE :/ gv_num7.