
*&---------------------------------------------------------------------*

*&  Include           ZWORK17_002_TOP

*&---------------------------------------------------------------------*




TABLES: ztcurr17.



CONSTANTS: c_kurst TYPE tcurr-kurst VALUE 'M'.



DATA: ok_code TYPE sy-ucomm.



" ALV# ## (CUSTOM CONTAINER ##)

DATA: go_cust  TYPE REF TO cl_gui_custom_container,

      go_grid  TYPE REF TO cl_gui_alv_grid,

      go_event TYPE REF TO event.



DATA: gs_fieldcat TYPE lvc_s_fcat,

      gt_fieldcat TYPE lvc_t_fcat,

      gs_layout   TYPE lvc_s_layo,

      gs_variant  TYPE disvariant,

      gs_stbl     TYPE lvc_s_stbl.



" DB ## ##

DATA: BEGIN OF gs_rate_db,

        kurst  TYPE ztcurr17-kurst,

        fcurr  TYPE ztcurr17-fcurr,

        tcurr  TYPE ztcurr17-tcurr,

        gdatu  TYPE ztcurr17-gdatu,  " INVDT

        ukurs  TYPE ztcurr17-ukurs,

        ffact  TYPE ztcurr17-ffact,

        tfact  TYPE ztcurr17-tfact,

        crname TYPE ztcurr17-crname,

        crdate TYPE ztcurr17-crdate,

      END OF gs_rate_db.



DATA: gt_rate_db LIKE TABLE OF gs_rate_db.



" ALV ### ##

TYPES: BEGIN OF ty_rate,

         kurst TYPE tcurr-kurst,

         fcurr TYPE tcurr-fcurr,

         tcurr TYPE tcurr-tcurr,

         gdatu TYPE  tcurr-gdatu,

         ukurs TYPE tcurr-ukurs,

         ffact TYPE tcurr-ffact,

         tfact TYPE tcurr-tfact,

         ernam TYPE syuname,

         erdat TYPE sydatum,

       END OF ty_rate.



DATA: gs_rate TYPE ty_rate,

      gt_rate TYPE STANDARD TABLE OF ty_rate.



" OLE ## (EXCEL # PDF)

DATA: go_excel      TYPE ole2_object,

      go_workbooks  TYPE ole2_object,

      go_workbook   TYPE ole2_object,

      go_sheet      TYPE ole2_object,

      go_cell       TYPE ole2_object,

      go_used_range TYPE ole2_object,

      go_borders    TYPE ole2_object,

      go_columns    TYPE ole2_object.



" ## PDF ### ##

DATA: gv_temp_dir  TYPE string,   " ## ####

      gv_tmpl_file TYPE string,   " ## ## ### ###

      gv_pdf_dir   TYPE string,   " #### ### PDF ##

      gv_pdf_file  TYPE string.   " ## PDF ###