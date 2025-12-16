
*&---------------------------------------------------------------------*

*& Report ZEDR17_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_011.






* [Subroutine]

* - Perform

* perform [form_name] " subroutine ###

* form [form_name] ~ end form. " form ## ##

* ##: ##### ###, ###, ### ###

* ### ##: ##_### ex) get_data

* function## ##: perform# #### ### #### #, function# ## #### #### # ##






data : begin of gs_student.

    include structure
zedt17_001
.

data : end of gs_student.

data : gt_student like table of gs_student.



data : gv_zcode like zedt17_001-zcode.

data : gv_zkname like zedt17_001-zkname.



data : gv_flag.






*gv_zcode = 'SSU-02'.






" perform ##




*perform get_data using gv_zcode gv_zkname. " -> actual param (#### ## ###)

*write : /, '[perfom ## #]', / gv_zcode, gv_zkname.

*

*write : /, '[perfom ## #]', / gv_zcode, gv_zkname.






" perform ##




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*form get_data using p_zcode p_zkname. " -> formal param (###)

** write : / 'perform test'.

*  data : lv_zcode like zedt17_001-zcode. " subroutine ## ###### local variable. endform## ##

*  lv_zcode = 'SSU-01'.

*

*  select single zkname from zedt17_001

*    into p_zkname

*    where zcode = p_zcode.

*

*  p_zcode = lv_zcode.

**  write : / p_zcode, p_zkname.

*endform.






" perform ## - using value

" using value# ### ##, p_zcode# ### # ### ### ###

" #, subroutine ### ## #### ## ### ## ### ## ## ### ### actual param# ###




*form get_data using value(p_zcode) p_zkname. " -> formal param (###)

*  data : lv_zcode like zedt17_001-zcode. " subroutine ## ###### local variable. endform## ##

*  lv_zcode = 'SSU-01'.

*

*  select single zkname from zedt17_001

*    into p_zkname

*    where zcode = p_zcode.

*

*  p_zcode = lv_zcode.

*  write : '[perfom ##]' , / p_zcode, p_zkname.

*endform.





********************************************************************************

** changing

*gv_zcode = 'SSU-01'.

*

*" perform ## - changing

*perform get_data using gv_zcode " using: ### ##

*                 changing gv_zkname. " changing: ### ## # ## (value ### #### ##### for ###

*

*write : /, '[perfom ## #]', / gv_zcode, gv_zkname.

*

*" perfom ## - changing

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*form get_data using p_zcode " using# ### ### ##. call by reference### ## #### # ### ## ## ### ##### ### ## ##

*              changing value(p_zkname). " changing: ### ## # ##### #. value()# ##### ### ### # ## ###, ### ## (c.b.ref->## ##, c.b.value->endform# ##)

*  select single zkname from zedt17_001

*    into p_zkname

*    where zcode = p_zcode.

*  p_zcode = 'ssu-02'.

*  p_zkname = 'test'.

*  write : '[perfom ##]' , / p_zcode, p_zkname.

*endform.



**#### ##**********************************************************************************

*data: gv_var1 type c length 10 value '##1',

*      gv_var2 type c length 10 value '##2',

*      gv_var3 type c length 10 value '##3',

*      gv_var4 type c length 10 value '##4'.

*

*write: / '## #:'.

*write: / gv_var1, gv_var2, gv_var3, gv_var4.

*uline.

*

*perform test_subroutine using    gv_var1 gv_var3

*                        changing gv_var2 gv_var4.

*

*write: / '## #:'.

*write: / gv_var1, gv_var2, gv_var3, gv_var4.

*uline.

*

*form test_subroutine using    p_var1            " call by reference (#### # ## # ### ## ##)

*                              value(p_var3)     " call by value

*                     changing p_var2              " call by reference

*                            value(p_var4).      " call by value

*

*  write: / '#### ## (## #):'.

*  write: / p_var1, p_var2, p_var3, p_var4.

*

*  p_var1 = '##1'. " using(##) -> ## gv_var1 ## ###. using# ### ### ##### #### # ### ## X

*  p_var2 = '##2'. " changing(##) -> ## gv_var2 ## ###

*  p_var3 = '##3'. " using(#) -> #### p_var3# '##3'# #. ## gv_var3# ## ### ##

*  p_var4 = '##4'. " changing(#) -> #### p_var4# '##4'# #. FORM ## ### ## gv_var4# # ## ###

*

*  write: / '#### ## (## #):'.

*  write: / p_var1, p_var2, p_var3, p_var4.

*  uline.

*

*endform.





******************************************************************************************




" parameter type ## - type, like

" ##### ## X -> generic type## ####, actual parameter# ### ## ####



gv_zcode = 'SSU-01'.

perform get_data using gv_zcode

                  changing gv_zkname.

write : /, '[perfom ## #]', / gv_zcode, gv_zkname.



" perfom ##




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*form get_data using p_zcode type c " actual parameter# ## ## ##

*              changing type c. " actual parameter# ## ## ##

*  select single zkname from zedt17_001

*    into p_zkname

*    where zcode = p_zcode.

*endform.






form get_data using p_zcode like zedt17_001-zcode " actual parameter# ## ### ## ##

              changing p_zkname like zedt17_001-zkname. " actual parameter# ## ### ## ##

  select single zkname from zedt17_001

    into p_zkname

    where zcode = p_zcode.

endform.






******************************************************************************************




" parameter ### - ## ## structure#




*gs_student-zcode = 'SSU-01'.

*perform get_data using gs_student.

