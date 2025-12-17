
*&---------------------------------------------------------------------*

*& Report ZEDR17_008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_008.






* inter table# ## db #### ## # update, ### collect



**********##**************

* database table ## - insert

* 1. single line

* insert into zedt17_001 values gs_student.



* 2. serveral line

* insert zedt17_001 from table gt_student accepting duplicate keys. " key### ## ## # ####, #### ## ##



* database table ## - update

* 1. single line

* update zedt17_001 from gs_student.

* 2. serveral line

* update zedt17_001 from table gt_student.

* 3. upate set - ## ## #

* update zedt17_001 set zename = 'SSOL'

* where zcode = 'SSU-27'.



* database table ## - delete

* 1. single line

* delete zedt17_001 from gs_student.

* 2. serveral line

* *delete from zedt17_001 where ztel = '01000002222'. "### ## ## # ##

* *delete zedt17_001 from table gt_student. " ## st# ### ### # ##



* database table ## - modify

* 1. single line

* modify zedt17_001 from gs_student.

* 2. serveral line

* modify zedt17_001 from table gt_student.



****************##****************



* database table ## - insert

* 1. single line

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.



*gs_student-mandt = sy-mandt.

*gs_student-zcode = 'SSU-25'.

*gs_student-zpernr = '0000000025'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DO'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000001111'.

*

*insert into zedt17_001 values gs_student.

*

*if sy-subrc = 0.

*  write : / '##'.

*else.

*  write : / '##'.

*endif.



* 2. serveral line

*clear : gs_student, gt_student.

*gs_student-zcode = 'SSU-26'.

*gs_student-zpernr = '0000000026'.

*gs_student-zkname = '###'.

*gs_student-zename = 'FA'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000002626'.

*append gs_student to gt_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-27'.

*gs_student-zpernr = '0000000027'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SOL'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000002727'.

*append gs_student to gt_student.

*

**insert zedt17_001 from table gt_student. " key data ### ## dump error

*insert zedt17_001 from table gt_student accepting duplicate keys. " key### ## ## # ####, #### ## ##



* database table ## - update

* 1. single line

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

*gs_student-zcode = 'SSU-26'.

*gs_student-zpernr = '0000000026'.

*gs_student-zkname = '###'.

*gs_student-zename = 'FAA'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000002626'.

*

*update zedt17_001 from gs_student.

*

*if sy-subrc = 0.

*  write : / '##### ##'.

*else.

*  write : / '##### ##'.

*endif.



* 2. serveral line

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

*clear : gs_student, gt_student.

*gs_student-zcode = 'SSU-26'.

*gs_student-zpernr = '0000000026'.

*gs_student-zkname = '###'.

*gs_student-zename = 'FA'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01000002626'.

*append gs_student to gt_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-27'.

*gs_student-zpernr = '0000000027'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SOL'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000002727'.

*append gs_student to gt_student.

*

*update zedt17_001 from table gt_student.

*

*if sy-subrc = 0.

*  write : / '##### ##'.

*else.

*  write : / '##### ##'.

*endif.



* 3. upate set - ## ## #

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

*update zedt17_001 set zename = 'SSOL'

*where zcode = 'SSU-27'.

*

*if sy-subrc = 0.

*  write : / '##### ##'.

*else.

*  write : / '##### ##'.

*endif.



* database table ## - delete

* 1. single line

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

*gs_student-zcode = 'SSU-27'.

*gs_student-zpernr = '0000000027'.

*

*delete zedt17_001 from gs_student.

*

*if sy-subrc = 0.

*  write : / '##### ##'.

*else.

*  write : / '##### ##'.

*endif.



* 2. serveral line

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

**

** 1) #### # ##

**delete from zedt17_001 where ztel = '01000002222'. "### ## ## # ##

*

** 2) ## # #### ## (## st# ##)

*clear : gs_student, gt_student.

*gs_student-zcode = 'SSU-26'.

*gs_student-zpernr = '0000000026'.

*append gs_student to gt_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-27'.

*gs_student-zpernr = '0000000027'.

*append gs_student to gt_student.

*

*delete zedt17_001 from table gt_student.



*if sy-subrc = 0.

*  write : / '##### ##'.

*else.

*  write : / '##### ##'.

*endif.



* database table ## - modify : update(## ## ### ###)  + insert(## ## ### ###)

* 1. single line

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

*gs_student-zcode = 'SSU-27'.

*gs_student-zpernr = '0000000027'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SOLL'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01000002727'.

*

*modify zedt17_001 from gs_student.

*

*if sy-subrc = 0.

*  write : / '##### ##'.

*else.

*  write : / '##### ##'.

*endif.



* 2. serveral line




data : begin of gs_student.

  include structure
zedt17_001
.

  data : end of gs_student.

data : gt_student like table of gs_student.



clear : gs_student, gt_student.

gs_student-zcode = 'SSU-26'.

gs_student-zpernr = '0000000027'.

gs_student-zkname = '###'.

gs_student-zename = 'FA'.

gs_student-zgender = 'M'.

gs_student-ztel = '01000002626'.



clear : gs_student.

gs_student-zcode = 'SSU-27'.

gs_student-zpernr = '0000000027'.

gs_student-zkname = '###'.

gs_student-zename = 'SOLL'.

gs_student-zgender = 'M'.

gs_student-ztel = '01000002727'.



modify zedt17_001 from table gt_student.



if sy-subrc = 0.

  write : / '##### ##'.

else.

  write : / '##### ##'.

endif.