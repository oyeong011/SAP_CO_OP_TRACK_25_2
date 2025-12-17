
*&---------------------------------------------------------------------*

*& Report ZEDR018_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_004.



data : BEGIN OF gt_student occurs 0,

  zcode type c LENGTH 10,

  zkname type c LENGTH 10,

  zename type c LENGTH 10,

  zclass type c,

end of gt_student.



data : BEGIN OF gt_student2 occurs 0,

  zcode type c LENGTH 10,

  zkname type c LENGTH 10,

  zename type c LENGTH 10,

  zclass type c,

end of gt_student2.





gt_student-zcode = 'SSU-01'.

gt_student-zkname = '###'.

gt_student-zename = 'DONG'.





append gt_student to gt_student.



move gt_student[] to gt_student2[].



break-point.