
*&---------------------------------------------------------------------*

*& Report ZEDR17_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_012.






* 2. External ##

** zedr17_011# ### subroutine "get_data"# external #####

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

** gv #### ### perform ## lv# #### # ## ##

**data : gv_zcode like zedt17_001-zcode.

**data : gv_zkname like zedt17_001-zkname.

*

*perform get_data(zedr17_011) if found changing gt_student.

*

*loop at gt_student into gs_student.

*  write : / gs_student-zcode, gs_student-zkname.

*endloop.





* 3. Dynamic ##

** zedr17_011# ### subroutine "get_data"# external #####




data : begin of gs_student.

  include structure
zedt17_001
.

  data : end of gs_student.

data : gt_student like table of gs_student.



data : gv_pname(20) value 'zedr17_011'. " subroutine ### ## #### ##

data : gv_formname(20) value 'get_data'. " subroutine ##



translate gv_pname to upper case. " #### ## # #### ### #### ### #### ##

translate gv_formname to upper case.



perform (gv_formname) in program (gv_pname) if found changing gt_student.



loop at gt_student into gs_student.

  write : / gs_student-zcode, gs_student-zkname.

endloop.