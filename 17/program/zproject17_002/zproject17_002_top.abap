
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_002_TOP

*&---------------------------------------------------------------------*






TYPE-POOLS: lvc.



" DB ###

TABLES: zmara17,        " ##### (##, ### ##)

        zedt17_ekko,    " PO ##

        zedt17_ekpo,    " PO ###

        zedt17_lfm1.    " ####### (#### ###)



" ## ##

CONSTANTS: c_mode_create TYPE c VALUE 'C',   " ##

           c_mode_disp   TYPE c VALUE 'D'.   " ##



" ## ##

DATA: gv_mode TYPE c.



" ZMARA17 # # ## / ##### (## # ##)

TYPES: ty_mara TYPE zmara17.



DATA: gt_mara TYPE STANDARD TABLE OF ty_mara WITH DEFAULT KEY,

      gs_mara TYPE ty_mara.



" PO ## DB# ## / #####

TYPES: ty_ekko TYPE zedt17_ekko.



DATA: gt_ekko TYPE STANDARD TABLE OF ty_ekko WITH DEFAULT KEY,

      gs_ekko TYPE ty_ekko.



" PO ### DB# ## / #####

"   (DB##, SELECT ## ##)

TYPES: ty_ekpo TYPE zedt17_ekpo.



DATA: gt_ekpo TYPE STANDARD TABLE OF ty_ekpo WITH DEFAULT KEY,

      gs_ekpo TYPE ty_ekpo.





" PO ### ALV ## ##

"   - ### ### ### ## # ##

"   - ### ## ### ##

TYPES: BEGIN OF ty_ekpo_alv,

         ebelp  TYPE zedt17_ekpo-ebelp,   " ##       (ZEDT17_EKPO-EBELP)

         zmatnr TYPE zedt17_ekpo-zmatnr,  " ####   (ZEDT17_EKPO-ZMATNR)

         maktx  TYPE zedt17_ekpo-maktx,       " ###     (ZEDT17_EKPO-MAKTX)

         menge  TYPE zedt17_ekpo-menge,   " PO##     (ZEDT17_EKPO-MENGE)

         stprs  TYPE zedt17_ekpo-stprs,   " ##       (ZEDT17_EKPO-STPRS)

         meins  TYPE zedt17_ekpo-meins,   " ##       (ZEDT17_EKPO-MEINS)

         waers  TYPE zmara17-waers,       " ##       (ZMARA17-WAERS)

         mwskz  TYPE zedt17_lfm1-mwskz,   " ####   (ZEDT17_LFM1-MWSKZ)

         prdat  TYPE zedt17_ekpo-prdat,   " ###     (ZEDT17_EKPO-PRDAT)

         zwerks TYPE zedt17_ekpo-zwerks,  " ###     (ZEDT17_EKPO-ZWERKS)

         zlgort TYPE zedt17_ekpo-zlgort,  " ####   (ZEDT17_EKPO-ZLGORT)

       END OF ty_ekpo_alv.



" ALV# ##### / #####

DATA: gt_ekpo_alv TYPE STANDARD TABLE OF ty_ekpo_alv WITH DEFAULT KEY,

      gs_ekpo_alv TYPE ty_ekpo_alv.



" ALV ## ####

DATA: go_container TYPE REF TO cl_gui_custom_container,

      go_alv       TYPE REF TO cl_gui_alv_grid,

      go_handler   TYPE REF TO lcl_event_handler.



" ALV ######/####

DATA: gt_fcat   TYPE lvc_t_fcat,

      gs_fcat   TYPE lvc_s_fcat,

      gs_layout TYPE lvc_s_layo,

      gs_stbl   TYPE lvc_s_stbl.



" OK ##

DATA: ok_code TYPE sy-ucomm.

DATA: gv_code TYPE sy-ucomm.



" ## ### ###

DATA: gv_cre_active_flag  TYPE c,

      gv_disp_active_flag TYPE c.



DATA: gv_bukrs_disp TYPE ekko-bukrs,

      gv_lifnr_disp TYPE ekko-lifnr,

      gv_bedat_disp TYPE ekko-bedat,

      gv_ekorg_disp TYPE ekko-ekorg,

      gv_ekgrp_disp TYPE ekko-ekgrp,

      gv_waers_disp TYPE ekko-waers.