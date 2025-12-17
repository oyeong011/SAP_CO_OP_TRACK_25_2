
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTINSERT001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTINSERT001.

DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

 DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



 GS_STUDENT-MANDT = SY-MANDT.

 GS_STUDENT-ZCODE = 'SSU-26'.

 GS_STUDENT-ZPERNR = '0000000026'.

 GS_STUDENT-ZKNAME = '###'.

 GS_STUDENT-ZENAME = 'DO'.

 GS_STUDENT-ZGENDER = 'F'.

 GS_STUDENT-ZTEL = '01000001111'.



 INSERT INTO ZEDT12_001 VALUES GS_STUDENT.



 IF SY-SUBRC = 0.

   WRITE:/ '##'.

 ELSE.

   WRITE:/ '##'.

 ENDIF.