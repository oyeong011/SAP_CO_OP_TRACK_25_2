
*&---------------------------------------------------------------------*

*& Report ZEDR04_027

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_027.



" 1. ## ##

CONSTANTS C_RATE TYPE I VALUE '100'.



DATA : GV_SUM1 TYPE I VALUE '10.00'.



GV_SUM1 = GV_SUM1 * C_RATE. "#### ##### # #



WRITE / GV_SUM1.  "     1,000



" 2. ### ##

CONSTANTS : BEGIN OF C_STUDENT,

  ZCODE(10) VALUE 'SSU-01',

  ZKNAME(10) VALUE '###',

  ZENAME(10) VALUE 'DONG',

  END OF C_STUDENT.



WRITE / C_STUDENT-ZCODE.

WRITE / C_STUDENT-ZKNAME.

WRITE / C_STUDENT-ZENAME.