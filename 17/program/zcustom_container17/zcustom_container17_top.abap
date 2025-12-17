
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER17_TOP

*&---------------------------------------------------------------------*






tables : zedt17_001.






*data : begin of gs_student,

*  zcolor(4),

*  zcode like zedt17_001-zcode, "####

*  zpernr like zedt17_001-zpernr, "####

*  zkname like zedt17_001-zkname, "##

*  zename like zedt17_001-zename, "###

*  zgender like zedt17_001-zgender, "##

*  zsum like zedt17_002-zsum, "##

*  zmajor like zedt17_004-zmajor, "##

*  zmname like zedt17_004-zmname, "###

*  end of gs_student.

*  data : gt_student like table of gs_student.




data : gs_student type zedt17_001.

data : gt_student like table of gs_student.



" ### ## ### ## -> ###### ## ## ####### ### ####

data : ok_code type sy-ucomm.



" #### ##

data : gc_custom type ref to cl_gui_custom_container.



" ### ##

data : gc_grid type ref to cl_gui_alv_grid.



" function alv(reuse_alv_grid_display) ## (class#### ## ##)




*data : gs_fieldcat type slis_fieldcat_alv.

*data : gt_fieldcat type slis_t_fieldcat_alv.

*data : gs_layout type slis_layout_alv.

*data : gs_sort type slis_sortinfo_alv.

*data : gt_sort type slis_t_sortinfo_alv.






" class alv(cl_gui_alv_grid) ##

" lvc_s_fcat

data : gs_fieldcat type lvc_s_fcat.

data : gt_fieldcat type lvc_t_fcat.

data : gs_layout type lvc_s_layo.

data : gs_sort type lvc_s_sort.

data : gt_sort type lvc_t_sort.