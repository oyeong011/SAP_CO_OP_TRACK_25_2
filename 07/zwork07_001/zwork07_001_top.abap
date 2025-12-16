
*&---------------------------------------------------------------------*

*&  Include           ZWORK07_001_TOP

*&---------------------------------------------------------------------*






TABLES : ztcurr07, sscrfields. "## ### ##### ## ## ### ###



DATA : BEGIN OF gs_tcurr,

  kurst LIKE ztcurr07-kurst,

  fcurr LIKE ztcurr07-fcurr,

  tcurr LIKE ztcurr07-tcurr,

  gdatu LIKE ztcurr07-gdatu,

  ukurs LIKE ztcurr07-ukurs,

  ffact LIKE ztcurr07-ffact,

  tfact LIKE ztcurr07-tfact,

  crname TYPE crnam,

  crdate TYPE crdat,

  END OF gs_tcurr.



DATA : g_function_key TYPE smp_dyntxt.

SELECTION-SCREEN : FUNCTION KEY 1. "### ### ##



DATA : gt_tcurr LIKE TABLE OF gs_tcurr.



DATA : t_raw_excel TYPE TABLE OF alsmex_tabline, "#### #### ## ## #### ###

       s_raw_excel TYPE alsmex_tabline.



DATA : ok_code TYPE sy-ucomm. "### OK_CODE



DATA : gc_docking TYPE REF TO cl_gui_docking_container. "## ####



DATA : gc_grid TYPE REF TO cl_gui_alv_grid. "###



DATA : gs_variant TYPE disvariant.



DATA : gs_fieldcat TYPE lvc_s_fcat. "###

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo. "####



DATA : gs_sort TYPE lvc_s_sort. "##

DATA : gt_sort TYPE lvc_t_sort.



"### ## ##

DATA : gs_key TYPE wwwdatatab.

DATA : gv_file TYPE string,

       gv_path TYPE string,

       gv_fullpath TYPE string.

DATA : gv_dest TYPE rlgrap-filename VALUE 'C:\'.



DATA : go_event TYPE REF TO event. "### ## ## ##