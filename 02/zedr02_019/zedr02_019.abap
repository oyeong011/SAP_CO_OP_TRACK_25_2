
*&---------------------------------------------------------------------*

*& Report ZEDR02_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_019.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT02_001
.

DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.






*"EXTERNAL

*"GV# # #### #### ####->## ## ##

**DATA: GV_ZCODE LIKE ZEDT02_001-ZCODE.

**DATA: GV_ZKNAME LIKE ZEDT02_001-ZKNAME.

**

**"IF FOUND# ## ##-># ### #### ### ## ##

**PERFORM GET_DATA(ZEDR02_018) IF FOUND CHANGING GT_STUDENT.

*

*"DYNAMIC: ### #### ##

*DATA: GV_PNAME(20) VALUE 'ZEDR02_018'.

*DATA: GV_FORMNAME(20) VALUE 'GET_DATA'.

*

*TRANSLATE GV_PNAME TO UPPER CASE. "### #### ##

*TRANSLATE GV_FORMNAME TO UPPER CASE.

*

*PERFORM (GV_FORMNAME) IN PROGRAM (GV_PNAME) IF FOUND CHANGING GT_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  WRITE: / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*ENDLOOP.






"LIST# ### #### ##

"## ### #### INDEX### ## Subroutine list ##

"Internal Subroutine### ## ##, #### ## ##




*DO 2 TIMES.

*  PERFORM SY-INDEX OF SUBR1 SUBR2.

*ENDDO.

*FORM SUBR1.

*  WRITE : / SY-INDEX, '## ####'.

*ENDFORM.

*FORM SUBR2.

*  WRITE: / SY-INDEX, '## ####'.

*ENDFORM.






DATA: GV_FLAG.



SELECT SINGLE * FROM ZEDT02_001

  INTO GS_STUDENT WHERE ZCODE = 'SSU-01'.



PERFORM DELETE_DATA USING GS_STUDENT.

PERFORM INSERT_DATA ON COMMIT. "COMMIT WORK# ### #### ## ##



IF GV_FLAG = 'X'.

  COMMIT WORK.

ENDIF.




*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*----------------------------------------------------------------------*




FORM DELETE_DATA USING PS_STUDENT LIKE GS_STUDENT.



  DELETE ZEDT02_001 FROM PS_STUDENT.

  IF SY-SUBRC = 0.

    GV_FLAG = 'X'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INSERT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_DATA .

  INSERT ZEDT02_001 FROM GS_STUDENT.

ENDFORM.