
*&---------------------------------------------------------------------*

*&  Include           ZWORK07_002_TOP

*&---------------------------------------------------------------------*






TABLES : ztcurr07.



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



DATA : gt_tcurr LIKE TABLE OF gs_tcurr.



DATA : ok_code TYPE sy-ucomm. "### ok-code.



DATA : gc_custom TYPE REF TO cl_gui_custom_container. "### ####



DATA : gc_grid TYPE REF TO cl_gui_alv_grid. "###



DATA : gs_variant TYPE disvariant.



DATA : gs_fieldcat TYPE lvc_s_fcat. "###

DATA : gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo. "####



DATA : gs_sort TYPE lvc_s_sort. "##

DATA : gt_sort TYPE lvc_t_sort.