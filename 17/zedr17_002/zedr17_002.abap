
*&---------------------------------------------------------------------*

*& Report ZEDR17_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_002.






** DataType 2 ##

** 3. global data type in abap dictionary



* abap dictionary table #### ###+## ##

* - zedt00_001 ## ##?

*   - ## ### ## ### ### #### ### ## ###### ## ## ##.




data : gs_zedt17 type zedt17_001.

gs_zedt17-zcode = 'SSU-01'.

gs_zedt17-zkname = '###'.

gs_zedt17-zename = 'DONG'.

gs_zedt17-zgender = 'M'.

gs_zedt17-ztel = '01011112222'.



write : / gs_zedt17-zcode, / gs_zedt17-zkname, / gs_zedt17-zename, / gs_zedt17-zgender, / gs_zedt17-ztel.






* abap dictionary table ## ### ## ## ##




data : begin of gs_zedt17_2,

         zcode   type zedt17_001-zcode,

         zkname  type zedt17_001-zkname,

         zename  type zedt17_001-zename,

         zgender type zedt17_001-zgender,

         ztel    type zedt17_001-ztel,

       end of gs_zedt17_2.



gs_zedt17_2-zcode = 'SSU-01'.

gs_zedt17_2-zkname = '###'.

gs_zedt17_2-zename = 'DONG'.

gs_zedt17_2-zgender = 'M'.

gs_zedt17_2-ztel = '01011112222'.



write : / gs_zedt17_2-zcode, / gs_zedt17_2-zkname, / gs_zedt17_2-zename, / gs_zedt17_2-zgender, / gs_zedt17_2-ztel.






* data type# ### type ## - data element

* #### #### ## ### ## ## #### ##




data : begin of gs_zedt17_3,

         zcode   type zcode17,

         zkname  type zkname17,

         zename  type zename17,

         zgender type zgubun17,

         ztel    type ztel17,

       end of gs_zedt17_3.



gs_zedt17_3-zcode = 'SSU-01'.

gs_zedt17_3-zkname = '###'.

gs_zedt17_3-zename = 'DONG'.

gs_zedt17_3-zgender = 'M'.

gs_zedt17_3-ztel = '01011112222'.



write : / gs_zedt17_3-zcode, / gs_zedt17_3-zkname, / gs_zedt17_3-zename, / gs_zedt17_3-zgender, / gs_zedt17_3-ztel.






* data type# ### type ## - structure# ### type ##




data: gs_zeds17 type zeds17_001.



gs_zedt17-zcode = 'SSU-01'.

gs_zedt17-zkname = '###'.

gs_zedt17-zename = 'DONG'.

gs_zedt17-zgender = 'M'.

gs_zedt17-ztel = '01011112222'.



write : / gs_zedt17-zcode, / gs_zedt17-zkname, / gs_zedt17-zename, / gs_zedt17-zgender, / gs_zedt17-ztel.






* data type# ### type ## - type group# ### type ##




data : gs_zedg17 type ztg17_zed17.

data : gv_ztitle type ztg17_ztitle.



gs_zedg17-zcode = 'SSU-01'.

gs_zedg17-zkname = '###'.

gs_zedg17-zename = 'DONG'.

gs_zedg17-zgender = 'M'.

gs_zedg17-ztel = '01011112222'.

gv_ztitle = '####'.



write : / gs_zedg17-zcode, / gs_zedg17-zkname,  / gs_zedg17-zename,  / gs_zedg17-zgender,  / gs_zedg17-ztel,  / gv_ztitle.






******************************************



** DataObjet ## (1, 4# ##)



** 1. move a to b




data : begin of gs_name,

         name1(10),

         name2(10),

       end of gs_name.



gs_name-name1 = '###'.

gs_name-name2 = '##'.

write : / gs_name-name1, / gs_name-name2.






* =# # ##




gs_name-name1 = gs_name-name2. " =# # ## ##

write : / gs_name-name1, / gs_name-name2.






* move a to b# # ##




gs_name-name1 = '###'.

gs_name-name2 = '##'.



move gs_name-name2 to gs_name-name1.

write : / gs_name-name1, / gs_name-name2.






* ### (type conversions) ##




data : begin of gs_name_1,

         name1(10),

         degree1   type p decimals 2,

       end of gs_name_1.



gs_name_1-name1 = '##'.

gs_name_1-degree1 = '35.12'.



move gs_name_1-degree1 to gs_name_1-name1.

condense gs_name_1-name1 no-gaps. " ## ### ## ##

write : / gs_name_1-name1, / gs_name_1-degree1.








** 2. offset# ### # ## - offset and length# # ### ##




data : gv_data1(8) value 'ABCDEFGH',

       gv_data2(8).

data : gv_start  type i value 2,

       gv_length type i value 4.






* ## 1




move gv_data1+2(3) to gv_data2. " 0## #### #####, 2## ##### 3#(CDE) #### gv_data2# ##

write / gv_data2.






* ## 2




move gv_data1+gv_start(gv_length) to gv_data2.

write / gv_data2.






* ## 3




move gv_data1+gv_start(gv_length) to gv_data2+gv_start(gv_length).

write / gv_data2.








** 3. write to - AVL #### write# ## # # ## #



** ## ### ##.

** move# ## a##b# # ## # ## #####,

** move# internal table ## # ### ## # ## ##,

** write to # head->head ##### #### # ### # ##






