
*&---------------------------------------------------------------------*

*& Report ZEDR09_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_003.






* assigning value - Data object# assigning value (# ##)

* 1. MOVE A TO B (equal)

* 2. OFFSET# ### # ##

* 3. WRITE A TO B

* 4. MOVE-CORRENSPONDING



* 1. MOVE A TO B

* - equal(=) ### ### ##

* - # #### ## ## (#, TYPE D# TYPE T# ##)

* - A -> B# ## ## ## ## ##.



* - equal ## (move a to b ###)




DATA : BEGIN OF GS_NAME,

  NAME1(10) TYPE C VALUE '###',

  NAME2(10) TYPE C VALUE '##',

  END OF GS_NAME.



write / GS_NAME-NAME1. "###

write / GS_NAME-NAME2. "##

write / 'equal #### # ##'.



GS_NAME-NAME1 = GS_NAME-NAME2.

write / GS_NAME-NAME1. "##

write / GS_NAME-NAME2. "##






* - move a to b# # ### #

* move a to b <=> move '###' to '##' <=> a## ~> b# #### !!






DATA : BEGIN OF GS_NAME_assign,

  NAME1(10) type c value '###',

  NAME2(10) type c value '##',

  end of gs_name_assign.



write : / 'move a to b # :: ', gs_name_assign-name1, ',name2 : ', gs_name_assign-name2.




