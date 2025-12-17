
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_004_TOP

*&---------------------------------------------------------------------*




CONSTANTS : c_x TYPE char1 VALUE 'X',

            c_a TYPE char1 VALUE 'A'.



"alv ## ###

TYPES : BEGIN OF ty_001,

        l_check TYPE char1, "## ##

        bukrs LIKE zrseg19-bukrs, "####

        ebeln LIKE zrseg19-ebeln, "######

        mwsts TYPE mwsts,

        waers TYPE waers, "##

        zmwskz LIKE zbseg19-zmwskz, "####

        sgtxt LIKE zrseg19-sgtxt, "###

        lifnr LIKE zrseg19-lifnr, "#####

        zwerks LIKE zmseg19-zwerks,

        bldat LIKE zbseg19-bldat,

        budat LIKE zbseg19-budat,

        blart LIKE zbseg19-blart,

        gjahr LIKE zbseg19-gjahr,

        zfbdt LIKE zbseg19-zfbdt,

        zmatnr LIKE zedt19_200-zmatnr, "####

        dmbtr TYPE dmbtr,

        shkzg LIKE zmseg19-shkzg,

        ebelp TYPE ebelp,

      END Of ty_001.



DATA : gs_001 TYPE ty_001,

       gt_001 TYPE TABLE OF ty_001.



TYPES : BEGIN OF ty_002,

        bukrs LIKE zrseg19-bukrs, "####

        ebeln LIKE zrseg19-ebeln, "######

        mwsts LIKE zbseg19-mwsts, "##

        waers LIKE zrseg19-waers, "##

        zmwskz LIKE zrseg19-zmwskz, "####

        sgtxt LIKE zrseg19-sgtxt, "###

        lifnr LIKE zrseg19-lifnr, "#####

        zwerks TYPE zwerks19, "###

        belnr TYPE belnr_d,

      END Of ty_002.



DATA : gs_002 TYPE ty_002,

       gt_002 TYPE TABLE OF ty_002.



DATA : gs_003 TYPE zrbkp19,

       gt_003 TYPE TABLE OF zrbkp19.



DATA : gs_004 TYPE zrseg19,

       gt_004 TYPE TABLE OF zrseg19.



DATA : gs_005 TYPE zbkpf19,

       gt_005 TYPE TABLE OF zbkpf19.



DATA : gs_006 TYPE zbseg19,

       gt_006 TYPE TABLE OF zbseg19.



DATA: ok_code TYPE sy-ucomm.



DATA: gc_docking   TYPE REF TO cl_gui_docking_container,

      gc_splitter  TYPE REF TO cl_gui_splitter_container,

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



DATA : gv_last_day TYPE SY-DATUM.



TYPES: BEGIN OF ty_key,

         belnr TYPE belnr_d,

         gjahr TYPE gjahr,

       END OF ty_key.



DATA gt_key TYPE STANDARD TABLE OF ty_key.