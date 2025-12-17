
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_004_TOP

*&---------------------------------------------------------------------*

*& ### ### ###

*&---------------------------------------------------------------------*






" ### ## - #### ##/##, #### ##/##

TABLES : zpro11_006, zpro11_007, zpro11_008, zpro11_009.



" ## ### ## ###

DATA : BEGIN OF gs_inv_item,

         sel_flag TYPE c LENGTH 1,       "## ####

         comp_cd  TYPE zpro11_009-bukrs, "####

         po_num   TYPE zpro11_009-ebeln, "######

         po_item  TYPE zpro11_009-ebelp, "########

         mat_num  TYPE zpro11_009-matnr, "####

         doc_item TYPE zpro11_009-buzei, "######

         net_amt  TYPE bsik-dmbtr,       "####

         tax_amt  TYPE bsik-mwsts,       "##

         tot_amt  TYPE bsik-dmbtr,       "###

         curr_key TYPE zpro11_007-waers, "###

         tax_cd   TYPE bsik-mwskz,       "####

         desc_txt TYPE bsik-sgtxt,       "#####

         vendor   TYPE zpro11_007-lifnr, "####

         ord_unit TYPE zpro11_009-bstme, "####

         qty      TYPE zpro11_007-menge, "##

         base_uom TYPE zpro11_007-meins, "####

       END OF gs_inv_item.

DATA : gt_inv_item LIKE TABLE OF gs_inv_item.



" ### ## ### # #####

DATA : gw_hdr_006 LIKE zpro11_006,

       gt_hdr_006 LIKE TABLE OF gw_hdr_006.



DATA : gw_itm_007 LIKE zpro11_007,

       gt_itm_007 LIKE TABLE OF gw_itm_007.



DATA : gw_inv_hdr LIKE zpro11_008,

       gt_inv_hdr LIKE TABLE OF gw_inv_hdr.



DATA : gw_inv_itm LIKE zpro11_009,

       gt_inv_itm LIKE TABLE OF gw_inv_itm.



" ### ### (#### ##)

DATA : BEGIN OF gs_search_009.

         include structure
zpro11_009
.

DATA :   sel_flag TYPE c LENGTH 1,

       END OF gs_search_009.

DATA : gt_search_009 LIKE TABLE OF gs_search_009.



" ### ##

DATA : gv_okcode TYPE sy-ucomm.



" ALV ## ## # ###

DATA : go_dock_cont TYPE REF TO cl_gui_docking_container,

       go_alv_grid  TYPE REF TO cl_gui_alv_grid.



DATA : gs_layo    TYPE lvc_s_layo,

       gs_vari    TYPE disvariant,

       gs_fcat    TYPE lvc_s_fcat,

       gt_fcat    TYPE lvc_t_fcat,

       gs_sorting TYPE lvc_s_sort,

       gt_sorting TYPE lvc_t_sort.