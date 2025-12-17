
*&---------------------------------------------------------------------*

*& Report ZEDR07_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_011.



DATA : BEGIN OF gs_student.

  include structure
zedt07_001
.

DATA : END OF gs_student.



DATA : gt_student LIKE TABLE OF gs_student.



PERFORM get_data.




**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

**

*************************************************************************






FORM GET_DATA .



 WRITE :/ 'PERFORM TEST'.



ENDFORM.






************************************************************************



*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*gv_zcode = 'SSU-01'. "perform ## # # ##

*

*PERFORM get_data USING gv_zcode gv_zkname.

*

*WRITE :/ gv_zcode.

*WRITE :/ gv_zkname.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*

*FORM get_data USING p_zcode p_zkname.

*

* SELECT SINGLE zkname FROM zedt07_001

* INTO p_zkname

* WHERE zcode = p_zcode.

*

*ENDFORM.



************************************************************************



*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*PERFORM get_data USING gv_zcode gv_zkname. "## ### # ### perform# ###

*

*WRITE :/ gv_zcode.

*WRITE :/ gv_zkname.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*

*FORM get_data USING p_zcode p_zkname.

*

*  DATA : lv_zcode LIKE zedt07_001-zcode. "lv ## ### ### ####.

*  lv_zcode = 'SSU-01'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO p_zkname

*  WHERE zcode = lv_zcode.

*

*  p_zcode = lv_zcode.

*

*ENDFORM.



************************************************************************



*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*gv_zcode = 'SSU-02'. "## ### ## ##

*

*PERFORM get_data USING gv_zcode gv_zkname. "perform# ###

*

*WRITE :/ gv_zcode. "### SSU-01# ## ### ##.

*WRITE :/ gv_zkname.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*

*FORM get_data USING p_zcode p_zkname.

*

*  DATA : lv_zcode LIKE zedt07_001-zcode. "lv ## ### ###?

*  lv_zcode = 'SSU-01'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO p_zkname

*  WHERE zcode = lv_zcode.

*

*  p_zcode = lv_zcode.

*

*ENDFORM.



************************************************************************



*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*gv_zcode = 'SSU-02'.

*

*PERFORM get_data USING gv_zcode gv_zkname.

*

*WRITE :/ gv_zcode. "### SSU-01# ## ### ##.

*WRITE :/ gv_zkname.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data USING VALUE(p_zcode) p_zkname. "p_zcode = ssu-01# #### gv_zcode# ## ###

*  "using value# #### ##.

*

*  DATA : lv_zcode LIKE zedt07_001-zcode.

*  lv_zcode = 'SSU-01'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO p_zkname

*  WHERE zcode = lv_zcode.

*

*  p_zcode = lv_zcode.

*

*ENDFORM.



************************************************************************



*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*gv_zcode = 'SSU-01'.

*

*PERFORM get_data USING gv_zcode CHANGING gv_zkname. "changing # #### #### ##

*

*WRITE :/ gv_zcode.

*WRITE :/ gv_zkname.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data USING p_zcode CHANGING p_zkname.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO p_zkname

*  WHERE zcode = p_zcode.

*

*ENDFORM.



************************************************************************



*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*gv_zcode = 'SSU-01'.

*

*PERFORM get_data USING gv_zcode CHANGING gv_zkname. "changing # #### #### ##

*

*WRITE :/ gv_zcode.

*WRITE :/ gv_zkname. "### test# ## #

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data USING p_zcode CHANGING VALUE(p_zkname).

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO p_zkname

*  WHERE zcode = p_zcode.

*

*  p_zkname = 'TEST'.

*

*ENDFORM.



************************************************************************



*DATA : gv_zcode LIKE zedt07_001-zcode.

*DATA : gv_zkname LIKE zedt07_001-zkname.

*

*gv_zcode = 'SSU-01'.

*

*PERFORM get_data USING gv_zcode CHANGING gv_zkname. "changing # #### #### ##

*

*WRITE :/ gv_zcode.

*WRITE :/ gv_zkname.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data USING p_zcode TYPE c

*              CHANGING p_zkname TYPE c. "##### ### ### # ##.

