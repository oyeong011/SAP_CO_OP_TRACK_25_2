
*&---------------------------------------------------------------------*

*& Report ZEDR17_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_013 MESSAGE-ID zmed17. " message #### ##### ##






** [program ## - Syntax]



******************************  case~endcase *********************************************

*data : begin of gs_student.

*  include type zedt17_002.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

*data : begin of gs_write,

*  zmajor_name(10),

* end of gs_write.



*case gs_student-zmajor.

*  when 'A'.

*    gs_write-zmajor_name = '####  '.

*    write : / gs_write-zmajor_name.

*  when 'B'.

*    gs_write-zmajor_name = '####  '.

*  when 'C'.

*    gs_write-zmajor_name = '###   '.

*  when 'D'.

*    gs_write-zmajor_name = '#####  '.

*  when 'E'.

*    gs_write-zmajor_name = '###### '.

*  when 'F'.

*    gs_write-zmajor_name = '###    '.

*  when 'G'.

*    gs_write-zmajor_name = '###    '.

*  when 'H'.

*    gs_write-zmajor_name = '###    '.

*endcase.



****************************** message *********************************************

*tables : zedt17_001.

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

*selection-screen begin of block b1 with frame.

*  select-options : s_zcode for zedt17_001-zcode.

*  parameters : p_zpernr like zedt17_001-zpernr.

*  parameters : p_zgen like zedt17_001-zgender.

*selection-screen end of block b1.

*

*if s_zcode is initial.

**  message E000. " ## # ## # ### ## but ### ##X, ## ##

*  message I000. " ## # ## # ### ## but ## ###

*endif.

*

*perform get_data.

*if gt_student is initial.

*  message i001. " ## ### ## # ### ## ## ##

**  message e001. " ## ### ## # ### ## ## #### ##

*  exit.

*endif.

*perform write_data.

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*form get_data .

*select * from zedt17_001

*  into CORRESPONDING FIELDS OF table gt_student

**  where zcode = s_zcode. " parameters# ### ##

*  where zcode in s_zcode.

*endform.

**&---------------------------------------------------------------------*

**&      Form  WRITE_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*form write_data .

*if gt_student[] is not initial.

*  clear : gs_student.

*  loop at gt_student into gs_student.

*    write : / gs_student-zcode, gs_student-zkname.

*  endloop.

*else.

*  write : / '### ##'.

*endif.

*endform.



**************************************************************************************



** [REPORT_EVENT]

* 1. INITIALIZATION

** selection screen ### ### ## ## ## ## ###

** ## ## or ## #### #### ## ## ##




tables : zedt17_001.

data : begin of gs_student.

  include structure
zedt17_001
.

  data : end of gs_student.

data : gt_student like table of gs_student.



selection-screen begin of block b1 with frame.

  select-options : s_zcode for zedt17_001-zcode.

  parameters : p_zpernr like zedt17_001-zpernr.

  parameters : p_zgen like zedt17_001-zgender default 'M' modif id sc1. " ## ## sc1 ## ##

selection-screen end of block b1.






*initialization.

*s_zcode-low = 'SSU-02'.

*s_zcode-high = 'SSU-99'.

*append s_zcode.






" start-of-selection ## # #### ## ## ##

initialization.

s_zcode-low = 'SSU-02'.

s_zcode-high = 'SSU-99'.

s_zcode-sign = 'I'. " include. ## ## ##

s_zcode-option = 'BT'. " between. low# high ### # ##

append s_zcode.






* 2. AT SELECTION-SCREEN

** init# start-of-selection ### #### ### ### ##

** cf) 1,2 ## #### ### ### ### #. 3## ## ## #. ## ## ##



** 1) on field - selection screen## #### ## ### ## ##. ##### ### ## ### ## ##### #

*at selection-screen on s_zcode.

*  loop at s_zcode.

*    if s_zcode-low ne 'SSU-01'.

*      message '##### SSU-01## #####' type 'E'.

*    endif.

*  endloop.



** 2) on end of field - range table ##/## #, # ### ##

*at selection-screen on end of s_zcode.

*  loop at s_zcode.

*    if s_zcode-low ne 'SSU-01'.

*      message '##### SSU-01## #####' type 'E'.

*    endif.

*  endloop.



** 3) output - selection screen ### layout ### ##




at selection-screen output. " selection-screen# ##### #### ## ### ###

  loop at screen.

    if screen-group1 = 'SC1'.

      screen-input = 0. " ## ##(display-only). ### ## 1(####)

    endif.

    modify screen. " ### ### ## ### ##

  endloop.






* 3. START-OF-SELECTION

* initialization ### ##?

* -> s_zcode# 4## ##(SIGN, OPTION, LOW, HIGH)# ### ### ###.

* # ##### LOW# HIGH ## #### ## ### SIGN# OPTION ## #### ###.

* ## #### ### SIGN ### #### ' '(##)# ## ###, ## ### #('I' ## 'E')# ####

* SELECT ## #### ## ### #### #

* => initialization ####  sign# option # ##### ###

*start-of-selection. " initialization ### ##




  perform get_data.






* 4. END-OF-SELECTION

* ### ### dump# # ####

* select, modify# ### #### start-of-selection ###

* ### ## ### alv# ### #### end-of-selection# ##### #### ##

*end-of-selection.




  perform write_data.






*&---------------------------------------------------------------------*

*&      Form  get_data

*&---------------------------------------------------------------------*




form get_data .

  select * from zedt17_001

    into corresponding fields of table gt_student

    where zcode in s_zcode.

endform.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*




form write_data .

  loop at gt_student into gs_student.

    write : / gs_student-zcode, gs_student-zkname.

  endloop.

endform.