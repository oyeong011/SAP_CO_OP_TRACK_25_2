
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_002_TOP

*&---------------------------------------------------------------------*






TABLES : zpro07_004, zpro07_005, zedt07_200, zpro07_003.

"#### ######, ######, #####, #######



DATA : ok_code TYPE sy-ucomm.



DATA : BEGIN OF gs_product,

  ebelp TYPE zpro07_005-ebelp, "##

  zmatnr TYPE zedt07_200-zmatnr, "####

  zmaktx TYPE zedt07_200-zmatname, "###

  menge TYPE zpro07_005-menge, "PO##

  stprs TYPE zedt07_200-stprs, "##

  meins TYPE zedt07_200-meins, "##

  waers TYPE zpro07_003-waers, "##

  mwskz TYPE zpro07_003-mwskz, "####

  prdat TYPE zpro07_005-prdat, "###

  zwerks TYPE zedt07_200-zwerks, "###

  zlgort TYPE zedt07_200-zlgort, "####

  END OF gs_product.



  DATA : gt_product LIKE TABLE OF gs_product.



  DATA : gc_docking TYPE REF TO cl_gui_docking_container.

  DATA : gc_grid TYPE REF TO cl_gui_alv_grid.

  DATA : gs_variant TYPE disvariant.

  DATA : gs_fieldcat TYPE lvc_s_fcat.

  DATA : gt_fieldcat TYPE lvc_t_fcat.

  DATA : gs_layout TYPE lvc_s_layo.

  DATA : gs_sort TYPE lvc_s_sort.

  DATA : gt_sort TYPE lvc_t_sort.



  DATA : gs_004 LIKE zpro07_004.

  DATA : gt_004 LIKE TABLE OF gs_004.



  DATA : gs_005 LIKE zpro07_005.

  DATA : gt_005 LIKE TABLE OF gs_005.



  DATA : go_event TYPE REF TO event.