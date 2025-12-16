
*&---------------------------------------------------------------------*

*& Report ZEDR17_006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_006.






* [InternalTable##_AT]



*** ### ##




data : begin of gs_student, "### ##

  zpernr type zedt17_001-zpernr, "####

  zcode type zedt17_001-zcode, "####

  zkname type zedt17_001-zkname, "##

  zename type zedt17_001-zename, "####

  zgender type zedt17_001-zgender, "##

  zgname(4), "####

  ztel type zedt17_001-ztel, "####

  end of gs_student.



data : gt_student like table of gs_student.






*clear : gs_student, gt_student.

*gs_student-zcode = 'SSU-01'.

*gs_student-zpernr = '0000000001'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*append gs_student to gt_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-02'.

*gs_student-zpernr = '0000000002'.

*gs_student-zkname = '###'.

*gs_student-zename = 'HOON'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*append gs_student to gt_student.

*

*clear : gs_student.

*gs_student-zcode = 'SSU-03'.

*gs_student-zpernr = '0000000003'.

*gs_student-zkname = '###'.

*gs_student-zename = 'SON'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01033334444'.

*append gs_student to gt_student.



** AT FIRST

*loop at gt_student into gs_student.

*  gs_student-zgname = '####'.

*

*  at first. " at first# # ## loop### #### 1# gs_student-zgname# '####' ### .

*    gs_student-zgname = '####'.

*  endat.

*

*  clear : gs_student.

*endloop.



** AT LAST

*loop at gt_student into gs_student.

*  gs_student-zgname = '####'.

*

*  at last. " at last# ### loop### #### 3# gs_student-zgname# '####' ### .

*    gs_student-zgname = '####'.

*  endat.

*

*  clear : gs_student.

*endloop.



*********************************************



*** ### ##




clear : gs_student, gt_student.

gs_student-zcode = 'SSU-01'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'F'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'A'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'F'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'KANG'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-01'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'LEE'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.



sort gt_student by zcode zkname zename zgender. " sort# ## ### ## #






** AT NEW FIELD: new# ## ### ### ## ### ### ### #




loop at gt_student into gs_student.

  gs_student-zgname = '####'.



  at new zename. " zename ## #### ##

    gs_student-zgname = '####'.

  endat.



  clear : gs_student.

endloop.






** AT END OF FIELD: ## ## ## ## ##### ### ### ##




loop at gt_student into gs_student.

  gs_student-zgname = '####'.



  at end of zename. " zename ## #### ##

    gs_student-zgname = '####'.

  endat.



  clear : gs_student.

endloop.