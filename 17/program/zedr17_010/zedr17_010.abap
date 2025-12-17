
*&---------------------------------------------------------------------*

*& Report ZEDR17_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_010.






*data : begin of gs_student.

*  include type zedt17_001.

*data : end of gs_student.

*data : gt_student like table of gs_student.



** [Selection Screen]

**parameters : p_zcode like zedt17_001-zcode lower case. " ### ##

**parameters : p_zcode like zedt17_001-zcode obligatory. " ##### ##

*selection-screen begin of block b1 with frame. " ## ###

*parameters : p_zcode like zedt17_001-zcode visible length 15. "### ### ## ## ##

*parameters : p_zpernr(10) no-display. " ###

*parameters : p_znum type p decimals 2.

*parameters : p_zgen like zedt17_001-zgender default 'M'. " default# ##

*selection-screen end of block b1.

*

*select * from zedt17_001

*  into corresponding fields of table gt_student

*  where zcode = p_zcode

*  and zgender = p_zgen.

*if gt_student[] is not initial.

*  write : / '### ##'.

*else.

*  write : / '### ##'.

*endif.



*

*selection-screen begin of block b2 with frame.

*selection-screen begin of line.

*  parameters : p_r1 radiobutton group r1 default 'X'.

*selection-screen position 3. " ## ## ##

*selection-screen comment (10) for field p_r1. " ### ##

*parameters : p_r2 radiobutton group r1.

*selection-screen position 20.

*selection-screen comment (10) for field p_r2.

*selection-screen end of line.

*parameters : z_check as checkbox default 'X'.

*selection-screen end of block b2.



*if z_check = 'X'. " z_check #### ## # ## ##

*  write : / '#### ##'.

*else.

*  write : / '## ##'.

*endif.

*

*if p_r1 = 'X'. " z_check #### ## # ## ##

*  write : / '#### ##'.

*elseif p_r2 = 'X'.

*  write : / '## ##'.

*endif.



**********************************************

* [Select Options]




tables : zedt17_001.

data : begin of gs_student.

  include structure
zedt17_001
.

  data : end of gs_student.

data : gt_student like table of gs_student.






*selection-screen begin of block b1 with frame.

*  select-options : s_zcode for zedt17_001-zcode. " for ## ## tables# ### ##### ##.

*selection-screen end of block b1.

*selection-screen begin of block b2 with frame.

*  parameters : p_zgen like zedt17_001-zgender.

*selection-screen end of block b2.

*

*select * from zedt17_001

*  into CORRESPONDING FIELDS OF table gt_student

*  where zcode in s_zcode

*  and zgender = p_zgen.

*

*if gt_student[] is not initial.

*  clear : gs_student.

*  loop at gt_student into gs_student.

*    write : / gs_student-zcode, gs_student-zkname.

*  endloop.

*else.

*  write : / '### ##'.

*endif.



*select-options : s_zcode for zedt17_001-zcode default 'SSU-01'. " sign I option eq# ### ### #

*select-options : s_zcode for zedt17_001-zcode default 'SSU-01' sign e option eq. " sign e option eq# ### # ## # ##

*select-options : s_zcode for zedt17_001-zcode default 'SSU-01' sign e option bt. " default data 1## ## between A and B  ##

*select-options : s_zcode for zedt17_001-zcode default 'SSU-01' to 'SSU-99' sign e option bt. " default data 2# ## -> bt ##



*select-options : s_zcode for zedt17_001-zcode default 'SSU-01' no intervals. " ## # #### ##. ### ### #

*select-options : s_zcode for zedt17_001-zcode default 'SSU-01' no intervals no-extension. " multiple selection ## ##

*parameters : s_zcode like zedt17_001-zcode. " ## #### # ### ### ## - ####



*select-options : s_zcode for zedt17_001-zcode default 'SSU-01' visible length 3. " #### ## ## ##



*parameters : p_zgen like zedt17_001-zgender.



*select * from zedt17_001

*  into CORRESPONDING FIELDS OF table gt_student

**  where zcode = s_zcode. " parameters# ### ##

*  where zcode in s_zcode.

*

*if gt_student[] is not initial.

*  clear : gs_student.

*  loop at gt_student into gs_student.

*    write : / gs_student-zcode, gs_student-zkname.

*  endloop.

*else.

*  write : / '### ##'.

*endif.






" modif id : ##### ##




