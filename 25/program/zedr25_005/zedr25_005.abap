
*&---------------------------------------------------------------------*

*& Report ZEDR25_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_005.





"SORT

DATA : BEGIN OF gs_studentS1,

  ZCODE type C length 10,

  ZKNAME type C length 10,

  ZENAME type C length 10,

end of gs_studentS1.



DATA : gt_studentS1 like table of gs_studentS1.



gs_studentS1-ZCODE = 'ssu-02'.

gs_studentS1-ZKNAME = '###'.

gs_studentS1-ZENAME = 'Lee'.

APPEND gs_studentS1 to gt_studentS1.



gs_studentS1-ZCODE = 'ssu-01'.

gs_studentS1-ZKNAME = '###'.

gs_studentS1-ZENAME = 'DONG'.

APPEND gs_studentS1 to gt_studentS1.



gs_studentS1-ZCODE = 'ssu-03'.

gs_studentS1-ZKNAME = '###'.

gs_studentS1-ZENAME = 'SONG'.

APPEND gs_studentS1 to gt_studentS1.



" ### ### # ### KEY ### SORT

" SORT gt_studentS1.



" #### ##

" sort gt_studentS1 ascending.



"#### ##

"sort gt_studentS1 descending.



"kname## ####

" sort gt_studentS1 by zkname.



"kname## ####

" sort gt_studentS1 by zkname descending.



" lines : ####### #### ## ## # ##





DATA : BEGIN OF gs_line,

  COL1 type C,

  end of gs_line.



DATA : gt_line like table of gs_line.



DATA : gv_line type i.



gs_line-COL1 = SY-INDEX.

write : / gs_line-COL1.

append gs_line to gt_line.



gs_line-COL1 = '2'.

append gs_line to gt_line.



gs_line-COL1 = '3'.

append gs_line to gt_line.



describe table gt_line lines gv_line.



write : / gv_line.





"DATA : BEGIN OF gs_studentS2,

 " ZCODE type C length 10,

  "ZKNAME type C length 10,

  "ZENAME type C length 10,

"end of gs_studentS2.



"DATA : gt_studentS2 like table of gs_studentS2.



"clear : gs_studentS2.

"gs_studentS2-ZCODE = 'ssu-02'.

"gs_studentS2-ZKNAME = '###'.

"gs_studentS2-ZENAME = 'Lee'.

"insert gs_studentS2 into table gt_studentS2.



"clear : gs_studentS2.

"gs_studentS2-ZCODE = 'ssu-01'.

"gs_studentS2-ZKNAME = '###'.

"gs_studentS2-ZENAME = 'DONG'.

"insert gs_studentS2 into table gt_studentS2.



"clear : gs_studentS2.

"gs_studentS2-ZCODE = 'ssu-03'.

"gs_studentS2-ZKNAME = '###'.

"gs_studentS2-ZENAME = 'SONG'.

"insert gs_studentS2 into table gt_studentS2.

"insert gs_studentS2 into gt_studentS2 index 2.



DATA : BEGIN OF gs_studentS2,

  ZCODE type C length 10,

  ZKNAME type C length 10,

  ZENAME type C length 10,

  ZSUM type I,

end of gs_studentS2.



DATA : gt_studentS2 like table of gs_studentS2.



clear : gs_studentS2.

gs_studentS2-ZCODE = 'ssu-02'.

gs_studentS2-ZKNAME = '###'.

gs_studentS2-ZENAME = 'Lee'.

gs_studentS2-ZSUM = '1000'.

collect gs_studentS2 into gt_studentS2.



clear : gs_studentS2.

"gs_studentS2-ZCODE = 'ssu-01'.

"gs_studentS2-ZKNAME = '###'.

"gs_studentS2-ZENAME = 'DONG'.

"gs_studentS2-ZSUM = '1000'.

"collect gs_studentS2 into gt_studentS2.



clear : gs_studentS2.

gs_studentS2-ZCODE = 'ssu-02'.

gs_studentS2-ZKNAME = '###'.

gs_studentS2-ZENAME = 'Lee'.

