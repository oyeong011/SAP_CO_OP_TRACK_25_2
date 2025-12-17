
*&---------------------------------------------------------------------*

*& Report ZEDR17_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_004.






******InternalTable ## ******



*** ##



*data : begin of gs_student,

*  zcode(10),

*  zkname(10),

*  zename(10),

*END OF gs_student.

*

*data : gt_student like table of gs_student.

*

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'LEE'.

*append gs_student to gt_student.

*

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*append gs_student to gt_student.

*

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SONG'.

*append gs_student to gt_student.

**break-point. " ## ### ## ####

*

*gs_student-zcode = 'SSU-04'.

*gs_student-zkname = '###'.

*gs_student-zename = 'LEE'.

*append gs_student to gt_student.

*

**sort gt_student. " #### ### ### #

**sort gt_student ascending. " ## ## ##

**sort gt_student descending. " #### ##

**sort gt_student by zkname. " zkname ### #### #### ##

**sort gt_student by zkname descending. " zkname ### #### #### ##

**sort gt_student by zkname zcode descending. " zkname ## #### ####, zcode #### #### ##

*sort gt_student by zkname descending zcode descending. " zkname ## #### ####, zcode #### #### ##

**break-point. " ##### ## ### #### ##



*** LINES: ####### #### ## ## # ##

*data : begin of gs_line,

*  col1 type c,

*  end of gs_line.

*

*data : gt_line like table of gs_line.

*data : gv_line type i. " ### #### ## ####

*

*gs_line-col1 = sy-index. " loop## sy-index ## #### ####. #### loop #### 0# ###. ## loop### 1# ###?

*append gs_line to gt_line.

**break-point.

*

*gs_line-col1 = '2'.

*append gs_line to gt_line.

**break-point.

*

*gs_line-col1 = '3'.

*append gs_line to gt_line.

**break-point.

*

*describe table gt_line lines gv_line. " gt_line### ####### ### # ### ## gv_line### ##

*

*write : gv_line.





*** INSERT

*data : begin of gs_student,

*  zcode(10),

*  zkname(10),

*  zename(10),

*END OF gs_student.

*

*data : gt_student like table of gs_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'LEE'.

**append gs_student to gt_student. " append# ## #### ###

*insert gs_student into table gt_student." insert# ### ### #### ### # ##

*

*clear : gs_student.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'GANG'.

**append gs_student to gt_student. " append# ## #### ###

*insert gs_student into table gt_student." insert# ### ### #### ### # ##

*

*clear : gs_student.

*gs_student-zcode = 'SSU-32'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SONG'.

**append gs_student to gt_student. " append# ## #### ###

*insert gs_student into gt_student index 2." insert# ### ### #### ### # ##

*break-point.



*** COLLECT

**## ## ## collect ## # append# ##.

**## #(char #### ## ## ) ## ## ###

*data : begin of gs_student,

*  zcode(10),

*  zkname(10),

*  zename(10),

*  zsum type i,

*END OF gs_student.

*

*data : gt_student like table of gs_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'LEE'.

*gs_student-zsum = '10000'.

*collect gs_student into gt_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'LEE'.

*gs_student-zsum = '10000'.

*collect gs_student into gt_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-32'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SONG'.

*gs_student-zsum = '10000'.

*collect gs_student into gt_student.

*break-point.



******InternalTable ##_IF#******



*** IF#

*data : begin of gs_student,

*  zpernr like zedt17_001-zpernr, "####

*  zcode like zedt17_001-zcode, "####

*  zkname like zedt17_001-zkname, "##

*  zename like zedt17_001-zename, "####

*  zgender like zedt17_001-zgender, "##

*  zgname(4), "####

*  ztel like zedt17_001-ztel, "####

*end of gs_student.

*

*data : gt_student like table of  gs_student.

*

*clear : gs_student, gt_student.

*

*gs_student-zpernr = '0000000001'.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

**gs_student-zgender = 'F'. " # ## ## #### ##### body# # #

**gs_student-zgender = 'A'. " M# F# #### '##' ##

*gs_student-ztel = '01011112222'.

*

*** ## ### ## zgname ### '##'## ##

**if gs_student-zgender = 'M'.

**  gs_student-zgname = '##'. " ### # ##

**endif.

*

*** ## ### ## zgname ### '##'## ##, ### ## ## '##'## ##

**if gs_student-zgender = 'M'.

**  gs_student-zgname = '##'.

**else.

**  gs_student-zgname = '##'.

**endif.

*

*** ## ### ## zgname ### '##'## ##, ### ## '##' ##, # # ## ## '##' ##

**if gs_student-zgender = 'M'.

**  gs_student-zgname = '##'.

**elseif gs_student-zgender = 'F'.

**  gs_student-zgname = '##'.

**else.

**  gs_student-zgname = '##'.

**endif.

*

*** ### ### ### #### ### zgname ### '##' ##

**if ( gs_student-zgender = 'M' ) and ( gs_student-zkname = '###' ).

**  gs_student-zgname = '##'.

**endif.

*

** # ## # ### #### zgname ### '##' ##

*if ( gs_student-zgender = 'M' ) or ( gs_student-zkname = '###' ).

*  gs_student-zgname = '##'.

*endif.

*

*append gs_student to gt_student.

*break-point.

*

*clear : gs_student.





*** ### ##






data : gv_num1 type i value 100,

       gv_num2 type i value 120,

       gv_num3 type i value 110.





write : / '**1#-IF## WRITE# ##'.

write : / gv_num1, / gv_num2.

if ( gv_num1 < gv_num2 ).

  write : / 'gv_num1# gv_num2## ####.'.

endif.

write : / '-----------------------------'.



write : / '**2#-IF## WRITE# ##'.

write : / gv_num1, / gv_num2, / gv_num3.

if ( gv_num1 < gv_num2 ) and ( gv_num1 < gv_num3 ).

  write : / 'gv_num1# gv_num2, gv_num3## ####.'.

endif.

write : / '-----------------------------'.



write : / '**3#-ELSE## WRITE# ##'.

write : / gv_num1, / gv_num2.

if ( gv_num2 < gv_num1 ).

  write : / 'gv_num2# gv_num1## ####.'.

else.

  write : / 'gv_num2# gv_num1## ###.'.

endif.

write : / '-----------------------------'.



write : / '**4#-ELSE## WRITE# ##'.

if ( gv_num1 > gv_num2 ).

  if ( gv_num1 > gv_num3 ).

    write : / 'gv_num1#', gv_num1, '## # ####.'.

  else.

    write : / 'gv_num3#', gv_num3, '## # ####.'.

  endif.

elseif ( gv_num2 > gv_num3 ).

  write : / 'gv_num2#', gv_num2, '## # ####.'.

else.

  write : / 'gv_num3#', gv_num3, '## # ####.'.

endif.

write : / '-----------------------------'.