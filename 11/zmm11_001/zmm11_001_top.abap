
*&---------------------------------------------------------------------*

*&  Include           ZMM11_001_TOP

*&---------------------------------------------------------------------*






" ### ## ## (ZPRO11_xxx)

TABLES : zpro11_001, zpro11_002, zpro11_003.



DATA : ok_code TYPE sy-ucomm.



DATA :




*## ### ###




       gv_lifnr LIKE zpro11_001-lifnr, "#####

       gv_name1 LIKE zpro11_001-name1, "####

       gv_land1 LIKE zpro11_001-land1, "###

       gv_ktokk LIKE zpro11_001-ktokk, "#####

       gv_stcd1 LIKE zpro11_001-stcd1, "####

       gv_stcd2 LIKE zpro11_001-stcd2, "#####

       gv_stras LIKE zpro11_001-stras, "##






*#### ### ###




       gv_bukrs LIKE zpro11_002-bukrs, "####

       gv_loevm LIKE zpro11_002-loevm, "#####

       gv_akont LIKE zpro11_002-akont, "##

       gv_zterm LIKE zpro11_002-zterm, "####






*####### ###




       gv_ekorg LIKE zpro11_003-ekorg, "####

       gv_ekgrp LIKE zpro11_003-ekgrp, "####

       gv_waers LIKE zpro11_003-waers, "##

       gv_mwskz LIKE zpro11_003-mwskz. "####



DATA : gv_mode TYPE c. "## ##



"### ### ### ###

DATA : gs_001 TYPE zpro11_001.

DATA : gt_001 LIKE TABLE OF gs_001.



DATA : gs_002 TYPE zpro11_002.

DATA : gt_002 LIKE TABLE OF gs_002.



DATA : gs_003 TYPE zpro11_003.

DATA : gt_003 LIKE TABLE OF gs_003.



DATA : gc_docking TYPE REF TO cl_gui_docking_container.

DATA : gc_grid TYPE REF TO cl_gui_alv_grid.

DATA : gs_variant TYPE disvariant.

DATA : gs_fieldcat TYPE lvc_s_fcat.

DATA : gt_fieldcat TYPE lvc_t_fcat.

DATA : gs_layout TYPE lvc_s_layo.

DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort TYPE lvc_t_sort.



DATA : go_event TYPE REF TO event.






*## ### ###




DATA : BEGIN OF gs_search,

  lifnr TYPE zpro11_001-lifnr, "#####

  name1 TYPE zpro11_001-name1, "####

  bukrs TYPE zpro11_002-bukrs, "####

  stcd2 TYPE zpro11_001-stcd2, "#####

  land1 TYPE zpro11_001-land1, "###

  stras TYPE zpro11_001-stras, "##

  END OF gs_search.



DATA : gt_search LIKE TABLE OF gs_search.