*write : /, '[perfom ## #]', / gs_student-zcode, gs_student-zkname.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**      -->P_GS_STUDENT  text

**----------------------------------------------------------------------*

*form get_data  using ps_student structure gs_student. " ### ### ### #### #

*  select single zkname from zedt17_001

*    into ps_student-zkname

*    where zcode = ps_student-zcode.

*endform.



******************************************************************************************




" parameter ### ### - ## ## like#




*perform get_data using gs_student gt_student.

*loop at gt_student into gs_student.

*   write : / gs_student-zcode, gs_student-zkname.

*endloop.

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*      -->P_GT_STUDENT  text

*----------------------------------------------------------------------*

**form get_data  using    ps_student structure gs_student " structure# ##

*form get_data  using    ps_student like gs_student " like# ## (### structure# ### ## ##)

*                        pt_student like gt_student.

*  ps_student-zcode = 'SSU-01'.

*  select single zkname from zedt17_001

*    into ps_student-zkname

*    where zcode = ps_student-zcode.

*  append ps_student to pt_student.

*

*  ps_student-zcode = 'SSU-02'.

*  select single zkname from zedt17_001

*    into ps_student-zkname

*    where zcode = ps_student-zcode.

*  append ps_student to  pt_student.

*endform.

**************************************************************************************






" standard table## & #### ## ##  (## ### ##)




*perform get_data using gt_student.

*loop at gt_student into gs_student.

*   write : / gs_student-zcode, gs_student-zkname.

*endloop.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**      -->P_GT_STUDENT  text

**----------------------------------------------------------------------*

*form get_data  using pt_student type standard table. " stand table## ##

*  data : ls_student like gs_student. " ####

*

*  ls_student-zcode = 'SSU-01'.

*  select single zkname from zedt17_001

*    into ls_student-zkname

*    where zcode = ls_student-zcode.

*  append ls_student to pt_student.

*

*  ls_student-zcode = 'SSU-02'.

*  select single zkname from zedt17_001

*    into ls_student-zkname

*    where zcode = ls_student-zcode.

*  append ls_student to  pt_student.

*endform.






" tables# ## ### ## XXXXXXXXXXXXXXXX




*perform get_data using gt_student.

*loop at gt_student into gs_student.

*   write : / gs_student-zcode, gs_student-zkname.

*endloop.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**      -->P_GT_STUDENT  text

**----------------------------------------------------------------------*

*form get_data  tables pt_student like gt_student.

*  data : ls_student like gs_student. " ####

*

*  ls_student-zcode = 'SSU-01'.

*  select single zkname from zedt17_001

*    into ls_student-zkname

*    where zcode = ls_student-zcode.

*  append ls_student to pt_student.

*

*  ls_student-zcode = 'SSU-02'.

*  select single zkname from zedt17_001

*    into ls_student-zkname

*    where zcode = ls_student-zcode.

*  append ls_student to  pt_student.

*endform.



**************************************************************************************

**************************************************************************************



* Subroutine ##

* 1. Internal - ## abap prog. ## ### subroutine ##

* ### ### ##



* 2. External - ## abap prog. ## ### subroutine ##

* zedr17_012## ######

*perform get_data changing gt_student.

*loop at gt_student into gs_student.

*  write : / gs_student-zcode, gs_student-zkname.

*endloop.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**      <--P_GT_STUDENT  text

**----------------------------------------------------------------------*

*form get_data  changing pt_student like gt_student.

*  data : ls_student like gs_student.

*

*  ls_student-zcode = 'SSU-01'.

*  select single zkname from zedt17_001

*    into ls_student-zkname

*    where zcode = ls_student-zcode.

*  append ls_student to pt_student.

*

*  ls_student-zcode = 'SSU-02'.

*  select single zkname from zedt17_001

*    into ls_student-zkname

*    where zcode = ls_student-zcode.

*  append ls_student to pt_student.

*endform.



* 3. Dynamic - ## ##### subroutine ### ##, ## #### ##

* zedr17_012## ######



* LIST# ### subroutine ## - #### ### index### #### subroutine list ##

* internal subroutine### ##, #### ##

*do 2 times.

*  perform sy-index of sub1 sub2.

*enddo.

*form subr1.

*  write : / sy-index, '## ####'.

*endform.

*form subr2.

*  write : / sy-index, '## ####'.

*endform.



* 4. PERFORM ON COMMIT - commit work# ### #### ## ##

*    PERFORM ON ROLLBACK - rollback work# ### #### ## ##






" zcode='ssu-25'# #### # ##### ## #### ##

" set data




*select single * from zedt17_001

*  into gs_student where zcode = 'SSU-25'.

*

*perform delete_data using gs_student.

*perform insert_data on commit. " commit work# ### insert_data ## ##

*

*if gv_flag = 'X'.

*  write : / 'gv_flag = X'.

*  commit work.

*endif.

**&---------------------------------------------------------------------*

**&      Form  DELETE_DATA

**&---------------------------------------------------------------------*

*form delete_data  using    ps_student like gs_student.

*  write : / 'delete_data ##'.

*  delete zedt17_001 from ps_student. " zcode='SSU-25'# ## ### 1# ###

*  if sy-subrc = 0.

*    gv_flag = 'X'.

*  endif.

*endform.

**&---------------------------------------------------------------------*

**&      Form  INSERT_DATA

**&---------------------------------------------------------------------*

*form insert_data .

*  write : / 'insert_data ##'.

*  insert zedt17_001 from gs_student.

*endform.