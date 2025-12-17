
*&---------------------------------------------------------------------*

*& Include  ZWORK19_001_TOP

*&---------------------------------------------------------------------*




TABLES: ZTCURR19, sscrfields.



"=== Selection-Screen #### #### ## ===

TYPES: BEGIN OF ty_xl_raw,

         row    TYPE i,

         col    TYPE i,

         value  TYPE string,

       END OF ty_xl_raw.



"=== ## ##(###) : ##/####, ## ===

TYPES: BEGIN OF ty_xl_rate,

         fcurr   TYPE c LENGTH 3,   "####(From Currency)

         tcurr   TYPE c LENGTH 3,   "####(To Currency)

         ukurs   TYPE p LENGTH 8 DECIMALS 5, "##

       END OF ty_xl_rate.



"=== ALV ##/## ##: ####, ##### ## ===

TYPES: BEGIN OF ty_rate,

         kurst   TYPE c LENGTH 1,         "#### (M ##)

         gdatu   TYPE dats,               "####(##### ####)

         fcurr   TYPE c LENGTH 3,

         tcurr   TYPE c LENGTH 3,

         ukurs   TYPE p LENGTH 8 DECIMALS 5,

         changed TYPE abap_bool,          "## ## ##

        ffact TYPE p LENGTH 9 DECIMALS 0,

         tfact TYPE p LENGTH 9 DECIMALS 0,

         crname LIKE ZTCURR19-crname,

         crdate LIKE ZTCURR19-crdate,

       END OF ty_rate.



DATA: gt_xl_raw   TYPE STANDARD TABLE OF ty_xl_raw,

      gs_xl_rate  TYPE TY_rate,

      gt_xl_rate  TYPE STANDARD TABLE OF ty_rate,

      gt_rate     TYPE STANDARD TABLE OF ty_rate,

      gs_rate     TYPE ty_rate.



"=== ALV ####/### ===

DATA: go_dock     TYPE REF TO cl_gui_docking_container,

      go_grid     TYPE REF TO cl_gui_alv_grid.



"######/####

DATA: gt_fcat     TYPE lvc_t_fcat,

      gs_fcat     TYPE lvc_s_fcat,

      gs_layout   TYPE lvc_s_layo.



"### ## ### ##

DATA: gs_stbl     TYPE lvc_s_stbl.



"STATUS# OK_CODE

DATA: ok_code     TYPE syucomm,

      gv_save_ok  TYPE syucomm.



"## ##

CONSTANTS: c_kurst  TYPE c VALUE 'M',           "M ##

           c_fun_sav TYPE syucomm VALUE 'ZSV',  "ALV Toolbar ##

           c_fun_bak TYPE syucomm VALUE 'ZBK'.  "ALV Toolbar ##





DATA: t_raw_excel TYPE STANDARD TABLE OF alsmex_tabline,

      s_raw_excel TYPE alsmex_tabline.



DATA : gv_path TYPE string,

       gv_fullpath TYPE string.

DATA : gv_dest TYPE rlgrap-filename VALUE 'C:\'.