*selection-screen begin of block b1 with frame.

*  select-options : s_zcode for zedt17_001-zcode.

*  parameters : p_zgen like zedt17_001-zgender.

*selection-screen end of block b1.

*selection-screen begin of block b2 with frame.

*  parameters : p_ch1 as checkbox default 'X' modif id m1. " 1. ### ### #### ##

*  parameters : p_ch2 as checkbox modif id m2. " #### ## 3### (ex, m111# 4### error)

*selection-screen end of block b2.






" #####  input #### (screen-group1)




*at selection-screen output. " 2. selection-screen# #### ## ##

*  loop at screen.

*    if screen-group1 = 'M2'. " 3. modif id# ## ### ##

*      screen-input = '0'. " 4. ### # ##. iput = 0: screen # input # 0; #, ## ## ####

*      modify screen.

*    endif.

*  endloop.






" ##### input #### (screen-name)




*  at selection-screen output. " 2. selection-screen# #### ## ##

*  loop at screen.

*    if screen-name = 'P_CH2'. " screen-group1# ### ###, screen-name# ### ###

*      screen-input = '0'. " 4. ### # ##. iput = 0: screen # input # 0; #, ## ## ####

*      modify screen.

*    endif.

*  endloop.






" ##### #### ##




*at selection-screen output.

*  loop at screen.

*    if screen-group1 = 'M2'.

*      screen-active = '0'. " ## ### ###

*      modify screen.

*    endif.

*  endloop.






" ##### ## ## ## ##




*at selection-screen output.

*  loop at screen.

*    if screen-group1 = 'M2'.

*      screen-required = '1'. " ## ## ## ## #

*      modify screen.

*    endif.

*  endloop.






" ##### ## ## ####




*at selection-screen output.

*  loop at screen.

*    if screen-group1 = 'M2'.

*      screen-output = '0'.

*      modify screen.

*    endif.

*  endloop.

*

* " ## ## ##

*select * from zedt17_001

*  into CORRESPONDING FIELDS OF table gt_student

**  where zcode = s_zcode. " parameters# ### ##

*  where zcode in s_zcode.

*

*if gt_student[] is not initial.

*  clear : gs_student.

*  loop at gt_student into gs_student.

*    write : / gs_student-zcode, gs_student-zkname.

*  endloop.

*else.

*  write : / '### ##'.

*endif.






" #### ## usercommand ### #####




*##1 - ####

*## 2 - #####

*## #### ### ##### ##, # ## #### ## ### user-command #### #

*fcode# ### ### #. #### : uc1, uc2, ..,




selection-screen begin of block b1 with frame.

  select-options : s_zcode for zedt17_001-zcode.

  parameters : p_zpernr like zedt17_001-zpernr modif id m1. " 1. ## ### #### ##

  parameters : p_zgen like zedt17_001-zgender matchcode object zsh17_001 modif id m2. " search help ## ## ## ###

  " matchcode object obtion ## search help## ##

selection-screen end of block b1.

selection-screen begin of block b2 with frame.

  parameters : p_r1 RADIOBUTTON GROUP r1 default 'X' user-command uc1. " 2. selection-screen ## ### ###### user-command fcode ### (uc1)




*  parameters : p_r1 RADIOBUTTON GROUP r1 default 'X'. " user-command ### enter ## ## ##




  parameters : p_r2 RADIOBUTTON GROUP r1.

  parameters : p_r3 RADIOBUTTON GROUP r2.

  parameters : p_r4 RADIOBUTTON GROUP r2.

selection-screen end of block b2.



at selection-screen output.

  loop at screen.

    if screen-group1 = 'M2'.

      screen-intensified = '1'. "## ##. 1# ###

      screen-display_3D = '1'. "## ## ##




*      screen-invisible = '1'. "#### *##




      if p_r1 = 'X'.

        screen-active = '1'.

      elseif p_r2 = 'X'.

        screen-active = '0'.

      endif.

    endif.

    modify screen.

  endloop.





select * from zedt17_001

  into CORRESPONDING FIELDS OF table gt_student




*  where zcode = s_zcode. " parameters# ### ##




  where zcode in s_zcode.



if gt_student[] is not initial.

  clear : gs_student.

  loop at gt_student into gs_student.

    write : / gs_student-zcode, gs_student-zkname.

  endloop.

else.

  write : / '### ##'.

endif.