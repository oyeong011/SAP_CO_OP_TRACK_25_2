
*&---------------------------------------------------------------------*

*& Report ZEDR24_014_PERFORM

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_014_PERFORM.





DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT24_001
.

DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_ZCODE LIKE ZEDT24_001-ZCODE,

       GV_ZKNAME LIKE ZEDT24_001-ZKNAME.



GV_ZCODE = 'SSU-01'.






*PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME.

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       1. CALL BY REFERENCE ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM GET_DATA USING PV_ZCODE PV_ZKNAME. "CALL BY REFERENCE

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO PV_ZKNAME

*    WHERE ZCODE = PV_ZCODE.

*ENDFORM.



*PERFORM GET_DATA USING GV_ZCODE GV_ZKNAME.

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       2. CALL BY VALUE ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM GET_DATA USING VALUE(PV_ZCODE) PV_ZKNAME. "CALL BY VALUE, CALL BY REFERENCE

*  PV_ZCODE = 'SSU-02'.

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO PV_ZKNAME

*    WHERE ZCODE = PV_ZCODE.

*ENDFORM.



*PERFORM GET_DATA USING GV_ZCODE

*                 CHANGING GV_ZKNAME.

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       3. USING CHANING ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM GET_DATA USING PV_ZCODE      "CALL BY VALUE -> ## ## # ### # WARNING# ## ## ## ##

*              CHANGING PV_ZKNAME. "CALL BY REFERENCE

*  PV_ZCODE = 'SSU-02'.

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO PV_ZKNAME

*    WHERE ZCODE = PV_ZCODE.

*ENDFORM.





*PERFORM GET_DATA USING GV_ZCODE

*                 CHANGING GV_ZKNAME.

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       4. CALL BY VALUE AND RESULT, USING CHANING ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM GET_DATA USING PV_ZCODE

*              CHANGING VALUE(PV_ZKNAME). "CALL BY VALUE RESULT (REFERENCE# ####, ## # ##, ## # ### ##,)

*  PV_ZCODE = 'SSU-02'.

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO PV_ZKNAME

*    WHERE ZCODE = PV_ZCODE.

*

*    PV_ZKNAME = 'TEST'.

*ENDFORM.



*

*GV_ZCODE = 'SSU-01'.

*

*PERFORM GET_DATA USING GV_ZCODE

*                 CHANGING GV_ZKNAME.

*

*WRITE :/ GV_ZCODE.

*WRITE :/ GV_ZKNAME.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       5. ## PARAMETER ## ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*"1. TYPE ##

*FORM GET_DATA USING PV_ZCODE TYPE C

*              CHANGING PV_ZKNAME TYPE C.

*"2. LIKE ##

*FORM GET_DATA USING PV_ZCODE LIKE ZEDT24_001-ZCODE

*              CHANGING PV_ZKNAME LIKE ZEDT24_001-ZKNAME.

*  PV_ZCODE = 'SSU-02'.

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO PV_ZKNAME

*    WHERE ZCODE = PV_ZCODE.

*

*    PV_ZKNAME = 'TEST'.

*ENDFORM.





*GS_STUDENT-ZCODE = 'SSU-01'.

*

*PERFORM GET_DATA USING GS_STUDENT.

*

*WRITE :/ GS_STUDENT-ZCODE.

*WRITE :/ GS_STUDENT-ZKNAME.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       5. ### PARAMETER ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*

*"1. LIKE ##

*FORM GET_DATA USING PS_STUDENT LIKE GS_STUDENT.

*

*"2. STRUCTURE ##

*FORM GET_DATA USING PS_STUDENT STRUCTURE GS_STUDENT.

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = PS_STUDENT-ZCODE.

*ENDFORM.





*GS_STUDENT-ZCODE = 'SSU-01'.

*

*PERFORM GET_DATA USING GT_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*ENDLOOP.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       6. ITAB# GENERIC## ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM GET_DATA USING PT_STUDENT TYPE STANDARD TABLE.

*

*  DATA : LS_STUDENT LIKE GS_STUDENT.

*  LS_STUDENT-ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO LS_STUDENT-ZKNAME

*    WHERE ZCODE = LS_STUDENT-ZCODE.

*

*  APPEND LS_STUDENT TO PT_STUDENT.

*ENDFORM.





*"--------------------

*"## #### ## ### ##

*DATA : GV_FORMNAME(20) VALUE 'GET_DATA'. "### ####

*TRANSLATE GV_FORMNAME TO UPPER CASE.

*

*PERFORM (GV_FORMNAME) CHANGING GT_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*ENDLOOP.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       5. ### PARAMETER ##

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM GET_DATA USING PT_STUDENT TYPE STANDARD TABLE.

*

*  DATA : LS_STUDENT LIKE GS_STUDENT.

*  LS_STUDENT-ZCODE = 'SSU-01'.

*

*  SELECT SINGLE ZKNAME FROM ZEDT24_001

*    INTO LS_STUDENT-ZKNAME

*    WHERE ZCODE = LS_STUDENT-ZCODE.

*

*  APPEND LS_STUDENT TO PT_STUDENT.

*ENDFORM.








"------------------------

"1. PERFORM ON COMMIT



DATA : GV_FLAG.



SELECT SINGLE * FROM ZEDT24_001

  INTO GS_STUDENT WHERE ZCODE = 'SSU-01'.



PERFORM DELETE_DATA USING GS_STUDENT GV_FLAG.

PERFORM INSERT_DATA ON COMMIT.

PERFORM INSERT_DATA_2 ON COMMIT.



IF GV_FLAG = 'X'.

  COMMIT WORK.

ENDIF.



WRITE :/ '#### ## ### ##?'.






*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*----------------------------------------------------------------------*




FORM DELETE_DATA  USING PS_STUDENT PV_FLAG.

  WRITE :/ '## ### ##'.

  PV_FLAG = 'X'.

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

  WRITE :/ '## ### ##'.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  INSERT_DATA_2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_DATA_2 .

  WRITE :/ 'ON COMMIT PERFORM# 2# ## ### ### COMMIT WORK # ## ## ## #'.

ENDFORM.