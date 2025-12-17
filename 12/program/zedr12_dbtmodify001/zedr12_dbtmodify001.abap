
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTMODIFY001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTMODIFY001.






*1. Single line

*#######line###

*WA#####MODIFY######

*WA##############

*MODIFY<TABLE> FROMWA




" TABLE#, ################(INSERT)#




*

*2. Several lines

*####################

*MODIFY<TABLE> FROM TABLE ITAB




"### ## #####, ### ### ### #.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



CLEAR: GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-11'.

GS_STUDENT-ZPERNR = '0000000011'.

GS_STUDENT-ZKNAME = '##'.

GS_STUDENT-ZENAME = 'YOONN'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01000002222'.

APPEND GS_STUDENT TO GT_STUDENT.



MODIFY ZEDT12_001 FROM GS_STUDENT.



  IF SY-SUBRC = 0.

    WRITE:/ '### ## ##'.

  ENDIF.