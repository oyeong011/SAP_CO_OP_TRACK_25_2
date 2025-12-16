
*&---------------------------------------------------------------------*

*& Report ZEDR09_032

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_032.





DATA : BEGIN OF GS_STUDENT,

  ZCODE LIKE ZEDT09_001-ZCODE,

  ZKNAME LIKE ZEDT09_001-ZKNAME,

  ZENAME LIKE ZEDT09_001-ZENAME,

  ZMEMO(10),

END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GV_ZCODE(10) VALUE 'ZCODE'.



SELECT *

  FROM ZEDT09_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.





LOOP AT GT_STUDENT ASSIGNING FIELD-SYMBOL(<FS_T>).

  IF <FS_T>-ZENAME = 'LEE'.

    <FS_T>-ZMEMO = '####'.

  ENDIF.

ENDLOOP.



"## ##### <FS_T>## ### ####

"itab# MODIFY

" -> ##### #### #### ###, <FS_T>## ####, #### ### ## ## ##!