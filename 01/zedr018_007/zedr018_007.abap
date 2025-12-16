
*&---------------------------------------------------------------------*

*& Report ZEDR018_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_007.



data : BEGIN OF gs_student,

  zcode  like zedt018_001-zcode,

  zkname like zedt018_001-zkname,

  zename like zedt018_001-zename,

  zpernr like zedt018_001-zpernr,

  zgname type c length 4,

  zgender like zedt018_001-zgender,

  ztel like zedt018_001-ztel,

end of gs_student.



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

gs_student-zgender = 'F'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zpernr = '0000000001'.

gs_student-zgender = 'A'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-02'.

gs_student-zkname = '###'.

gs_student-zename = 'HOON'.

gs_student-zpernr = '0000000002'.

gs_student-zgender = 'M'.

gs_student-ztel = '01022223333'.

append gs_student to gt_student.



CLEAR : gs_student.

gs_student-zcode = 'SSU-03'.

gs_student-zkname = '###'.

gs_student-zename = 'SON'.

gs_student-zpernr = '0000000003'.

gs_student-zgender = 'F'.

gs_student-ztel = '01033334444'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zpernr = '0000000001'.

gs_student-zgender = 'F'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student. "loop ## #, header clear.

sort gt_student by zcode zkname zename zgender.



BREAK-POINT.



loop at gt_student into gs_student.

  gs_student-zgname = '####'.



  at end of zename.

    gs_student-zgname = '####'.

  endat.



  clear : gs_student.

endloop.