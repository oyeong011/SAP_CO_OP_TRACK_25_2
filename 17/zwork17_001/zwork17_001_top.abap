
*&---------------------------------------------------------------------*

*&  Include           ZWORK17_001_TOP

*&---------------------------------------------------------------------*






TABLES: ztcurr17.                         " ## DB ###



CONSTANTS: c_kurst TYPE tcurr-kurst VALUE 'M'.     " ####(M)



DATA: ok_code TYPE sy-ucomm.              " ## OK-CODE



DATA: gc_docking TYPE REF TO cl_gui_docking_container.   " ALV ## ####

DATA: gc_grid    TYPE REF TO cl_gui_alv_grid.            " ALV Grid ##

DATA: go_event   TYPE REF TO event.                      " ALV ### ###



DATA: gs_variant TYPE disvariant.         " ALV variant ##

DATA: gs_fieldcat TYPE lvc_s_fcat,        " ###### ###

      gt_fieldcat TYPE lvc_t_fcat,        " ###### ###

      gs_layout   TYPE lvc_s_layo,        " ALV layout ##

      gs_sort     TYPE lvc_s_sort,        " ## ## ###

      gt_sort     TYPE lvc_t_sort.        " ## ## ###



" ## ALV ### ##/###

TYPES: BEGIN OF ty_rate,

         kurst   TYPE tcurr-kurst,          " ####

         fcurr   TYPE tcurr-fcurr,          " from ##

         tcurr   TYPE tcurr-tcurr,          " to ##(DB ###)

         ukurs_c TYPE char20,            " ALV ##/### ### ##

         gdatu   TYPE tcurr-gdatu,          " ####

         ukurs   TYPE tcurr-ukurs,          " ## ##(DB ##)

         ffact   TYPE tcurr-ffact,          " ##

         tfact   TYPE tcurr-tfact,          " ##

         ernam   TYPE syuname,              " ### ###

         erdat   TYPE sydatum,              " #### ###

       END OF ty_rate.



DATA: gs_rate TYPE ty_rate,               " ALV ###

      gt_rate TYPE STANDARD TABLE OF ty_rate.   " ALV ## ###



" DB ### ##/###

DATA: gs_rate_db TYPE ztcurr17,           " DB ### ##

      gt_rate_db LIKE TABLE OF ztcurr17.  " DB ### ###



" ALV ## #### ##

DATA: gs_stbl TYPE lvc_s_stbl.            " stable refresh(row/col ##)