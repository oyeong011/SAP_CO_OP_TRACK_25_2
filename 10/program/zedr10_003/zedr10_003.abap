
*&---------------------------------------------------------------------*

*& Report ZEDR10_003

*&---------------------------------------------------------------------*

*& ## ### ###.

*&---------------------------------------------------------------------*




REPORT ZEDR10_003.



DATA: BEGIN OF gs_name,

  name1 TYPE C LENGTH 10,

  name2 TYPE C LENGTH 10,

  END OF gs_name.



gs_name-name1 = '###'.

gs_name-name2 = '##'.



WRITE: gs_name-name1.

WRITE:/ gs_name-name2.



gs_name-name1 = gs_name-name2 .



WRITE:/ gs_name-name1.

WRITE:/ gs_name-name2.



ULINE /.



gs_name-name1 = '###'.

gs_name-name2 = '##'.



MOVE gs_name-name2 TO gs_name-name1.



WRITE: gs_name-name1.

WRITE:/ gs_name-name2.



ULINE /.



DATA: BEGIN OF gs_name1,

  name1 TYPE C LENGTH 10,

  degree1 TYPE P DECIMALS 2,

  END OF gs_name1.



gs_name1-name1 = '##'.

gs_name1-degree1 = '35.12'.



MOVE gs_name1-degree1 to gs_name1-name1.



CONDENSE gs_name1-name1 NO-GAPS.



WRITE: gs_name1-name1.

WRITE:/ gs_name1-degree1.



ULINE /.



DATA: gv_data1(8) VALUE 'ABCDEFGH',

      gv_data2(8) VALUE 'IJKLMNOP'.

DATA: gv_start TYPE I VALUE 2,

      gv_length TYPE I VALUE 4.



MOVE gv_data1+gv_start(gv_length) to gv_data2+gv_start(gv_length).

WRITE:/ gv_data2.



ULINE /.



DATA: BEGIN OF gs_name2,

  name1 TYPE C LENGTH 10,

  name2 TYPE C LENGTH 10,

  END OF gs_name2.



gs_name2-name1 = '###'.

gs_name2-name2 = '##'.



WRITE gs_name2-name2 to gs_name2-name1.



WRITE: gs_name2-name1.

WRITE:/ gs_name2-name2.



ULINE /.