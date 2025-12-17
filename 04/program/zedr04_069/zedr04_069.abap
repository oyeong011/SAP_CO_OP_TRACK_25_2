
*&---------------------------------------------------------------------*

*& Report ZEDR04_069

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_069.



DATA GS_STUDENT TYPE ZEDT04_001.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA GV_ZCODE LIKE ZEDT04_001-ZCODE.

DATA GV_ZKNAME LIKE ZEDT04_001-ZKNAME.



" 1. ##### #### ##

GV_ZCODE = 'SSU-01'.



  " ###

PERFORM GET_DATA USING GV_ZCODE       " ## ### ###

                 CHANGING GV_ZKNAME.  " ## ### ##

WRITE : / GV_ZCODE, GV_ZKNAME.





" 2. ##### ### ##

GS_STUDENT-ZCODE = 'SSU-02'.



PERFORM GET_DATA2 USING GS_STUDENT.

WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.





" 3. ##### ### ### ##




*PERFORM GET_DATA3 USING GS_STUDENT

*                        GT_STUDENT.




PERFORM GET_DATA3 CHANGING GT_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.



" LIST# ### SUBROUTINE ##.

DO 2 TIMES.

  PERFORM SY-INDEX OF SUBR1 SUBR2.

ENDDO.



" ###




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      --> p1       text

*      <-- p2       text

*----------------------------------------------------------------------*




"FORM GET_DATA USING P_ZCODE            " P_ZCODE# ## ACTUAL PARAMETER# ## ##.

FORM GET_DATA USING VALUE(P_ZCODE)      " P_ZCODE# ## ACTUAL PARAMETER# ## ##. (CALL BY VALUE?)

              CHANGING P_ZKNAME.        " ## ### ## ## ## ## ### ##.

  SELECT SINGLE ZKNAME FROM ZEDT04_001

    INTO P_ZKNAME

    WHERE ZCODE = P_ZCODE.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       ##### ## ## ##

*----------------------------------------------------------------------*

*      -->PS_STUDENT  #### ###

*----------------------------------------------------------------------*

*FORM GET_DATA2 USING PS_STUDENT STRUCTURE GS_STUDENT. " #### ## ## ### ##




FORM GET_DATA2 USING PS_STUDENT LIKE GS_STUDENT.      " STRUCTURE ## LIKE ## ##

  SELECT SINGLE ZKNAME FROM ZEDT04_001

    INTO PS_STUDENT-ZKNAME

    WHERE ZCODE = PS_STUDENT-ZCODE.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_DATA3

*&---------------------------------------------------------------------*

*FORM GET_DATA3  USING    PS_STUDENT STRUCTURE GS_STUDENT

*                         PT_STUDENT LIKE GT_STUDENT.   " ### #### ## ## ### ##

*  PS_STUDENT-ZCODE = 'SSU-10'.

*  SELECT SINGLE ZKNAME FROM ZEDT04_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = PS_STUDENT-ZCODE.

*  APPEND PS_STUDENT TO PT_STUDENT.

*

*  PS_STUDENT-ZCODE = 'SSU-11'.

*  SELECT SINGLE ZKNAME FROM ZEDT04_001

*    INTO PS_STUDENT-ZKNAME

*    WHERE ZCODE = PS_STUDENT-ZCODE.

*  APPEND PS_STUDENT TO PT_STUDENT.

*ENDFORM.






" WORK AREA# PS_STUDENT ### LS_STUDENT# ##. TYPE STANDARD TABLE# ### ## ## ### ### ##

FORM GET_DATA3  CHANGING    PT_STUDENT TYPE STANDARD TABLE.

  DATA : LS_STUDENT LIKE GS_STUDENT.

  LS_STUDENT-ZCODE = 'SSU-10'.

  SELECT SINGLE ZKNAME FROM ZEDT04_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.

  APPEND LS_STUDENT TO PT_STUDENT.



  LS_STUDENT-ZCODE = 'SSU-11'.

  SELECT SINGLE ZKNAME FROM ZEDT04_001

    INTO LS_STUDENT-ZKNAME

    WHERE ZCODE = LS_STUDENT-ZCODE.

  APPEND LS_STUDENT TO PT_STUDENT.

ENDFORM.



FORM SUBR1.

  WRITE : / SY-INDEX, '## ####'.

ENDFORM.

FORM SUBR2.

  WRITE : / SY-INDEX, '## ####'.

ENDFORM.