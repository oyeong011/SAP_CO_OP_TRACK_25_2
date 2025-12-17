
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_004_TOP

*&---------------------------------------------------------------------*






TABLES : zpro07_006, zpro07_007, zpro07_008, zpro07_009.

"#### #### ##, #### ##, #### ##, #### ##.



DATA : BEGIN OF gs_invoice,

  check TYPE char1, "####

  bukrs TYPE zpro07_009-bukrs, "####

  ebeln TYPE zpro07_009-ebeln, "######

  ebelp TYPE zpro07_009-ebelp, "########

  matnr TYPE zpro07_009-matnr, "####

  buzei TYPE zpro07_009-buzei,

  dmbtr TYPE bsik-dmbtr, "####

  mwsts TYPE bsik-mwsts, "##

  costs TYPE bsik-dmbtr, "## = #### + ##

  waers TYPE zpro07_007-waers, "##

  mwskz TYPE bsik-mwskz, "####

  sgtxt TYPE bsik-sgtxt, "### -> ###### 10## + ####

  lifnr TYPE zpro07_007-lifnr, "###

  bstme TYPE zpro07_009-bstme, "##

  menge TYPE zpro07_007-menge, "##

  meins TYPE zpro07_007-meins, "##

  END OF  gs_invoice.



  DATA : gt_invoice LIKE TABLE OF gs_invoice.



  DATA : gs_006 LIKE zpro07_006,

         gt_006 LIKE TABLE OF gs_006.



  DATA : gs_007 LIKE zpro07_007.

  DATA : gt_007 LIKE TABLE OF gs_007.



  DATA : gs_008 LIKE zpro07_008.

  DATA : gt_008 LIKE TABLE OF gs_008.



  DATA : gs_009 LIKE zpro07_009.

  DATA : gt_009 LIKE TABLE OF gs_009.



"##### ### ###

  DATA : BEGIN OF gs_field_009.

         INCLUDE STRUCTURE gs_009.

         DATA : check TYPE c,

         END OF gs_field_009.



  DATA : gt_field_009 LIKE TABLE OF gs_field_009.



         DATA : ok_code TYPE sy-ucomm.



  DATA : gc_docking TYPE REF TO cl_gui_docking_container.

  DATA : gc_grid TYPE REF TO cl_gui_alv_grid.

  DATA : gs_variant TYPE disvariant.

  DATA : gs_fieldcat TYPE lvc_s_fcat.

  DATA : gt_fieldcat TYPE lvc_t_fcat.

  DATA : gs_layout TYPE lvc_s_layo.

  DATA : gs_sort TYPE lvc_s_sort.

  DATA : gt_sort TYPE lvc_t_sort.