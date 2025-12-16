
*&---------------------------------------------------------------------*

*& Report ZEDR17_007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_007.






* [InternalTable ##]



** student, major ### ### ## ## # ### ##

*data : gs_student type zedt17_001.

*data : gt_student like table of gs_student.

*

*data : begin of gs_major,

*         zcode  like zedt17_001-zcode, "####

*         zpernr like zedt17_001-zpernr, "####

*         zmname like zedt17_004-zmname, "###

*       end of gs_major.

*data : gt_major like table of gs_major with non-unique key zcode. " read ### ### #### # # ##.




" 1. ## READ ## : # ###, syntax ## ## X but read ###

" 2. TABLE KEY ## : # ###, syntax ## ##






*clear : gs_student, gt_student, gs_major, gt_major.

*gs_student-zpernr = '0000000001'.

*gs_student-zcode = 'SSU-01'.

*gs_student-zkname = '###'.

*gs_student-zename = 'DONG'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01011112222'.

*append gs_student to gt_student.

*

*gs_major-zpernr = '0000000001'.

*gs_major-zcode = 'SSU-01'.

*gs_major-zmname = '####'.

*append gs_major to gt_major.

*

*clear : gs_student, gs_major.



* 1. ## READ ## (###)

** sy-subrc = 0 " ##, # ## ##

** sy-subrc = 2 " # ##

** sy-subrc = 4 " ## ##### ### ### # ### ## X

*loop at gt_student into gs_student.

*  clear : gs_major.

*  move-corresponding gs_student to gs_major. " ### ### # ## #### ##. ### ## ##(## ## X)

*  read table gt_major from gs_major into gs_major. " #### ## # # #### ### ## ### ### #### ##

*  " ## read ## ### #### zmname ### ##### ###.

*

*  if sy-subrc = 0. " # ### ## (## # ### 2, ### ### 4)

*    " loop # ## ### ## ## 2## ###### #### # ## ## ## -> #### ## ##

*    write : / gs_student-zcode, gs_student-zkname, gs_student-zename.

*  else.

*    write : / '#### #### #####.'.

*  endif.

*endloop.



* 2. TABLE KEY ## (###)

** sy-subrc = 0 " ##

** sy-subrc = 4 " ##

*gs_student-zpernr = '0000000002'.

*gs_student-zcode = 'SSU-02'.

*gs_student-zkname = '###'.

*gs_student-zename = 'LEE'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01022223333'.

*append gs_student to gt_student.

*

*gs_major-zpernr = '0000000002'.

*gs_major-zcode = 'SSU-02'.

*gs_major-zmname = '#####'.

*append gs_major to gt_major.

*

*clear : gs_student, gs_major.

*

*gs_student-zpernr = '0000000003'.

*gs_student-zcode = 'SSU-03'.

*gs_student-zkname = '##'.

*gs_student-zename = 'BIN'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01033334444'.

*append gs_student to gt_student.

*

*gs_major-zpernr = '0000000003'.

*gs_major-zcode = 'SSU-03'.

*gs_major-zmname = '######'.

*append gs_major to gt_major.

*

*clear : gs_student, gs_major.

*

*gs_student-zpernr = '0000000004'.

*gs_student-zcode = 'SSU-04'.

*gs_student-zkname = '##'.

*gs_student-zename = 'JENNY'.

*gs_student-zgender = 'F'.

*gs_student-ztel = '01044445555'.

*append gs_student to gt_student.

*

*gs_major-zpernr = '0000000004'.

*gs_major-zcode = 'SSU-04'.

*gs_major-zmname = '####'.

*append gs_major to gt_major.

*

*clear : gs_student, gs_major.

*

*gs_student-zpernr = '0000000005'.

*gs_student-zcode = 'SSU-05'.

*gs_student-zkname = '##'.

*gs_student-zename = 'KOOK'.

*gs_student-zgender = 'M'.

*gs_student-ztel = '01055556666'.

*append gs_student to gt_student.

*

*gs_major-zpernr = '0000000005'.

*gs_major-zcode = 'SSU-05'.

*gs_major-zmname = '#####'.

*append gs_major to gt_major.

*

*clear : gs_student, gs_major.



*loop at gt_student into gs_student.

*  clear : gs_major.

*  read table gt_major with table key zcode = gs_student-zcode " ###### ### ## ### pk## ## #### read

*  into gs_major.

*

*  if sy-subrc = 0. " ###

*    write : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  else.

*    write : / '#### #### #####.'.

*  endif.

*endloop.



* 3. WORK AREA ##

** 3-1. ## WORK AREA ##

*loop at gt_student into gs_student.

*  clear : gs_major.

*  read table gt_major with key zcode = gs_student-zcode "### ## # ### read

*                                zpernr = gs_student-zpernr " ### # ## 2# ### ## , ##

*  into gs_major.

*  if sy-subrc = 0. " ###

*    write : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  else.

*    write : / '#### #### #####.'.

*  endif.

*endloop.



** 3-2. COMPARING ##

** read ## ## ### ## ## #### work area# #### ##

*loop at gt_student into gs_student.

*  clear : gs_major.

*  move-corresponding gs_student to gs_major. " ## ## ## ## #### ### ##

*

*  read table gt_major with key zcode = gs_student-zcode into gs_major. " #### zcode ### ### ####### # ##

*  "comparing zcode. " #### ####### zcode ## # ##

*

** comparing# ### zcode ## ## ### sy-subc=0# ## ### ### #### ### ###,

** ## comparing## ##### # ##

*

*  if sy-subrc = 0. " #### # ### ## (##)

*    write : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  else.

*    write : / '#### #### #####.'.

*  endif.

*endloop.



** 3-3. TRANSPORTING ##

** read# ### ## #### ##




data : gs_student type zedt17_001.

data : gt_student like table of gs_student.



data : begin of gs_major,

         zcode  like zedt17_001-zcode, "####

         zpernr like zedt17_001-zpernr, "####

         zkname like zedt17_001-zkname, "##

         zmname like zedt17_004-zmname, "###

       end of gs_major.

data : gt_major like table of gs_major.



clear : gs_student, gt_student, gs_major, gt_major.

gs_student-zpernr = '0000000001'.

gs_student-zcode = 'SSU-01'.

gs_student-zename = 'DONG'.

gs_student-zgender = 'M'.

gs_student-ztel = '01011112222'.

append gs_student to gt_student.



gs_major-zpernr = '0000000001'.

gs_major-zcode = 'SSU-01'.

gs_major-zkname = '###'.

gs_major-zmname = '####'.

append gs_major to gt_major.



clear : gs_student, gs_major.



gs_student-zpernr = '0000000002'.

gs_student-zcode = 'SSU-02'.

gs_student-zename = 'LEE'.

gs_student-zgender = 'M'.

gs_student-ztel = '01022223333'.

append gs_student to gt_student.



gs_major-zpernr = '0000000002'.

gs_major-zcode = 'SSU-02'.

gs_major-zkname = '###'.

gs_major-zmname = '#####'.

append gs_major to gt_major.



clear : gs_student, gs_major.



gs_student-zpernr = '0000000003'.

gs_student-zcode = 'SSU-03'.

gs_student-zename = 'BIN'.

gs_student-zgender = 'M'.

gs_student-ztel = '01033334444'.

append gs_student to gt_student.



gs_major-zpernr = '0000000003'.

gs_major-zcode = 'SSU-03'.

gs_major-zkname = '##'.

gs_major-zmname = '######'.

append gs_major to gt_major.



clear : gs_student, gs_major.



gs_student-zpernr = '0000000004'.

gs_student-zcode = 'SSU-04'.

gs_student-zename = 'JENNY'.

gs_student-zgender = 'F'.

gs_student-ztel = '01044445555'.

append gs_student to gt_student.



gs_major-zpernr = '0000000004'.

gs_major-zcode = 'SSU-04'.

gs_major-zkname = '##'.

gs_major-zmname = '####'.

append gs_major to gt_major.



clear : gs_student, gs_major.



gs_student-zpernr = '0000000005'.

gs_student-zcode = 'SSU-05'.

gs_student-zename = 'KOOK'.

gs_student-zgender = 'M'.

gs_student-ztel = '01055556666'.

append gs_student to gt_student.



gs_major-zpernr = '0000000005'.

gs_major-zcode = 'SSU-05'.

gs_major-zkname = '##'.

gs_major-zmname = '#####'.

append gs_major to gt_major.



clear : gs_student, gs_major.






*loop at gt_student into gs_student.

*  clear : gs_major.

*  move-corresponding gs_student to gs_major.

*

** gt_major## gs_student# zcode ### ### ## ##,

** ## ## zmname ### gs_major ## #### ##.

** TRANSPORTING ### READ TABLE# ## ## ### ## #### ### #####

** ### # ##. gt_major# zmname ## ## gs_major# ####

** ## ##(ex. zkname)# #### X

*  read table gt_major with key zcode = gs_student-zcode into gs_major

*  transporting zmname.

*

*  if sy-subrc = 0.

*    gs_student-zkname = gs_major-zkname. " gs_major## zmname# ###### zkname# ##

*    write : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  else.

*    write : / '#### #### #####.'.

*  endif.

*endloop.





* 4. INDEX ## (##! ## ## #)

*sort gt_major.

*loop at gt_student into gs_student.

*  clear : gs_major.

*  move-corresponding gs_student to gs_major.

*

*  read table gt_major into gs_major index sy-tabix.

*  gs_student-zkname = gs_major-zkname.

*

*  if sy-subrc = 0.

*    write : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  else.

*    write : / '#### #### #####.'.

*  endif.

*endloop.



* 5. READ BINARY SEARCH

** loop ### # #### # #, ## ## ### ## ### memory dump ##

** binary search ## full scan ## ##

*sort gt_student by zcode.

*sort gt_major by zcode.

*

*loop at gt_student into gs_student.

*  clear : gs_major.

*  move-corresponding gs_student to gs_major.

*

*  read table gt_major with key zcode = gs_student-zcode into gs_major binary search.

*  gs_student-zkname = gs_major-zkname.

*

*  if sy-subrc = 0.

*    write : / gs_student-zcode, gs_student-zkname, gs_major-zmname.

*  else.

*    write : / '#### #### #####.'.

*  endif.

*endloop.



************************************



* [InternalTable ##]



* 1. DO ~ ENDDO

*data : lv_num type i.

*data : lv_sum type i.

*lv_num = 5.



*do lv_num times.

**  add sy-index to lv_sum.

*  lv_sum = lv_sum + sy-index.

*  write : / sy-index.

*enddo.

*write : / 'index##: ', lv_sum.



*do lv_num times.

*  if sy-index = '3'.

*    exit. " break ##

*  endif.

*  add sy-index to lv_sum.

*  write : / sy-index.

* enddo.

* write : / 'index##: ', lv_sum.



*do lv_num times.

*  if sy-index = '3'.

*    continue. " continue

*  endif.

*  add sy-index to lv_sum.

*  write : / sy-index.

* enddo.

* write : / 'index##: ', lv_sum.



*do lv_num times.

*  check sy-index = '3'. " check## ## ## ### ##

*  add sy-index to lv_sum.

*  write : / sy-index.

* enddo.

* write : / 'index##: ', lv_sum.



* 2. WHILE ~ DO WHILE




data : gv_num type i.

data : gv_check type c.



gv_num = 5.



while gv_num = 5.

  gv_check = 'X'.

  add 1 to gv_num.

endwhile.



if gv_check = 'X'.

  write : / '#######'.

endif.