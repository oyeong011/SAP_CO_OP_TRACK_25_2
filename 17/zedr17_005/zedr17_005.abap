
*&---------------------------------------------------------------------*

*& Report ZEDR17_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_005.






* [InternalTable ##_LOOP#]



*** ### ##

*data : begin of gs_student, "### ##

*  zpernr type zedt17_001-zpernr, "####

*  zcode type zedt17_001-zcode, "####

*  zkname type zedt17_001-zkname, "##

*  zename type zedt17_001-zename, "####

*  zgender type zedt17_001-zgender, "##

*  zgname(4), "####

*  ztel type zedt17_001-ztel, "####

*  end of gs_student.

*

*data : gt_student like table of gs_student.

*

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

**break-point.



*** 1. ## ##

*clear : gs_student.

*loop at gt_student into gs_student.

*  if gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  elseif gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  else.

*    gs_student-zgname = '##'.

*  endif.

**break-point. " work-area## ##. sy-tabix 1~3 ### # ## ##. append ##### body# #### ##.

*endloop.



*** 2. ## # ##

*clear : gs_student.

*loop at gt_student into gs_student where zgender = 'F'. " where ## ## #### loop ## ##

*  if gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  elseif gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  else.

*    gs_student-zgname = '##'.

*  endif.

*break-point. " 3## zgender = 'F'### sy-tabix# ## 3## #

*endloop.



*** 3. index ##

*clear : gs_student.

*loop at gt_student into gs_student from 2 to 3. " 2~3 #### ###  loop ## ##

*  if gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  elseif gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  else.

*    gs_student-zgname = '##'.

*  endif.

**break-point. " 2~3## ##. sy-tabin 2, 3# #

*endloop.



******************************************************



* [InternalTable ##_##]

** 1. table key# ### # ## ##



**** ### ##

*data : begin of gs_student, "### ##

*  zpernr type zedt17_001-zpernr, "####

*  zcode type zedt17_001-zcode, "####

*  zkname type zedt17_001-zkname, "##

*  zename type zedt17_001-zename, "####

*  zgender type zedt17_001-zgender, "##

*  zgname(4), "####

*  ztel type zedt17_001-ztel, "####

*  end of gs_student.

*data : gt_student like table of gs_student.

*

*clear : gs_student, gt_student.

*gs_student-zcode = 'SSU-01'.

*gs_student-zpernr = '0000000001'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'F'. " ## ## ### ### # ##

*gs_student-ztel = '01011112222'.

*append gs_student to gt_student.

*

*gs_student-zgender = 'M'. "### #### ###. ## body# ## X

*append gs_student to gt_student. "### ##, append### ### ## ##(####) ## ### ### append#

*break-point.



*** ##### # #### ##




data : begin of gs_student, "### ##

  zpernr type zedt17_001-zpernr, "####

  zcode type zedt17_001-zcode, "####

  zkname type zedt17_001-zkname, "##

  zename type zedt17_001-zename, "####

  zgender type zedt17_001-zgender, "##

  zgname(4), "####

  ztel type zedt17_001-ztel, "####

  end of gs_student.

data : gt_student like table of gs_student with non-unique key zcode. " # # #### ##



clear : gs_student, gt_student.

gs_student-zcode = 'SSU-01'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'F'. " ## ## ### ### # ##

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



clear : gs_student.

gs_student-zcode = 'SSU-02'.

gs_student-zpernr = '0000000001'.

gs_student-zkname = '###'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'F'. " ## ## ### ### # ##

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



gs_student-zcode = 'SSU-01'.








** 2. talbe key# ### # ## ##






gs_student-zename = 'kang'. "### #### ###. ## body# ## X

gs_student-zgender = 'M'. "### #### ###. ## body# ## X

modify table gt_student from gs_student. "zcode ## #### ###

break-point.




*

*gs_student-zename = 'KANG'.

*gs_student-zgender = 'M'.

*modify table gt_student from gs_student transporting zgender. "header# zename# zgender ## #### ###, body## zgender# #### ##

*break-point.





** 3. where ### ### ## ## ##



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

*

*loop at gt_student into gs_student.

*  if gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  elseif gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  else.

*    gs_student-zgname = '##'.

*  endif.

*

*  modify gt_student from gs_student transporting zgname

*  where zcode = gs_student-zcode.

*

*  clear gs_student.

*endloop.

*

*gs_student-zename = 'KANG'.

*gs_student-zgender = 'M'.

*modify table gt_student from gs_student transporting zgender. "header# zename# zgender ## #### ###, body## zgender# #### ##

*break-point.



*** 4. index# ### # ## ## (## ## ##)



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

*

*loop at gt_student into gs_student.

*  if gs_student-zgender = 'M'.

*    gs_student-zgname = '##'.

*  elseif gs_student-zgender = 'F'.

*    gs_student-zgname = '##'.

*  else.

*    gs_student-zgname = '##'.

*  endif.

*

*  modify gt_student from gs_student index sy-tabix.

*  " index sy-tabix# ## ## ## ## ##, # #### ##.

*  " loop## ## #### ##### ###.

*  " loop # ### ## sy-tabix ### ## zgname ## #### # ## ##

*

*  clear gs_student.

*endloop.





******************************************************



* [InernalTable ##]



*** ### ##

*data : gs_student type zedt17_001.

*data : gt_student like table of gs_student.

*

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

**break-point.



*** 1. Loop# ## ## ##

*clear gs_student.

*loop at gt_student into gs_student.

*  break-point.

*  if gs_student-zgender ne 'M'. " ### ## ##

*    delete table gt_student from gs_student. " 3## F### #### ## ## ## ##.

*

*    if sy-subrc = 0. " ##### ## # ## 0#  ##

*    " ## sy-tabix = 3## ### gs_student-zcode #### sy-subrc# 4# ## else## ##

*    else. " ###### ## # ## 4# ##

*      write :/ '####'.

*    endif.

*  else.

*    write :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*  endif.

*endloop.



** 2. Table key# ### ## ##



*** ### ##

*data : gs_student type zedt17_001.

*data : gt_student like table of gs_student with non-unique key zgender. " #### ##(zgender)# key# ##

*

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

**break-point.

*

*delete table gt_student with table key zgender = 'F'. "# # #### ## ## ## ##.

*

*if sy-subrc = 0.

*  loop at gt_student into gs_student.

*    write :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*  endloop.

*endif.





** 3. where ### ### ## ## (###)



*** ### ##

*data : gs_student type zedt17_001.

*data : gt_student like table of gs_student.

*

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

**break-point.

*

**delete gt_student where zgender = 'F'. "loop ## ##, ## # ##### # ##. performance ##### ## # ### ##

**

**if sy-subrc = 0.

**  loop at gt_student into gs_student.

**    write :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

**  endloop.

**endif.

*

*** 4. index# ### ## ## (###)

*

**delete gt_student index 2. " index 2 # ##

**delete gt_student from 2 to 3. " index 2~3# ##

**delete gt_student from 2. " index 2### ###

*delete gt_student to 2. " index #### 3###

*

*if sy-subrc = 0.

*  loop at gt_student into gs_student.

*    write :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*  endloop.

*endif.





** 5. adjacent duplicate ### ### ## ## ## (## ###)

** ex) zcode ### ##### #, ## ### zcode #### ## ###### ## ##



*** ### ##

*data : gs_student type zedt17_001.

*data : gt_student like table of gs_student.

*

*clear : gs_student, gt_student.

*gs_student-zcode = 'SSU-01'.

*gs_student-zpernr = '0000000001'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*append gs_student to gt_student.

*

** ## ### ##

*gs_student-zcode = 'SSU-01'.

*gs_student-zpernr = '0000000001'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

**gs_student-ztel = '01011112222'.

*gs_student-ztel = '01011112223'. " ## #### # ### ## # #

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

**break-point.

*

*sort gt_student.

*

**delete adjacent duplicates from gt_student. " gt_student## ## ### # ## ## # ##.

*delete adjacent duplicates from gt_student comparing zcode. " zcode# ### ##

*

*loop at gt_student into gs_student.

*  write :/ gs_student-zcode, gs_student-zkname, gs_student-zgender.

*endloop.