
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_003_TOP

*&---------------------------------------------------------------------*




TYPE-POOLS: lvc.



TABLES: zedt17_ekko,

        zedt17_ekpo,

        zedt17_mkpf.






* #### ## ### (5000000000 ## 1# ##)




CONSTANTS: gc_mblnr_start TYPE zedt17_mkpf-mblnr VALUE '5000000000'.



" ## ##

CONSTANTS: c_mode_recv TYPE c VALUE 'R',   " ####(Receipt)

           c_mode_disp TYPE c VALUE 'D'.   " ####(Display)



" ## ##

DATA: gv_mode TYPE c.



" ## ### ### (MODIF ID C1 ###)

DATA: gv_recv_active_flag TYPE c,

      gv_disp_active_flag TYPE c.



" ALV #### ##

DATA: go_container TYPE REF TO cl_gui_custom_container,

      go_alv       TYPE REF TO cl_gui_alv_grid.



" ok## / ####

DATA : ok_code TYPE sy-ucomm,

       gv_code TYPE sy-ucomm.



" #### ALV # # ##

TYPES: BEGIN OF ty_gr_alv,

         l_check    TYPE c LENGTH 1,           " ####



         ebeln      TYPE zedt17_ekpo-ebeln,    " ####

         ebelp      TYPE zedt17_ekpo-ebelp,    " ##

         lifnr      TYPE zedt17_ekko-lifnr,    " ###

         bedat      TYPE zedt17_ekko-bedat,    " ###



         zmatnr     TYPE zedt17_ekpo-zmatnr,   " #### :contentReference[oaicite:0]{index=0}

         maktx      TYPE zedt17_ekpo-maktx,    " ###



         menge      TYPE zedt17_ekpo-menge,    " PO##(## PO ##)

         gr_menge   TYPE zedt17_mseg-menge,    " ##### (MSEG ##)

         open_menge TYPE zedt17_ekpo-menge,    " ####(= PO - ###)

         recv_menge TYPE zedt17_ekpo-menge,    " ######(### ##)



         meins      TYPE zedt17_ekpo-meins,    " ##




*         bprme      TYPE zedt17_ekpo-bprme,    " #### -> bprme### ###. ### stprs ##




         stprs      TYPE zedt17_ekpo-stprs,    " ####

         waers      TYPE zedt17_ekko-waers,    " ##

         prdat      TYPE zedt17_ekpo-prdat,    " ###

         zwerks     TYPE zedt17_ekpo-zwerks,   " ###

         zlgort     TYPE zedt17_ekpo-zlgort,   " ####

       END OF ty_gr_alv.



DATA: gt_gr_alv TYPE STANDARD TABLE OF ty_gr_alv WITH DEFAULT KEY,

      gs_gr_alv TYPE ty_gr_alv.





" ALV ###### / ####

DATA: gt_fcat   TYPE lvc_t_fcat,

      gs_fcat   TYPE lvc_s_fcat,

      gs_layout TYPE lvc_s_layo,

      gs_stbl   TYPE lvc_s_stbl.



" ## ##




*DATA: gv_mblnr TYPE zedt17_mkpf-mblnr,

*      gv_mjahr TYPE zedt17_mkpf-mjahr




DATA: gv_budat TYPE zedt17_mkpf-budat.





"------------------------------------------------------------

" SCREEN 200(####) ## ALV ####/###

"------------------------------------------------------------

DATA: go_container_200 TYPE REF TO cl_gui_custom_container,

      go_alv_200       TYPE REF TO cl_gui_alv_grid.



DATA: gt_fcat_200   TYPE lvc_t_fcat,

      gs_fcat_200   TYPE lvc_s_fcat,

      gs_layout_200 TYPE lvc_s_layo.



TYPES: BEGIN OF ty_gr_disp,

         l_check TYPE c LENGTH 1,              " ## ##



         mblnr   TYPE zedt17_mkpf-mblnr,       " ####

         mjahr   TYPE zedt17_mkpf-mjahr,       " ##

         zeile   TYPE zedt17_mseg-zeile,       " ##



         budat   TYPE zedt17_mkpf-budat,       " ###

         ebeln   TYPE zedt17_mseg-ebeln,       " ####

         lifnr   TYPE zedt17_mseg-lifnr,       " ###



         matnr   TYPE zedt17_mseg-matnr,       " ##

         maktx   TYPE zedt17_ekpo-maktx,       " ###(PO##)

         menge   TYPE zedt17_mseg-menge,       " ####

         meins   TYPE zedt17_mseg-meins,       " ##

         werks   TYPE zedt17_mseg-werks,       " ###

         lgort   TYPE zedt17_mseg-lgort,       " ####

         waers   TYPE zedt17_mseg-waers,       " ##

       END OF ty_gr_disp.



DATA: gt_gr_disp TYPE STANDARD TABLE OF ty_gr_disp WITH DEFAULT KEY,

      gs_gr_disp TYPE ty_gr_disp.



DATA: go_evt_rcv TYPE REF TO lcl_alv_event_receiver.