*  "FORM get_data USING p_zcode LIKE zedt07_001-zcode

*                "CHANGING p_zkname LIKE zedt07_001-zkname.

*

*  "## # ##? ### ### ##### ## # ### #### ### ## ##

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO p_zkname

*  WHERE zcode = p_zcode.

*

*ENDFORM.



************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*DATA : END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-01'.

*

*PERFORM get_data USING gs_student.

*

*WRITE :/ gs_student-zcode.

*WRITE :/ gs_student-zkname.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data USING ps_student STRUCTURE gs_student. "### ## ### ## ##

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO ps_student-zkname

*  WHERE zcode = ps_student-zcode.

*

*ENDFORM.



************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*DATA : END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-01'.

*

*PERFORM get_data USING gs_student gt_student.

*

*LOOP AT gt_student INTO gs_student.

*  WRITE :/ gs_student-zcode, gs_student-zkname.

*ENDLOOP.

*

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data USING ps_student STRUCTURE gs_student "STRUCTURE # # ## LIKE# ## ##.

*                    pt_student LIKE gt_student.

*

*  ps_student-zcode = 'SSU-01'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO ps_student-zkname

*  WHERE zcode = ps_student-zcode.

*  APPEND ps_student TO pt_student.

*

*  ps_student-zcode = 'SSU-02'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO ps_student-zkname

*  WHERE zcode = ps_student-zcode.

*  APPEND ps_student TO pt_student.

*

*ENDFORM.



************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*DATA : END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-01'.

*

*PERFORM get_data USING gt_student.

*

*LOOP AT gt_student INTO gs_student.

*  WRITE :/ gs_student-zcode, gs_student-zkname.

*ENDLOOP.

*

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data USING pt_student TYPE STANDARD TABLE. "### ## #### ### ## ##.

*

*  DATA : ls_student LIKE gs_student.

*

*  ls_student-zcode = 'SSU-01'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO ls_student-zkname

*  WHERE zcode = ls_student-zcode.

*  APPEND ls_student TO pt_student.

*

*  ls_student-zcode = 'SSU-02'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO ls_student-zkname

*  WHERE zcode = ls_student-zcode.

*  APPEND ls_student TO pt_student.

*

*ENDFORM.



************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*DATA : END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*

*gs_student-zcode = 'SSU-01'.

*

*PERFORM get_data CHANGING gt_student.

*

*LOOP AT gt_student INTO gs_student.

*  WRITE :/ gs_student-zcode, gs_student-zkname.

*ENDLOOP.

*

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p_gv_zcode        text

**  <--  p_gv_zkname        text

**----------------------------------------------------------------------*

*

*FORM get_data CHANGING pt_student LIKE gt_student. "##### perform## #####

*  "## ###### external ### ####.

*

*  DATA : ls_student LIKE gs_student.

*

*  ls_student-zcode = 'SSU-01'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO ls_student-zkname

*  WHERE zcode = ls_student-zcode.

*  APPEND ls_student TO pt_student.

*

*  ls_student-zcode = 'SSU-02'.

*

*  SELECT SINGLE zkname FROM zedt07_001

*  INTO ls_student-zkname

*  WHERE zcode = ls_student-zcode.

*  APPEND ls_student TO pt_student.

*

*ENDFORM.



************************************************************************



*DATA : BEGIN OF gs_student.

*  INCLUDE TYPE zedt07_001.

*DATA : END OF gs_student.

*

*DATA : gt_student LIKE TABLE OF gs_student.

*DATA : gv_flag.

*

*SELECT SINGLE * FROM zedt07_001

*  INTO gs_student WHERE zcode = 'SSU-01'.

*

*PERFORM delete_data USING gs_student.

*"PERFORM insert_data ON COMMIT.

*

*IF gv_flag = 'X'.

*  COMMIT WORK.

*ENDIF.

*

*FORM delete_data USING ps_student LIKE gs_student.

*

*  DELETE zedt07_001 FROM ps_student.

*  IF sy-subrc = 0.

*    gv_flag ='X'.

*  ENDIF.

*ENDFORM.



*FORM insert_data.

*  INSERT zedt07_001 FROM gs_student.

*ENDFORM.