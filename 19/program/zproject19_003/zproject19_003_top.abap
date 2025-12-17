
*---------------------------------------------------------------------*

*  Include           ZPROJECT19_003_TOP

*---------------------------------------------------------------------*






TABLES: zmkpf19,

        zmseg19,

        zpdt19_005.



CONSTANTS: c_x TYPE char1 VALUE 'X',

           c_a TYPE char1 VALUE 'A'.



TYPES: BEGIN OF ty_001,

         l_check TYPE char1,            "## ####

         ebeln   LIKE zmseg19-ebeln,    "######

         ebelp   LIKE zpdt19_005-ebelp, "##

         lifnr   LIKE zmseg19-lifnr,    "###

         bedat   LIKE zmkpf19-bldat,    "###

         zmatnr   LIKE zmseg19-zmatnr,    "####

         zmatname   LIKE zpdt19_005-zmatname, "###

         menge   TYPE I,    "##

         meins   LIKE zmseg19-meins,    "##

         stprs   LIKE zpdt19_005-stprs, "##

         waers   LIKE zmseg19-waers,    "##

         prdat   LIKE zpdt19_005-prdat, "###

         zwerks   LIKE zmseg19-zwerks,   "###

         zlgort   LIKE zmseg19-zlgort,    "####

         bukrs LIKE zpdt19_002-bukrs, "####

         dmbtr LIKE zmseg19-dmbtr,

         remain_menge TYPE menge_d,

       END OF ty_001.



TYPES: BEGIN OF ty_004,

         mblnr LIKE zmseg19-mblnr, "######

         mjahr LIKE zmseg19-mjahr, "####

         zeile LIKE zmseg19-zeile, "#####

         ebeln   LIKE zmseg19-ebeln,    "######

         ebelp   LIKE zpdt19_005-ebelp, "##

         lifnr   LIKE zmseg19-lifnr,    "###

         bedat   LIKE zmkpf19-bldat,    "###

         zmatnr   LIKE zmseg19-zmatnr,    "####

         zmatname   LIKE zpdt19_005-zmatname, "###

         menge   TYPE I,    "##

         meins   LIKE zmseg19-meins,    "##

         stprs   LIKE zpdt19_005-stprs, "##

         waers   LIKE zmseg19-waers,    "##

         prdat   LIKE zpdt19_005-prdat, "###

         zwerks   LIKE zmseg19-zwerks,   "###

         zlgort   LIKE zmseg19-zlgort,    "####

         dmbtr LIKE zmseg19-dmbtr, "##

       END OF ty_004.



DATA: gs_001 TYPE ty_001,

      gt_001 TYPE TABLE OF ty_001.



DATA: gs_004 TYPE ty_004,

      gt_004 TYPE TABLE OF ty_004.



DATA : gs_002 TYPE zmkpf19,

       gt_002 TYPE TABLE OF zmkpf19.



DATA : gs_003 TYPE zmseg19,

       gt_003 TYPE TABLE OF zmseg19.



DATA: ok_code TYPE sy-ucomm.



DATA: gc_docking   TYPE REF TO cl_gui_docking_container,

      gc_container1 TYPE REF TO cl_gui_container,

      gc_container2 TYPE REF TO cl_gui_container.



DATA: gc_grid1 TYPE REF TO cl_gui_alv_grid,

      gc_grid2 TYPE REF TO cl_gui_alv_grid.



DATA: gs_fieldcat TYPE lvc_s_fcat,

      gt_fieldcat1 TYPE lvc_t_fcat,

      gt_fieldcat2 TYPE lvc_t_fcat.



DATA: gs_layout TYPE lvc_s_layo.



DATA: gs_sort TYPE lvc_s_sort,

      gt_sort TYPE lvc_t_sort.



DATA: gs_variant TYPE disvariant.