gs_studentS2-ZSUM = '1000'.

collect gs_studentS2 into gt_studentS2.



clear : gs_studentS2.

gs_studentS2-ZCODE = 'ssu-03'.

gs_studentS2-ZKNAME = '###'.

gs_studentS2-ZENAME = 'SONG'.

gs_studentS2-ZSUM = '1000'.

collect gs_studentS2 into gt_studentS2.



break-point.



"IF#

DATA : BEGIN OF gs_student,

  ZPERNR like ZEDT25_001-ZPERNR,

   ZCODE like ZEDT25_001-ZCODE,

   ZKNAME like ZEDT25_001-ZKNAME,

   ZENAME like ZEDT25_001-ZENAME,

   ZGENDER like ZEDT25_001-ZGENDER,

  ZGNAME type C length 4,

  ZTEL like ZEDT25_001-ZTEL,

end of gs_student.



DATA : gt_student like table of gs_student.



clear : gs_student, gt_student.



gs_student-ZPERNR = '00000001'.

gs_student-ZCODE = 'ssu-02'.

gs_student-ZKNAME = '###'.

gs_student-ZENAME = 'Lee'.

gs_student-ZGENDER = 'M'.

"gs_student-ZGENDER = 'F'.

gs_student-ZTEL = '01037374848'.






* if gs_student-ZGENDER = 'M'.

*  gs_student-ZGNAME = '##'.

* elseif gs_student-ZGENDER = 'F'.

*  gs_student-ZGNAME = '##'.

* else.

*  gs_student-ZGNAME = '##'.

*endif.






" OR

IF gs_student-zgender = 'M' AND gs_student-zkname = '###'.

  gs_student-zgname = '##'.

ENDIF.





APPEND gs_student to gt_student.



clear gs_student.



write : / '##'.



DATA: gv_num1 TYPE i,

      gv_num2 TYPE i,

      gv_num3 TYPE i,

      GV_LARGEST TYPE I.



gv_num1 = 100.

gv_num2 = 120.

gv_num3 = 110.



if  gv_num1 < gv_num2.

  write : / '1# if## write# ##'.

  write : / gv_num1.

  write : / gv_num2.

  write : / 'gv_num1# gv_num2## ####'.

elseif gv_num1 > gv_num2.

  write : / '1# if## write# ##'.

  write : / gv_num1.

  write : / gv_num2.

  write : / 'gv_num1# gv_num2## ###'.

elseif gv_num1 = gv_num2.

  write : / '1# if## write# ##'.

  write : / gv_num1.

  write : / gv_num2.

  write : / 'gv_num1# gv_num2# ####'.

endif.



if ( gv_num1 < gv_num2 ) and ( gv_num1 < gv_num3 ).

  write : / '2# if## write# ##'.

  write : / gv_num1.

  write : / gv_num2.

  write : / gv_num3.

  write : / 'gv_num1# gv_num2, gv_num3## ####'.

endif.



if gv_num1 < gv_num2.

  write : / '3# if## write# ##'.

  write : / gv_num1.

  write : / gv_num2.

  write : / 'gv_num2# gv_num1## ###'.

endif.





IF ( GV_NUM1 > GV_NUM2 ) AND ( GV_NUM1 > GV_NUM3 ).

  GV_LARGEST = GV_NUM1.



  write : / '4# num1, num2, num3 ## ### #### write# ##'.

  WRITE :/ 'GV_NUM1#', GV_LARGEST, '## #####.'.

ELSEIF ( GV_NUM2 > GV_NUM1 ) AND ( GV_NUM2 > GV_NUM3 ).

  GV_LARGEST = GV_NUM2.



  write : / '4# num1, num2, num3 ## ### #### write# ##'.

  WRITE :/ 'GV_NUM2#', GV_LARGEST, '## #####.'.

ELSE.

  GV_LARGEST = GV_NUM3.



  write : / '4# num1, num2, num3 ## ### #### write# ##'.

  WRITE :/ 'GV_NUM3#', GV_LARGEST, '## #####.'.

ENDIF.