
*&---------------------------------------------------------------------*

*& Report ZEDR018_006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_006.



data : BEGIN OF gs_student,

  zcode  like zedt018_001-zcode,

  zkname like zedt018_001-zkname,

  zename like zedt018_001-zename,

  zpernr like zedt018_001-zpernr,

  zgname type c length 4,

  zgender like zedt018_001-zgender,

  ztel like zedt018_001-ztel,

end of gs_student.

"#### ## ## #### key ##.

data : gt_student like table of gs_student.



clear : gs_student, gt_student.



gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zpernr = '0000000001'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zpernr = '0000000001'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



CLEAR : gs_student.

gs_student-zcode = 'SSU-03'.

gs_student-zkname = '###'.

gs_student-zename = 'SON'.

gs_student-zpernr = '0000000003'.

gs_student-zgender = 'F'.

gs_student-ztel = '01033334444'.

append gs_student to gt_student.



MODIFY gt_student from value #( zgname = '##')

  TRANSPORTING zgname

  where zgender = 'F'.



BREAK-POINT.