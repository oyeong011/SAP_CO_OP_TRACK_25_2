
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_023_TOP

*&---------------------------------------------------------------------*




tables : zedt17_001. "



" append # modify ### ## itab# ## ### #### #! (### ###### #### ### ##)

data: gs_student type zedt17_001.

data: gt_student type table of zedt17_001.



data : ok_code type sy-ucomm." ### ## ### ## -> ###### ## ## ####### ### ####



data : gc_docking type ref to cl_gui_docking_container. " ## ## ##

data : gc_grid type ref to cl_gui_alv_grid. " grid ## ##



data : go_event type ref to event. "### ## ##. gc_event, go_event ## ## ##



data : gs_variant type disvariant. " #### ## ## ##



" class alv(cl_gui_alv_grid)##

" lvc_s_fcat

data : gs_fieldcat type lvc_s_fcat.

data : gt_fieldcat type lvc_t_fcat.

data : gs_layout type lvc_s_layo.

data : gs_sort type lvc_s_sort.

data : gt_sort type lvc_t_sort.