* move a to b (a## b### ####)




move gs_name_assign-name2 to gs_name_assign-name1.



write : / 'move a to b # ::', gs_name_assign-name1, ',name2 : ', gs_name_assign-name2.








* - move a to b# #### ##

* - 35.12# ####(n,i,p) # p

* - ### p# ### ###, ## ##### condense # ## ###, ## string #### # # ##.

* - ## ##, move a to b # #### ### !!




DATA : BEGIN OF gs_name_02,

  name1 type c length 10 value '##',

  degree1 type p decimals 2 value '35.12',

  END OF gs_name_02.



write : / '### #', gs_name_02-name1.




* move a to b -> a#(### 35.12)# b(### c)# ####.

* #, name1# ### 35.12# ##### #### ###. '35.12'.




move gs_name_02-degree1 to gs_name_02-name1.



write : / '### # & condense # ,' , gs_name_02-name1.

condense gs_name_02-name1 no-gaps.

write : / '### # & condense #' , gs_name_02-name1.










* 2. offset# ### # ##

* - #### ## ## ### # index #### ## ######

* - MOVE A p1(p2) TO B p3(p4)

*    A## p1## ~ p2## ####, B## p3 ~ p4## ##

*    offset##### p1## 0## ##






DATA : gv_data1(8) type c value 'abcdefgh',

       gv_data2(8),

       gv_temp3 type string value 'abcdefgh'.



move gv_data1+2(3) to gv_data2.

write / gv_data1.

write / gv_data2. "cdf"






* gv_data2 ##




move gv_data2 to gv_temp3.



DATA : gv_start type i value 2,

       gv_length type i value 4.



move gv_data1+gv_start(gv_length) to gv_data2.



write / gv_data1.

write / gv_data2.






* 'ijklmnop' -> 'ij**coef**op'






data : gv_data1_2(8) value 'abcdefgh',

       gv_data2_2(8) value 'ljkimnop'.



move gv_data1_2+2(4) to gv_data2_2+2(4).



write / gv_data1_2.

write / gv_data2_2.






* 3. write a to b

* - write## ### ## ###### ## #

* - ## ##### ### #### ####!






DATA : begin of GS_NAME_04,

  NAME1 TYPE C length 10,

  NAME2 type c length 10,

  END OF GS_NAME_04.



GS_NAME_04-name1 = '###'.

GS_NAME_04-NAME2 = '##'.






* WRITE GS_NAME_04-nam2TO GS_NAME_04-name2.






write : / GS_NAME_04-name1.

write : / GS_NAME_04-name2.






* 4. move-corresponding

* - #### copy

* - ##### ## ### # ##

* - #### ## ###, ## ##

* - ##, #### ### ### ## ### move# ###, ### #### #### #####

* - ###### move-responsding# ### #.



* - move a to b# ###? => ## # ### '### # ### #', ### ## ### # ### 4## #.

*    - move a to b :

*       ## ##

*       #### ### ### # ### '####' ### ### ####. #, #### ### ### ### ## ####

*    - move-corresponding

*       ##'##'# ## ## ##. ### ##### ##

*






DATA : BEGIN OF GS_ZEDT09_05, "#####

  ZCODE TYPE ZEDT09_001-ZCODE,

  ZKNAME TYPE ZEDT09_001-ZKNAME,

  ZENAME TYPE ZEDT09_001-ZENAME,

  ZGENDER TYPE ZEDT09_001-ZGENDER,

  ZTEL TYPE ZEDT09_001-ZTEL,

  END OF GS_ZEDT09_05.






* ## ####, ##### ## (#### ###!)




DATA : BEGIN OF GS_ZEDT09_06, "#####

  ZCODE TYPE ZEDT09_001-ZCODE,

  ZKNAME TYPE ZEDT09_001-ZKNAME,

  ZENAME TYPE ZEDT09_001-ZENAME,

  ZGENDER TYPE ZEDT09_001-ZGENDER,

  ZTEL TYPE ZEDT09_001-ZTEL,

  END OF GS_ZEDT09_06.



GS_ZEDT09_05-ZCODE = 'ssu-09'.

GS_ZEDT09_05-ZKNAME = '###'.

GS_ZEDT09_05-ZENAME = 'kimminji'.

GS_ZEDT09_05-ZGENDER = 'F'.

GS_ZEDT09_05-ZTEL = '01072373114'.





MOVE-CORRESPONDING gs_zedt09_05 to gs_zedt09_06.



write : / gs_zedt09_06-ZCODE.

write : /  gs_zedt09_06-ZKNAME.

write : /  gs_zedt09_06-ZENAME.

write : /  gs_zedt09_06-ZGENDER.

write : /  gs_zedt09_06-ZTEL.






* ### ### move-corresponding a to b###, #### ##### ## ## #### ##### #### !!




DATA : BEGIN OF GS_ZEDT09_06_change_order, "#####

  ZGENDER TYPE ZEDT09_001-ZGENDER,

  ZCODE TYPE ZEDT09_001-ZCODE,

  ZKNAME TYPE ZEDT09_001-ZKNAME,

  ZENAME TYPE ZEDT09_001-ZENAME,

  ZTEL TYPE ZEDT09_001-ZTEL,

  END OF GS_ZEDT09_06_change_order.






* ZGENDER# ## ## ! *




move-corresponding gs_zedt09_05 to gs_zedt09_06_change_order.



write : / 'zgender# ## ## ###### ##'.

write : / gs_zedt09_06_change_order-ZCODE.

write : / gs_zedt09_06_change_order-ZKNAME.

write : / gs_zedt09_06_change_order-ZENAME.

write : / gs_zedt09_06_change_order-ZGENDER.

write : / gs_zedt09_06_change_order-ZTEL.






* ##, move a to b# ### ##'#'# #### '##'## #####, ### ### #### #### #!




DATA : BEGIN OF GS_ZEDT09_06_change_order2,"#####

  ZGENDER TYPE ZEDT09_001-ZGENDER,

  ZCODE TYPE ZEDT09_001-ZCODE,

  ZKNAME TYPE ZEDT09_001-ZKNAME,

  ZENAME TYPE ZEDT09_001-ZENAME,

  ZTEL TYPE ZEDT09_001-ZTEL,

  END OF GS_ZEDT09_06_change_order2.



move gs_zedt09_05 to gs_zedt09_06_change_order2.



write : / 'zgender# ## ## ###### ##22, move a to b'.

write : / gs_zedt09_06_change_order2-ZCODE.

write : / gs_zedt09_06_change_order2-ZKNAME.

write : / gs_zedt09_06_change_order2-ZENAME.

write : / gs_zedt09_06_change_order2-ZGENDER.

write : / gs_zedt09_06_change_order2-ZTEL.






* ##, move a to b# # ## ##### ### ### ##. ### ##, #### ####, # ### ##

* #, move a to b# ### #### ### ## ##### ### # #..

* ## ## ### move-corresponding a to b# ### # ### ###.






DATA : BEGIN OF GS_ZEDT09_06_diff_name, "#####

  ZZZCODE TYPE ZEDT09_001-ZCODE,

  ZZZKNAME TYPE ZEDT09_001-ZKNAME,

  ZZZENAME TYPE ZEDT09_001-ZENAME,

  ZZZGENDER TYPE ZEDT09_001-ZGENDER,

  ZZZTEL TYPE ZEDT09_001-ZTEL,

  END OF GS_ZEDT09_06_diff_name.



move gs_zedt09_05 to gs_zedt09_06_diff_name.





write : / '#### ##, ### ##, move a to b try'.

write : / gs_zedt09_06_diff_name-ZZZCODE.

write : / gs_zedt09_06_diff_name-ZZZKNAME.

write : / gs_zedt09_06_diff_name-ZZZENAME.

write : / gs_zedt09_06_diff_name-ZZZGENDER.

write : / gs_zedt09_06_diff_name-ZZZTEL.