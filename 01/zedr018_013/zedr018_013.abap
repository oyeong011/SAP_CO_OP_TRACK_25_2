
*&---------------------------------------------------------------------*

*& Report ZEDR018_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_013.





data : BEGIN OF gs_student.

  include structure
zedt018_001
.

data : END OF gs_student.

data : gt_student like TABLE OF gs_student.

data : gv_flag.



select SINGLE * from zedt018_001 into gs_student where zcode = 'SSU-01'.



perform delete_data using gs_student.

  PERFORM insert_data on commit.



if gv_flag = 'X'.

  COMMIT WORK.

endif.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_DATA using ps_student like gs_student.

  delete zedt018_001 from ps_student.

  if sy-subrc = 0.

    gv_flag = 'X'.

  endif.



ENDFORM. "subroutine ## #, # ##.



FORM Insert_DATA .

  insert zedt018_001 from gs_student.



ENDFORM. "subroutine ## #, # ##.