
*&---------------------------------------------------------------------*

*& Include ZMM11_002_TOP

*&---------------------------------------------------------------------*




TABLES: zmm11_po_head, zmm11_po_item, zmm11_mat_mst, zmm11_org_mst.



" Global Variables

DATA: gv_ucomm   TYPE sy-ucomm,

      gv_ok_code TYPE sy-ucomm.



" ALV Output Structure

TYPES: BEGIN OF ty_display,

         ebelp TYPE zmm11_po_item-ebelp,

         matnr TYPE zmm11_mat_mst-zmatnr,

         maktx TYPE zmm11_mat_mst-zmatname,

         menge TYPE zmm11_mat_mst-menge,

         stprs TYPE zmm11_mat_mst-stprs,

         meins TYPE zmm11_mat_mst-meins,

         waers TYPE zmm11_org_mst-waers,

         mwskz TYPE zmm11_org_mst-mwskz,

         prdat TYPE zmm11_po_item-prdat,

         werks TYPE zmm11_mat_mst-zwerks,

         lgort TYPE zmm11_mat_mst-zlgort,

       END OF ty_display.



DATA: gt_alv_data TYPE TABLE OF ty_display,

      gs_alv_data TYPE ty_display.



" DB Insert Tables

DATA: gt_head_ins TYPE TABLE OF zmm11_po_head,

      gt_item_ins TYPE TABLE OF zmm11_po_item.



" ALV Objects

DATA: go_docker TYPE REF TO cl_gui_docking_container,

      go_grid   TYPE REF TO cl_gui_alv_grid.



" ALV Settings

DATA: gs_layout  TYPE lvc_s_layo,

      gt_fcat    TYPE lvc_t_fcat,

      gs_variant TYPE disvariant.



" Class Definition Deferred

CLASS lcl_event_handler DEFINITION DEFERRED.

DATA: go_handler TYPE REF TO lcl_event_handler.



" [###] ### ## ### ## ## ## (GV_TITLE -> GV_SCR_TITLE)

DATA: gv_scr_title TYPE string,

      gv_scr_txt1  TYPE string,

      gv_scr_txt2  TYPE string.