write gs_name-name2 to gs_name-name1.

write: / gs_name-name1, / gs_name-name2.








** 4. move-corresponding

** ### #### ## ## ## ## ### ##

** ### ### ##### ### ### ## !




data : begin of gs_zedt17_4,

         zcode   type zedt17_001-zcode, " zcode# 1##

         zkname  type zedt17_001-zkname, " zkname# 2##,

         zename  type zedt17_001-zename, " zename# 3##,

         zgender type zedt17_001-zgender, "zgender# 4##

         ztel    type zedt17_001-ztel,

       end of gs_zedt17_4.



data : begin of gs_zedt17_5,

         zgender type zedt17_001-zgender, " zgender# 1##

         zename  type zedt17_001-zename, " zename# 2##,

         zkname  type zedt17_001-zkname, " zkname# 3##



         zcode   type zedt17_001-zcode, " zcode# 4##

         ztel    type zedt17_001-ztel,

       end of gs_zedt17_5.



gs_zedt17_4-zcode = 'SSU-01'.

gs_zedt17_4-zkname = '###'.

gs_zedt17_4-zename = 'DONG'.

gs_zedt17_4-zgender = 'M'.

gs_zedt17_4-ztel = '01011112222'.



move-corresponding gs_zedt17_4 to gs_zedt17_5.



write : / gs_zedt17_5-zcode, / gs_zedt17_5-zkname, / gs_zedt17_5-zename, / gs_zedt17_5-zgender, / gs_zedt17_5-ztel.






** ## move# move-corresponding# ##, ## ## #### # ### ###.## ### ## ## ## ##




move gs_zedt17_4 to gs_zedt17_5.

write /'----------'.

write : / gs_zedt17_5-zcode, / gs_zedt17_5-zkname, / gs_zedt17_5-zename, / gs_zedt17_5-zgender, / gs_zedt17_5-ztel.






** gs_zedt17_4# ### #### ##### move## ### ### ###.

** ### ### ### ### ### ## ###




write /'-----gs_zedt17_6-----'.

data : begin of gs_zedt17_6,

         zzzzcode      type zedt17_001-zcode, " zcode# 1##

         zzzzzkname    type zedt17_001-zkname, " zkname# 2##,

         zzzzzzename   type zedt17_001-zename, " zename# 3##,

         zzzzzzzgender type zedt17_001-zgender, "zgender# 4##

         zzzzzzzzztel  type zedt17_001-ztel,

       end of gs_zedt17_6.



move-corresponding gs_zedt17_4 to gs_zedt17_6. " # ## ### #### ## ### # # ##

write : / gs_zedt17_6-zzzzcode, / gs_zedt17_6-zzzzzkname, / gs_zedt17_6-zzzzzzename, / gs_zedt17_6-zzzzzzzgender, / gs_zedt17_6-zzzzzzzzztel.

write /'----------'.



move gs_zedt17_4 to gs_zedt17_6. " # ## ### ### ### ###

write : / gs_zedt17_6-zzzzcode, / gs_zedt17_6-zzzzzkname, / gs_zedt17_6-zzzzzzename, / gs_zedt17_6-zzzzzzzgender, / gs_zedt17_6-zzzzzzzzztel.

write /'----------'.






** Data object# variable declation (## ## ##)

** 1. Constants

*   ## ### ### .00## ##### ###

*   EX)

*   1.00# ## 100 ### 100### ## ###

*   100# constant# ##### ## ##### ##



* ## ## : ### #




constants : c_rate type i value '100'.

data : gv_sum1 type i,

       gv_sum2 type i,

       gv_sum3 type i.

gv_sum1 = '10.00'. " 1000### ## ### #

gv_sum2 = '20.00'. " 2000### ## ### #

gv_sum3 = '30.00'. " 3000### ## ### #



gv_sum1 = gv_sum1 * c_rate.

gv_sum2 = gv_sum2 * c_rate.

gv_sum3 = gv_sum3 * c_rate.



write : / gv_sum1, / gv_sum2, / gv_sum3.






* ### ##




constants : begin of c_student,

              zcode(10)  value 'SSU-01',

              zkname(10) value '###',

              zename(10) value 'DONG',

            end of c_student.



write : / c_student-zcode, / c_student-zkname, / c_student-zename.






* ## ## vs ### ##

* constant# ### ## ## ### ## -> error




constants : cnum1 type i value '10'.

data : num1 type i value '10'.




*  cnum1 = cnum + 1. " constant ### ## ##

*  write / cnum1.






num1 = num1 + 1.

write / num1.








** 2. STATICS

** #### #### #. perform# function ### ##### ### # ## ###. ####### ## X

*statics lv_num type i.

*lv_num = lv_num + 1.

*write : / 'STATIC Variable : ', lv_num.



** 3. TABLES

*  tables ## ##?

*  sap## ### #### ## ##

*  ####### ####

*  function## table## # # tables## #####

*  but sap### tables## ## ####.

*  function### ## #### ##, program### ## ## ##






tables : zedt17_001.

select single * from zedt17_001.

write : / zedt17_001-zcode, / zedt17_001-zkname, / zedt17_001-zename, / zedt17_001-zgender, / zedt17_001-ztel.



tables : scarr. " scar# z# #### ## => standard system ###.




* ## ### ## #### ### select# #### ###.




select * from scarr.

  write : / scarr-carrid, scarr-carrname.



endselect.