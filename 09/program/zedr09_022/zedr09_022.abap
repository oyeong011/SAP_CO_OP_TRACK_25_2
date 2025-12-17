
*&---------------------------------------------------------------------*

*& Report ZEDR09_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_022.








* =====================================================================

* #### ## : Internal, External, Dynamic, PERFORM ON COMMIT



* 1. Internal (##) ## : ## #### ##, ## #### ### #### ##

*   - PERFORM ## ## ###### ### ##

*

* 2. External (##) ## : ## ##### ## ##### #### ##, ## #### ##

*   - IF FOUND ## ## : ##### ##### ### ##### ## #### ##### #### ## (dump error)# ## # ##

*

* 3. Dynamic (##) ## : ### ##### ### ## ## ## #### ##

*   - ## ## ### #### ### #### ### ### #### #### #

*

* 4. Special (##) ## : ## ###(#: ###### ##)# ### ### #### ##

*   - PERFORM ON COMMIT : COMMIT WORK ### ### #, #### ##

*   - PERFORM ON ROLLBACK : ROLLBACK WORK ### ### #, #### ##





* =====================================================================





* 1. INTERNAL# ## ZEDR09_021 ###### #####, ## #### ## #### #####,, ## ### #



* 2. EXTERNAL ## (##)

*  PERFORM FORM_NAME(PROGRAM) IF FOUND

*  USING P_NAME

*  CHANGING P_NAME



*  DATA : GS_STUDENT LIKE ZEDT09_001.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  PERFORM GET_DATA(ZEDR09_021) IF FOUND CHANGING GT_STUDENT. "zedt09_021 ###### ### ## ##

*

*  "## ##

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*  ENDLOOP.





* 3. Dynamic ## (##)

*  PERFORM (NAME) IN PROGRAM (Program name) IF FOUND

*  USING P_NAME

*  CHANGING P_NAME



*  DATA : GS_STUDENT LIKE ZEDT09_001.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  DATA : GV_PNAME(20) VALUE 'ZEDR09_021'. "#### ### #### ##

*  DATA : GV_FORMNAME(20) VALUE 'GET_DATA'. "#### ### #### ##

*

**   ## ### ### ## ###### ###### ### #### #### ##

*  TRANSLATE GV_PNAME TO UPPER CASE.

*  TRANSLATE GV_FORMNAME TO UPPER CASE.

*

*  PERFORM (GV_FORMNAME) IN PROGRAM (GV_PNAME) IF FOUND CHANGING GT_STUDENT.

*

*    LOOP AT GT_STUDENT INTO GS_STUDENT.

*      WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*    ENDLOOP.



* ##, LIST# ### #### ##

* #, ## ### ##### ##.

*   1. Internal Subroutine### ####

*   2. #### ## ##

*

*  DO 2 TIMES.

*    PERFORM SY-INDEX OF SUBR1 SUBR2.

*  ENDDO.

*  FORM SUBR1.

*    WRITE : / SY-INDEX, '## ####'.

*  ENDFORM.

*  FORM SUBR2.

*    WRITE : / SY-INDEX, '## ####'.

*  ENDFORM.







* 4. Special ## (re)

* ## ###(#: ###### ##)# ### ### #### ##

*   - PERFORM ON COMMIT : COMMIT WORK ### ### #, #### ##

*   - PERFORM ON ROLLBACK : ROLLBACK WORK ### ### #, #### ##




DATA : GS_STUDENT LIKE ZEDT09_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GV_FLAG.






* SELECT DATA




SELECT SINGLE *

  FROM ZEDT09_001

  INTO GS_STUDENT

  WHERE ZCODE = 'SSU-01'.






* DELETE DATA perform ##




PERFORM DELETE_DATA USING GS_STUDENT.






* perform skip! (insert-data perform# commit work# ## # ## !)




PERFORM INSERT-DATA ON COMMIT.



IF SY-SUBRC = 0.

  COMMIT WORK. "insert-data perform ##

ENDIF.






*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*----------------------------------------------------------------------*




FORM DELETE_DATA  USING    P_GS_STUDENT STRUCTURE GS_STUDENT.



  DELETE ZEDT09_001 FROM P_GS_STUDENT. "### ##



  IF SY-SUBRC = 0.

    GV_FLAG = 'X'. "flag ##

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  INSERT-DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT-DATA . "#### db ##  ####

  INSERT ZEDT09_001 FROM GS_STUDENT.

ENDFORM.