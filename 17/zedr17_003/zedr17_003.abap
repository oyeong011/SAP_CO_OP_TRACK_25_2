
*&---------------------------------------------------------------------*

*& Report ZEDR17_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_003.




* [Internal Table ##]






data : gs_zedt17 type zedt17_001. " structure ##

data : gt_zedt17 type table of zedt17_001. " internal table ##






* header# ### ##

*gs_zedt17-zcode = 'SSU-01'.

*gs_zedt17-zpernr = '0000000001'.

*gs_zedt17-zkname = '###'.

*gs_zedt17-zename = 'DONG'.

*gs_zedt17-zgender = 'M'.

*gs_zedt17-ztel = '01011112222'.

**

**break-point. " header# ### ### # ## ##

*

*append gs_zedt17 to gt_zedt17. " #### #### inter table# body# ##

*

**break-point. " body# ### ### # ## ##

*

** header# ### ##

*gs_zedt17-zcode = 'SSU-02'.

*gs_zedt17-zpernr = '00000000012'.

*gs_zedt17-zkname = '##'.

*gs_zedt17-zename = 'JENNY'.

*gs_zedt17-zgender = 'F'.

*gs_zedt17-ztel = '01022223333'.

*

**break-point. " header# ### ### # ## ##

*

*append gs_zedt17 to gt_zedt17.

*

*break-point. " body# ### ### # ## ##



**### header line ### ## ##. ## # ###.

**### ## header line ## internal table## ###

**####### ### ###(### ## ) # ##### ##

*data : gt_zedt17 type zedt17_001 occurs 0 with header line.

*

*gt_zedt17-zcode = 'SSU-01'.

*gt_zedt17-zpernr = '0000000001'.

*gt_zedt17-zkname = '###'.

*gt_zedt17-zename = 'DONG'.

*gt_zedt17-zgender = 'M'.

*gt_zedt17-ztel = '01011112222'.

*

**break-point. " header line# ### ### # ## ##

*

*append gt_zedt17 to gt_zedt17.

*append gt_zedt17 " to ## ##. ### ##

*

**break-point. " body# ### ### # ## ##



** ##### ## ###### ## (Begin of ~ end of)

** 1. ### ###

*data : begin of gs_student, "### ##

*  zpernr type zedt17_001-zpernr, "####

*  zcode type zedt17_001-zcode, "####

*  zkname type zedt17_001-zkname, "##

*  zename type zedt17_001-zename, "####

*  zgender type zedt17_001-zgender, "##

*  ztel type zedt17_001-ztel, "####

*  zmname type zedt17_002-zmname, "##

*  end of gs_student.

**2. ### ### internal table ###

*data : gt_student like table of gs_student.

*

*gs_student-zcode = 'SSU-01'.

*gs_student-zpernr = '0000000001'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*gs_student-zmname = '####'.

*

**break-point. " header line# ### ### # ## ##

*

*append gs_student to gt_student.

*

**break-point. " body# ### ### # ## ##





************************

*

** Internal Table ###

*

**## entry# #### #### ## # ### ###, 1# ## ## ### 1# ##

**1) standard table

**2) sorted table

**3) hashed table

*

*data : begin of gs_student,

*         zcode(10),

*         zkname(10),

*         zename(10),

*         zclass,

*       end of gs_student.

*

*data : begin of gs_student2,

*         zcode(10),

*         zkname(10),

*         zename(10),

*         zclass,

*       end of gs_student2.

*

*data : gt_student like table of gs_student.

*data : gt_student2 like table of gs_student.

*

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*

*gs_student2-zcode = 'SSU-01'.

*gs_student2-zkname = '###'.

*gs_student2-zename = 'DONG'.

*

*append gs_student to gt_student.

*append gs_student to gt_student2.



** ##### ## itab move# # ####

*

*data : begin of gs_student,

*         zcode(10),

*         zkname(10),

*         zename(10),

*         zclass,

*       end of gs_student.

*

*data : begin of gs_student2,

*         zcode(10),

*         zkname(10),

*         zename(10),

*         zclass,

*       end of gs_student2.

*

*data : gt_student like table of gs_student.

*data : gt_student2 like table of gs_student.

*

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*

*append gs_student to gt_student.

*

*move gs_student to gs_student2.  " gs_student# ### gs_student2# copy

*append gs_student to gt_student2.

*

*move gt_student[] to gt_student2[]. " gs_student# body# gs_student2# copy

*





** ##### ### itab move# # ####

*data : begin of gt_student occurs 0,

*         zcode(10),

*         zkname(10),

*         zename(10),

*       end of gt_student.

*

*data : begin of gt_student2 occurs 0,

*         zcode(10),

*         zkname(10),

*         zename(10),

*       end of gt_student2.

*

*gt_student-zcode = 'SSU-01'.

*gt_student-zkname = '###'.

*gt_student-zename = 'DONG'.

*

*append gt_student.

*

*move gt_student to gt_student2. " gs_student# header# gs_student2# copy##, # # append ##### body## # X

*

*move gt_student[] to gt_student2[]. " gs_student# body# gs_student2# copy#### body# # ##



** move vs move-corresponding

*data : begin of gt_student occurs 0,

*         zcode(10),

*         zkname(10),

*         zename(10),

*       end of gt_student.

*

*data : begin of gt_student2 occurs 0,

*         zclass, " gt_student# ## ## #### ## ####(?)#

*         zcode(10),

*         zkname(10),

*         zename(10),

*       end of gt_student2.

*

*gt_student-zcode = 'SSU-01'.

*gt_student-zkname = '###'.

*gt_student-zename = 'DONG'.

*

*append gt_student.

*

**move gt_student[] to gt_student2[]. " gt_student# gt_student2# ## ## ### move### copy### ##

*

**move-corresponding gt_student to gt_student2. " gt_student# gt_student2# ## ## ### ### copy#

**append gt_student2. " header -> body

*

**move-corresponding gt_student[] to gt_student2[]. " ## body# #### ## ### #

*

**break-point.



*

** internal table ### : clear

*

*data : begin of gs_student,

*         zcode(10),

*         zkname(10),

*         zename(10),

*       end of gs_student.

*

*data : gt_student like table of gs_student.

*

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*

*append gs_student to gt_student.

*

*break-point. " gt_student body # ### # ###

*

*clear : gt_student. " #### ## internal table clear. => body# clear !!

*

*break-point. "gt_student body# ### ###






data : begin of gt_student occurs 0,

         zcode(10),

         zkname(10),

         zename(10),

       end of gt_student.



gt_student-zcode = 'SSU-01'.

gt_student-zkname = '###'.

gt_student-zename = 'DONG'.



append gt_student.






*break-point. " gt_student body # ### # ###



*clear : gt_student. " #### ## internal table clear => HEADER!!!# clear## #. ### body# ####

*clear : gt_student[]. " #### ## ### #### body# clear### ### [] ## body ## ### #.

*refresh : gt_student. " #### clear# ## ## #### clear## #. body(### ###)# ##. ### ### ###




free : gt_student. " inter table# body (### ###) ###, ### ### ##



break-point. "gt_student body# ### ##. header# ###