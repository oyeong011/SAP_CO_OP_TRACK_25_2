
*&---------------------------------------------------------------------*

*& Report ZEDR16_019

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_019.






*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

*DATA : gv_pname(20) VALUE 'ZEDR16_018'.

*DATA : gv_formname(20) VALUE 'GET_DATA'.

*

*TRANSLATE gv_pname TO UPPER CASE.

*TRANSLATE gv_formname TO UPPER CASE.

*

*PERFORM (gv_formname) IN PROGRAM (gv_pname) IF FOUND CHANGING gt_student.

*

*LOOP AT  gt_student INTO gs_student.

*

*  WRITE :/ gs_student-zcode, gs_student-zkname.

*ENDLOOP.

*

*DO 2 TIMES.

*  PERFORM sy-index OF subr1 subr2.

*ENDDO.

*

*FORM subr1.

*  WRITE :/ sy-index, '## ####'.

*ENDFORM.

*

*FORM subr2.

*  WRITE :/ sy-index, '## ####'.

*ENDFORM.





*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*DATA : gv_flag.

*

*SELECT SINGLE * FROM zedt16_001

*  INTO gs_student WHERE zcode = 'SSU-01'.

*

*PERFORM delete_data USING gs_student.

*PERFORM insert_data ON COMMIT.

*

*IF gv_flag = 'X'.

*  COMMIT WORK.

*ENDIF.

**&---------------------------------------------------------------------*

**&      Form  DELETE_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**      -->P_GS_STUDENT  text

**----------------------------------------------------------------------*

*FORM delete_data  USING    ps_student LIKE gs_student.

*

*  DELETE zedt16_001 FROM ps_student.

*  IF sy-subrc = 0.

*    gv_flag = 'X'.

*  ENDIF.

*ENDFORM.

**&---------------------------------------------------------------------*

**&      Form  INSERT_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM insert_data .

*  INSERT zedt16_001 FROM gs_student.

*ENDFORM.








DATA : gv_var1 TYPE c LENGTH 10 VALUE '##1',

       gv_var2 TYPE c LENGTH 10 VALUE '##2',

       gv_var3 TYPE c LENGTH 10 VALUE '##3',

       gv_var4 TYPE c LENGTH 10 VALUE '##4'.



WRITE :/ '## #: '.

WRITE :/ gv_var1, gv_var2, gv_var3, gv_var4.

ULINE.



PERFORM test_subroutine USING gv_var1 gv_var3

      CHANGING gv_var2 gv_var4.



WRITE :/ '## #: '.

WRITE :/ gv_var1, gv_var2, gv_var3, gv_var4.




*&---------------------------------------------------------------------*

*&      Form  TEST_SUBROUTINE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_VAR1  text

*      -->P_GV_VAR3  text

*      <--P_GV_VAR2  text

*      <--P_GV_VAR4  text

*----------------------------------------------------------------------*




FORM test_subroutine  USING    p_var1

      VALUE(p_var3)

  CHANGING p_var2

    VALUE(p_var4).



  WRITE :/ '#### ## (## #): '.

  WRITE :/ p_var1, p_var2, p_var3, p_var4.



  p_var1 = '##1'.

  p_var2 = '##2'.

  p_var3 = '##3'.

  p_var4 = '##4'.



  WRITE :/ '#### ## (## #): '.

  WRITE :/ p_var1, p_var2, p_var3, p_var4.

  ULINE.



ENDFORM.