
*&---------------------------------------------------------------------*

*& Report ZEDR12_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_013.

"### TYPE ##

TYPES : BEGIN OF T_ZEDT12, "#######

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF T_ZEDT12.



TYPES: BEGIN OF T_ZEDT12_2. "#######+####

  INCLUDE TYPE T_ZEDT12.

  TYPES : TITLE TYPE C LENGTH 10,

          GRADE TYPE C LENGTH 1,



          END OF T_ZEDT12_2.



  DATA : GS_ZEDT12 TYPE T_ZEDT12_2.



          GS_ZEDT12-ZCODE = 'SSU01'.

          GS_ZEDT12-ZKNAME = '###'.

          GS_ZEDT12-ZENAME = 'K'.

          GS_ZEDT12-TITLE = 'COMPUTERSCIENCE'.

          GS_ZEDT12-GRADE = '3'.



WRITE :/ GS_ZEDT12-ZCODE.

WRITE :/ GS_ZEDT12-ZKNAME.

WRITE :/ GS_ZEDT12-ZENAME.

WRITE :/ GS_ZEDT12-TITLE.

WRITE :/ GS_ZEDT12-GRADE.