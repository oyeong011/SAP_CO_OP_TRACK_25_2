
*&---------------------------------------------------------------------*

*& Report ZED23_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZED23_004.



" 1. ###->###### / header (O)

DATA : GS_ZEDT23 TYPE ZEDT23_001.     "###### ## # ### ##

DATA : GT_ZEDT23 TYPE TABLE OF ZEDT23_001.  "###### ##



" Header ##

GS_ZEDT23-ZCODE = 'SSU-01'.

GS_ZEDT23-ZKNAME = '#'.

GS_ZEDT23-ZENAME = 'KANG'.

GS_ZEDT23-ZGENDER = 'M'.

GS_ZEDT23-ZTEL = '01099991111'.



"Body #### ##

APPEND GS_ZEDT23 TO GT_ZEDT23.

" ## CLEAR ## ### ####~

CLEAR GS_ZEDT23.



BREAK-POINT.



GS_ZEDT23-ZCODE = 'SSU-02'.

GS_ZEDT23-ZKNAME = '#'.

GS_ZEDT23-ZENAME = 'KIM'.

GS_ZEDT23-ZGENDER = 'M'.

GS_ZEDT23-ZTEL = '01099992222'.



INSERT GS_ZED23 INTO GT_ZEDT23 INDEX 1.



CLEAR GS_ZEDT23.



BREAK-POINT.



SORT GT_ZET23.  "Default : Ascending, DESCENDING ## ####

" SORT GT_ZET23 BY ZKNAME ZENAME ASCENDING.

" => # ### SORT GT_ZEDT23 BY ZKNAME ASCENDING BY ZENAME ASCENDING.



"COLLECT INTO : ### ##



"**********************************************





" 2. OCCURS 0 : Internal table, header (O)

DATA : BEGIN OF GT_STUDENT OCCURS 0,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  ZGENDER TYPE C LENGTH 1,

  ZTEL TYPE C LENGTH 16,

  END OF GT_STUDENT.



" Header ##

GT_STUDENT-ZCODE = 'SSU-24'.

GT_STUDENT-ZKNAME = '##'.

GT_STUDENT-ZENAME = 'Jenny'.

GT_STUDENT-ZGENDER = 'F'.

GT_STUDENT-ZTEL = '01099992222'.



" Body #### ##

APPEND GT_STUDENT.



" ## ### ## Internal table : header clear

CLEAR GT_STUDENT.



DATA : BEGIN OF GT_STUDENT2 OCCURS 0,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  ZGENDER TYPE C LENGTH 1,

  ZTEL TYPE C LENGTH 16,

  END OF GT_STUDENT2.





GT_STUDENT2-ZCODE = 'SSU-25'.

GT_STUDENT2-ZKNAME = '##'.

GT_STUDENT2-ZENAME = 'Jisoo'.

GT_STUDENT2-ZGENDER = 'F'.

GT_STUDENT2-ZTEL = '01099993333'.



APPEND GT_STUDENT2.

CLEAR GT_STUDENT2.

BREAK-POINT.



" 1. Header copy

" MOVE-CORRESPONDING GT_STUDENT TO GT_STUDENT2.



" 2. Body copy

" MOVE-CORRESPONDING : GT_STUDENT2[] ## ### ### ###

" MOVE # BODY# #### ## APPEND ## / ### APPEND ####~

MOVE-CORRESPONDING GT_STUDENT[] TO GT_STUDENT2[].

APPEND GT_STUDENT2.

BREAK-POINT.



" APPEND : header -> body ##

" APPEND LINES OF - TO - : t1 body -> t2 body (##. t2 ### ##)

"  - ### ### ## ## ## ##

"  - ## APPEND ## X

APPEND LINES OF GT_STUDENT TO GT_STUDENT2.  "### ## #

BREAK-POINT.