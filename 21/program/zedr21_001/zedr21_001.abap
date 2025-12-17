
*&---------------------------------------------------------------------*

*& Report ZEDR21_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR21_001.

"DATA ####

DATA : BEGIN OF GS_ZEDT21, "#### ###

  ZCODE TYPE C LENGTH  10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  END OF GS_ZEDT21.



DATA : BEGIN OF GS_ZEDT21_2.

  INCLUDE STRUCTURE GS_ZEDT21.

  DATA : TITLE TYPE C LENGTH 10,

        GRADE TYPE C LENGTH 1,

  END OF GS_ZEDT21_2.





  GS_ZEDT21_2-ZCODE = 'SSU-01'.

  GS_ZEDT21_2-ZKNAME = '###'.

  GS_ZEDT21_2-ZENAME = 'DONG'.

  GS_ZEDT21_2-TITLE = '####'.

  GS_ZEDT21_2-GRADE = '3'.





  WRITE :/ GS_ZEDT21_2-ZCODE.

  WRITE :/ GS_ZEDT21_2-ZKNAME.

  WRITE :/ GS_ZEDT21_2-ZENAME.

  WRITE :/ GS_ZEDT21_2-TITLE.

  WRITE :/ GS_ZEDT21_2-GRADE.