
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_002_TOP

*&---------------------------------------------------------------------*

*& #### ######, ######, #####, #######




TABLES : zpro11_004, zpro11_005, zpro11_010, zpro11_003.



DATA : ok_code TYPE sy-ucomm.



DATA : BEGIN OF gs_item,

  ebelp  TYPE zpro11_005-ebelp,     "##

  zmatnr TYPE zpro11_010-zmatnr,    "####

  zmaktx TYPE zpro11_010-zmatname,  "###

  menge  TYPE zpro11_005-menge,     "PO##

  stprs  TYPE zpro11_010-stprs,     "##

  meins  TYPE zpro11_010-meins,     "##

  waers  TYPE zpro11_003-waers,     "##

  mwskz  TYPE zpro11_003-mwskz,     "####

  prdat  TYPE zpro11_005-prdat,     "###

  zwerks TYPE zpro11_010-zwerks,    "###

  zlgort TYPE zpro11_010-zlgort,    "####

  END OF gs_item.



DATA : gt_item LIKE TABLE OF gs_item.



DATA : go_dock TYPE REF TO cl_gui_docking_container.

DATA : go_grid TYPE REF TO cl_gui_alv_grid.



DATA : gs_variant TYPE disvariant.

DATA : gs_fcat TYPE lvc_s_fcat.

DATA : gt_fcat TYPE lvc_t_fcat.

DATA : gs_layo TYPE lvc_s_layo.

DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.



DATA : gs_header LIKE zpro11_004.

DATA : gt_header LIKE TABLE OF gs_header.

DATA : gs_detail LIKE zpro11_005.

DATA : gt_detail LIKE TABLE OF gs_detail.



DATA : go_handler TYPE REF TO lcl_event.