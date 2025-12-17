
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTUPDATE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTUPDATE003.






* 3. UPDATE SET

* UPDATE SET##############

*UPDATE<TABLE> SETFIELD = #### WHERE[COND]






DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



  UPDATE ZEDT12_001 SET ZENAME = 'JUNG'

  WHERE ZCODE = 'SSU-03'.



  IF SY-SUBRC = 0.

    WRITE:/ '### ## ##'.

  ENDIF.