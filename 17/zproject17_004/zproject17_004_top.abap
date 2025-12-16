
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_004_TOP

*&---------------------------------------------------------------------*




TYPE-POOLS: lvc.



TABLES: zedt17_ekko,

        zedt17_ekpo,

        zedt17_rbkp.



" ## ##

CONSTANTS: c_mode_cre  TYPE c VALUE 'R',   " ####(Create)

           c_mode_disp TYPE c VALUE 'D'.   " ####(Display)



" #### ## ### (5000000000 ## 1# ##)

CONSTANTS: gc_belnr_start TYPE zedt17_rbkp-belnr VALUE '5000000000'.





" ## ##

DATA: gv_mode TYPE c.



" ##### ## (###### ## # # ###)

DATA: gv_budat TYPE zedt17_rbkp-budat.





DATA: go_container TYPE REF TO cl_gui_custom_container,

      go_alv       TYPE REF TO cl_gui_alv_grid.



DATA: ok_code TYPE sy-ucomm,

      gv_code TYPE sy-ucomm.



DATA: gt_fcat   TYPE lvc_t_fcat,

      gs_fcat   TYPE lvc_s_fcat,

      gs_layout TYPE lvc_s_layo.



"------------------------------------------------------------

" ####(Screen 0100) ALV ## ##

" - RSEG ## ## ## ##: EBELN/EBELP/ZMATNR/MAKTX/ZWERKS/MENGE/MEINS/WRBTR/WMWST/MWSKZ/SHKZG

" - PO ##/##### ### ## ##(LIFNR/WAERS/STPRS #)

"------------------------------------------------------------

TYPES: BEGIN OF ty_iv_alv,

         l_check    TYPE c LENGTH 1,



         ebeln      TYPE zedt17_ekpo-ebeln,

         ebelp      TYPE zedt17_ekpo-ebelp,

         lifnr      TYPE zedt17_ekko-lifnr,

         waers      TYPE zedt17_ekko-waers,



         zmatnr     TYPE zedt17_ekpo-zmatnr,

         maktx      TYPE zedt17_ekpo-maktx,

         zwerks     TYPE zedt17_ekpo-zwerks,

         zlgort     TYPE zedt17_ekpo-zlgort,    " ### ## #### ##



         po_menge   TYPE zedt17_ekpo-menge,     " PO ##(##)

         gr_menge   TYPE zedt17_mseg-menge,     " #####(##)

         iv_menge   TYPE zedt17_rseg-menge,     " #####(##)

         open_menge TYPE zedt17_ekpo-menge,     " ######(####)

         inv_menge  TYPE zedt17_ekpo-menge,     " ## ####(####, ### ##)



         meins      TYPE zedt17_ekpo-meins,

         stprs      TYPE zedt17_ekpo-stprs,



         wrbtr      TYPE zedt17_rseg-wrbtr,

         wmwst      TYPE zedt17_rseg-wmwst,

         tot_amt    TYPE zedt17_rseg-wrbtr,

         mwskz      TYPE zedt17_rseg-mwskz,

         shkzg      TYPE zedt17_rseg-shkzg,

       END OF ty_iv_alv.





DATA: gt_iv_alv TYPE STANDARD TABLE OF ty_iv_alv WITH DEFAULT KEY,

      gs_iv_alv TYPE ty_iv_alv.



DATA: go_evt_rcv TYPE REF TO lcl_alv_event_receiver.

DATA: gv_rate TYPE p LENGTH 5 DECIMALS 3.







"------------------------------------------------------------

" SCREEN 200(####) ## ALV ####/###

"------------------------------------------------------------

DATA: go_container_200 TYPE REF TO cl_gui_custom_container,

      go_alv_200       TYPE REF TO cl_gui_alv_grid.



DATA: gt_fcat_200   TYPE lvc_t_fcat,

      gs_fcat_200   TYPE lvc_s_fcat,

      gs_layout_200 TYPE lvc_s_layo.



" ## ALV ## ## (RBKP+RSEG ## ##)

TYPES: BEGIN OF ty_iv_disp,

         l_check TYPE c LENGTH 1,              " ## ##



         belnr   TYPE zedt17_rbkp-belnr,       " ####

         gjahr   TYPE zedt17_rbkp-gjahr,       " ##

         buzei   TYPE zedt17_rseg-buzei,       " ##



         ebeln   TYPE zedt17_rseg-ebeln,       " ####

         ebelp   TYPE zedt17_rseg-ebelp,       " ##



         lifnr   TYPE zedt17_rbkp-lifnr,       " ###(##)

         waers   TYPE zedt17_rbkp-waers,       " ##(##)

         budat   TYPE zedt17_rbkp-budat,       " #####

         bktxt   TYPE zedt17_rbkp-bktxt,       " #####



         zmatnr  TYPE zedt17_rseg-zmatnr,      " ##

         maktx   TYPE zedt17_rseg-maktx,       " ###

         zwerks  TYPE zedt17_rseg-zwerks,      " ###



         menge   TYPE zedt17_rseg-menge,       " ##

         meins   TYPE zedt17_rseg-meins,       " ##



         wrbtr   TYPE zedt17_rseg-wrbtr,       " ####

         wmwst   TYPE zedt17_rseg-wmwst,       " ##

         tot_amt TYPE zedt17_rseg-wrbtr,

         mwskz   TYPE zedt17_rseg-mwskz,       " ####

         shkzg   TYPE zedt17_rseg-shkzg,       " #/#

       END OF ty_iv_disp.



DATA: gt_iv_disp TYPE STANDARD TABLE OF ty_iv_disp WITH DEFAULT KEY,

      gs_iv_disp TYPE ty_iv_disp.