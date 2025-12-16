
*&---------------------------------------------------------------------*

*& Report ZEDR12_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_012.

"### TYPE ##

TYPES : BEGIN OF T_ZEDT12, "#######

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT12.



"### ## ##

  DATA : GS_ZEDT12 TYPE T_ZEDT12.



  GS_ZEDT12-ZCODE = 'SSU01'.

  GS_ZEDT12-ZKNAME = '###'.

  GS_ZEDT12-ZENAME = 'KANG'.



  WRITE : / GS_ZEDT12-ZCODE.

  WRITE : / GS_ZEDT12-ZKNAME.

  WRITE : / GS_ZEDT12-ZENAME.