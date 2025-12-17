
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_003_TOP

*&---------------------------------------------------------------------*

*& ## ### ###

*&---------------------------------------------------------------------*






TABLES : zpro11_004, zpro11_005, zpro11_006, zpro11_007.

" zpro11_004: #### ##

" zpro11_005: #### ##

" zpro11_006: #### ##

" zpro11_007: #### ##






*----------------------------------------------------------------------*

* ##### ## ###

*----------------------------------------------------------------------*




DATA : BEGIN OF gs_po_item,

         check TYPE char1,

         ebeln TYPE zpro11_007-ebeln,

         ebelp TYPE zpro11_005-ebelp,

         lifnr TYPE zpro11_007-lifnr,

         bedat TYPE zpro11_004-bedat,

         matnr TYPE zpro11_005-matnr,

         maktx TYPE zpro11_005-maktx,

         menge TYPE zpro11_007-menge,

         meins TYPE zpro11_007-meins,

         bukrs TYPE zpro11_004-bukrs,

         bprme TYPE zpro11_005-bprme,

         waers TYPE zpro11_007-waers,

         prdat TYPE zpro11_005-prdat,

         werks TYPE zpro11_007-werks,

         lgort TYPE zpro11_007-lgort,

       END OF gs_po_item.



DATA : gt_po_items LIKE TABLE OF gs_po_item.






*----------------------------------------------------------------------*

* ### ### ### # ###

*----------------------------------------------------------------------*




DATA : gs_itm_005 LIKE zpro11_005,

       gt_itm_005 LIKE TABLE OF gs_itm_005.



DATA : gs_hdr_006 LIKE zpro11_006,

       gt_hdr_006 LIKE TABLE OF gs_hdr_006.



DATA : gs_dtl_007 LIKE zpro11_007,

       gt_dtl_007 LIKE TABLE OF gs_dtl_007.






*----------------------------------------------------------------------*

* ##### ###

*----------------------------------------------------------------------*




DATA : BEGIN OF gs_gr_hist.

         INCLUDE STRUCTURE gs_dtl_007.

DATA :   check TYPE c,

       END OF gs_gr_hist.



DATA : gt_gr_hist LIKE TABLE OF gs_gr_hist.






*----------------------------------------------------------------------*

* ALV ## #### # ###

*----------------------------------------------------------------------*




DATA : go_dock TYPE REF TO cl_gui_docking_container,

       go_alv  TYPE REF TO cl_gui_alv_grid.



DATA : gs_vari TYPE disvariant,

       gs_fcat TYPE lvc_s_fcat,

       gt_fcat TYPE lvc_t_fcat,

       gs_layo TYPE lvc_s_layo,

       gs_sort TYPE lvc_s_sort,

       gt_sort TYPE lvc_t_sort.






*----------------------------------------------------------------------*

* ### ##

*----------------------------------------------------------------------*




DATA : gv_okcode TYPE sy-ucomm.