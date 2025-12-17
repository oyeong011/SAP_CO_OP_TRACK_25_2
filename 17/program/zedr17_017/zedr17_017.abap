
*&---------------------------------------------------------------------*

*& Report ZEDR17_017

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_017.






*** assign ### ## ## ### #######

*" ## ##

*data : gv_var type c value 'A'. " gv_var = A

*

*" ######

*" ### # ##### ##### ## ### ##### ### # ## #### ###

*field-symbols <fs> type c. " <fs> ### ##

*

*" #### ### ##### ##

*assign gv_var to <fs>. " <fs> -> gv_var

*

*" #### # ##

*<fs> = 'B'. " B -> gv_var

*

*write : / gv_var.



*&---------------------------------------------------------------------*



*** generic type field symbol (####)

*data : gv_var type c value 'A'.

*field-symbols <fs> type any. " any# ## generic ####

*assign gv_var to <fs>. " #### (### #### ##)

*<fs> = 'B'.

*write : / gv_var.



*&---------------------------------------------------------------------*



*** ####

*data : gv_1 type c value 'A'.

*data : gv_2 type c value 'B'.

*data : gv_3 type c value 'C'.

*

*data : gv_fname(10).

*data : gv_index type n.

*

*field-symbols <fs1> type any. " any# ## generic ####

*do 3 times.

*  clear gv_fname.

*  gv_fname = 'GV_'.

*  gv_index = sy-index.

*  concatenate gv_fname gv_index into gv_fname.

*  assign (gv_fname) to <fs1>.

*  write : / gv_fname, ':', <fs1>.

*enddo.



*&---------------------------------------------------------------------*



*** ### assign

*data : begin of gs_sum,

*  mon01 type dmbtr value '10.00',

*  mon02 type dmbtr value '20.00',

*  mon03 type dmbtr value '30.00',

*  mon04 type dmbtr value '40.00',

*  mon05 type dmbtr value '50.00',

*  mon06 type dmbtr value '0.00',

*end of gs_sum.

*data : zindex(2). " 01~06 ## 2## #### ### ### ##

*data : zmon(6). " mon01~mon06 ## ##

*

*field-symbols : <fs1> like gs_sum, " gs_sum ### ### ### ##

*               <fs2> type any. " ## ### ## #### any(#### ## #### ###)

*assign gs_sum to <fs1>. " gs_sum ### ### <fs1># ###

*

*do 6 times. " 6# ### mon01~mon06 ### ### ##

*  zindex = sy-index. " ## ## ###(1~6)

*  concatenate 'MON0' zindex into zmon. " mon0 + 1 = mon01# zmon# #### #### ##

*  assign component zmon of structure <fs1> to <fs2>. " ### <fs1> ###, ### zmon# ##### <fs2># ###

*  write : / <fs2>.

*enddo.



*&---------------------------------------------------------------------*



** ###### assign: ## ### type any table# ## ##




data : begin of gs_student,

  zcode like zedt17_001-zcode,

  zkname like zedt17_001-zkname,

  zename like zedt17_001-zename,

  zmemo(10),

  end of gs_student.

data : gt_student like table of gs_student.

data : gv_zcode(10) value 'ZCODE'. " ## # ## ###



" ### ## ##(zcode, zkname, zename)# ##

select * from zedt17_001 into corresponding fields of table gt_student.



field-symbols <fs> type any table.

assign gt_student to <fs>.






** 1) ## ## : into gs_student

*" ### #### generic ## ### ###. <fs># ## ### any table# ## ## <fs># ## ##### ## ##

*" read table: ## # ## ##.

*" (gv_zcode)# #### ### 'ZCODE'# ## # ##### #### ##.

*" into gs_student: ## ## ## ### gs_student# ##

*" 2)3)# ## ## ## ###. #### ## ###

*read table <fs> with key (gv_zcode) = 'SSU-01' into gs_student.

*write : / gs_student-zcode.

*write : / gs_student-zkname.

*write : / gs_student-zename.



** 2) ## ##: assigning <fs_gs_student> -> ## ## ## # ### ##### ##,## #### ##

*field-symbols: <fs_gs_student> type any.

*read table <fs> with key (gv_zcode) = 'SSU-17' assigning <fs_gs_student>.

*write <fs_gs_student>. " ## ## ## ## (#: <fs_gs_stdeut>-zcode)





*# #### ### ### ## #### ## # ##?

*: modify# ### modify# #### ###.

*-> ## ## ### ###, ## ### ## modify### #### ### # ##

** 3) LOOP ## ## ## ##




" assigning## ###### <fs_t># # ### ## ## ##

" <fs_t># #### ### ## ### <fs_t>-zcode, <fs_t>-zename # ## ## ##

" <fs_t> ### ## ### ###(gt_student) ## ## ##

" loop ### ## ## ## #### ## ##

loop at gt_student assigning field-symbol(<fs_t>).

  if <fs_t>-zename = 'KANG'.

    <fs_t>-zmemo = '####'.

  endif.

endloop.