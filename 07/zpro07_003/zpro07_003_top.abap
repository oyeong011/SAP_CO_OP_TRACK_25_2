
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_003_TOP

*&---------------------------------------------------------------------*






TABLES : zpro07_004, zpro07_005, zpro07_006, zpro07_007.

"#### #### ##, #### ##, #### ##, #### ##.



DATA : BEGIN OF gs_store,

  check TYPE char1, "####

  ebeln TYPE zpro07_007-ebeln, "######

  ebelp TYPE zpro07_005-ebelp, "##

  lifnr TYPE zpro07_007-lifnr, "#####

  bedat TYPE zpro07_004-bedat, "###

  matnr TYPE zpro07_005-matnr, "####

  maktx TYPE zpro07_005-maktx, "###

  menge TYPE zpro07_007-menge, "##

  meins TYPE zpro07_007-meins, "##

  bukrs TYPE zpro07_004-bukrs, "####

  bprme TYPE zpro07_005-bprme, "##

  waers TYPE zpro07_007-waers, "##

  prdat TYPE zpro07_005-prdat, "###

  werks TYPE zpro07_007-werks, "###

  lgort TYPE zpro07_007-lgort, "####

  END OF gs_store.



  DATA : gt_store LIKE TABLE OF gs_store.



  DATA : gs_005 LIKE zpro07_005,

         gt_005 LIKE TABLE OF gs_005.



  DATA : gs_006 LIKE zpro07_006,

         gt_006 LIKE TABLE OF gs_006.



  DATA : gs_007 LIKE zpro07_007.

  DATA : gt_007 LIKE TABLE OF gs_007.



  "##### ### ###

  DATA : BEGIN OF gs_field_007.

         INCLUDE STRUCTURE gs_007.

         DATA : check TYPE c,

         END OF gs_field_007.



  DATA : gt_field_007 LIKE TABLE OF gs_field_007.



  DATA : ok_code TYPE sy-ucomm.



  DATA : gc_docking TYPE REF TO cl_gui_docking_container.

  DATA : gc_grid TYPE REF TO cl_gui_alv_grid.

  DATA : gs_variant TYPE disvariant.

  DATA : gs_fieldcat TYPE lvc_s_fcat.

  DATA : gt_fieldcat TYPE lvc_t_fcat.

  DATA : gs_layout TYPE lvc_s_layo.

  DATA : gs_sort TYPE lvc_s_sort.

  DATA : gt_sort TYPE lvc_t_sort.