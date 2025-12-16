
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_001_TOP

*&---------------------------------------------------------------------*






TYPE-POOLS: icon, lvc.



" DB ### ##

TABLES: zedt17_lfa1,    " #####

        zedt17_lfb1,    " #######

        zedt17_lfm1.    " #######.



" #####(LFA1) ##

TYPES: BEGIN OF ty_lfa1,

         lifnr TYPE zedt17_lfa1-lifnr,   " #####

         name1 TYPE zedt17_lfa1-name1,   " ####

         land1 TYPE zedt17_lfa1-land1,   " ###

         ktokk TYPE zedt17_lfa1-ktokk,   " #####

         stcd1 TYPE zedt17_lfa1-stcd1,   " ####

         stcd2 TYPE zedt17_lfa1-stcd2,   " #####

         stras TYPE zedt17_lfa1-stras,   " ##

       END OF ty_lfa1.



" #######(LFB1) ##

TYPES: BEGIN OF ty_lfb1,

         lifnr TYPE zedt17_lfb1-lifnr,   " #####

         bukrs TYPE zedt17_lfb1-bukrs,   " ####

         loevm TYPE zedt17_lfb1-loevm,   " #####

         akont TYPE zedt17_lfb1-akont,   " ####

         zterm TYPE zedt17_lfb1-zterm,   " ####

       END OF ty_lfb1.



" #######(LFM1) ##

TYPES: BEGIN OF ty_lfm1,

         lifnr TYPE zedt17_lfm1-lifnr,   " #####

         ekorg TYPE zedt17_lfm1-ekorg,   " ####

         ekgrp TYPE zedt17_lfm1-ekgrp,   " ####

         loevm TYPE zedt17_lfm1-loevm,   " #####

         waers TYPE zedt17_lfm1-waers,   " ##

         mwskz TYPE zedt17_lfm1-mwskz,   " ####

       END OF ty_lfm1.



" #### ALV# ## (##+####+#### ##)

TYPES: BEGIN OF ty_vend_cre,

         lifnr TYPE zedt17_lfa1-lifnr,   " #####(####)

         bukrs TYPE zedt17_lfb1-bukrs,   " ####

         ktokk TYPE zedt17_lfa1-ktokk,   " ####

         name1 TYPE zedt17_lfa1-name1,   " ##

         land1 TYPE zedt17_lfa1-land1,   " ##

         stcd1 TYPE zedt17_lfa1-stcd1,   " ####

         stcd2 TYPE zedt17_lfa1-stcd2,   " #####

         stras TYPE zedt17_lfa1-stras,   " ##

         akont TYPE zedt17_lfb1-akont,   " ####

         zterm TYPE zedt17_lfb1-zterm,   " ####

         ekorg TYPE zedt17_lfm1-ekorg,   " ####

         ekgrp TYPE zedt17_lfm1-ekgrp,   " ####

         waers TYPE zedt17_lfm1-waers,   " ##

         mwskz TYPE zedt17_lfm1-mwskz,   " ####

       END OF ty_vend_cre.



" ##### / work ares

DATA: gt_lfa1 TYPE STANDARD TABLE OF ty_lfa1,

      gs_lfa1 TYPE ty_lfa1,

      gt_lfb1 TYPE STANDARD TABLE OF ty_lfb1,

      gs_lfb1 TYPE ty_lfb1,

      gt_lfm1 TYPE STANDARD TABLE OF ty_lfm1,

      gs_lfm1 TYPE ty_lfm1.



" #### ALV#

DATA: gt_vend_cre TYPE STANDARD TABLE OF ty_vend_cre,

      gs_vend_cre TYPE ty_vend_cre.



" ## ### (C: ##, D: ##)

DATA: gv_mode TYPE c.



CONSTANTS: c_mode_create TYPE c VALUE 'C',

           c_mode_disp   TYPE c VALUE 'D'.



" selection-screen ### ###

DATA: gv_cre_active_flag  TYPE c,   " ##### ### ## ## ##

      gv_disp_active_flag TYPE c.   " ##### ### ## ## ##.



" ALV / #### ##

DATA: go_container TYPE REF TO cl_gui_custom_container,

      go_alv       TYPE REF TO cl_gui_alv_grid,

      go_handler   TYPE REF TO lcl_event_handler.



DATA: gt_fieldcat TYPE lvc_t_fcat,

      gs_fieldcat TYPE lvc_s_fcat,

      gs_layout   TYPE lvc_s_layo,

      gs_stbl     TYPE lvc_s_stbl.



" ### OK_CODE

DATA: ok_code TYPE sy-ucomm.



" ###### #### ## ##

DATA: gv_disp_hide_save TYPE c.