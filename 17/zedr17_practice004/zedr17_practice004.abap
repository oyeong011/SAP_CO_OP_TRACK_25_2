
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_PRACTICE004.



ranges : gr_zcode for  zedt17_001-zcode. " SSU-90 ~ SSU-99



gr_zcode-sign = 'I'.

gr_zcode-option = 'BT'.

gr_zcode-low = 'SSU-90'.

gr_zcode-high = 'SSU-99'.

append gr_zcode.



" ## ## ## (zedt17_001)

data : begin of gs_student.

  include structure
zedt17_001
.

  data : end of gs_student.

data : gt_student like table of gs_student.



" 1) zedt00_001## ## ##

select * from zedt00_001

  into corresponding fields of table gt_student

  where zcode in gr_zcode.



if sy-subrc <> 0.

  write : / '## #### ####'.

  exit.

endif.



" 2) zpernr alpha ## (### 0 ###)

loop at gt_student into gs_student.

  call function 'CONVERSION_EXIT_ALPHA_INPUT'

  exporting

    input = gs_student-zpernr

  importing

    output = gs_student-zpernr.

  modify gt_student from gs_student.

endloop.



" ## LOOP ## ##

SORT gt_student BY zcode zpernr. " ##

DELETE ADJACENT DUPLICATES FROM gt_student

       COMPARING zcode zpernr. " ## ##



" 2) zedt17_001# modify

modify zedt17_001 from table gt_student.



write : / lines( gt_student ), '# ## # insert ##'.