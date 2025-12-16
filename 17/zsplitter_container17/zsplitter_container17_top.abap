
*&---------------------------------------------------------------------*

*&  Include           ZSPLITTER_CONTAINER17_TOP

*&---------------------------------------------------------------------*




tables : zedt17_001.



data : begin of gs_student,

  zcolor(4),

  zcode like zedt17_001-zcode, "####

  zpernr like zedt17_001-zpernr, "####

  zkname like zedt17_001-zkname, "##

  zename like zedt17_001-zename, "###

  zgender like zedt17_001-zgender, "##

  zsum like zedt17_002-zsum, "##

  zmajor like zedt17_004-zmajor, "##

  zmname like zedt17_004-zmname, "###

  end of gs_student.

  data : gt_student like table of gs_student.



  data : ok_code type sy-ucomm." ### ## ### ## -> ###### ## ## ####### ### ####



  data : gc_docking type ref to cl_gui_docking_container. " ## ## ##

  data : gc_splitter type ref to cl_gui_splitter_container.



  data : gc_container1 type ref to cl_gui_container. " container1 ##

  data : gc_container2 type ref to cl_gui_container. " container2 ##



  data : gc_grid1 type ref to cl_gui_alv_grid. " container1# ## grid ## ##

  data : gc_grid2 type ref to cl_gui_alv_grid. " container2# ## grid ## ##



  data : gs_variant type disvariant. " #### ## ## ##



  " class alv(cl_gui_alv_grid)##

  " lvc_s_fcat

  data : gs_fieldcat type lvc_s_fcat.

  data : gt_fieldcat1 type lvc_t_fcat.

  data : gt_fieldcat2 type lvc_t_fcat.



  data : gs_layout type lvc_s_layo.



  data : gs_sort type lvc_s_sort.

  data : gt_sort1 type lvc_t_sort.

  data : gt_sort2 type lvc_t_sort.