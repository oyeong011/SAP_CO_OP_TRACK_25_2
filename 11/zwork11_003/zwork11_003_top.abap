
*&---------------------------------------------------------------------*

*&  Include           ZWORK11_003_TOP

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&  Include           ZWORK11_002_TOP

*&---------------------------------------------------------------------*




TABLES: ztcurr11.



" ZTCURR11 + ALV ## ##(###, ###)

DATA: BEGIN OF gs_output.

        include structure
ztcurr11
.          "### ## ###

DATA:   writer TYPE syuname,            "ALV/### ###(#### ##)

        edate  TYPE sy-datum,           "ALV/### ###(#### ##)

      END OF gs_output.



DATA: gt_output LIKE TABLE OF gs_output. "ALV ### ITAB



"ALV / ####

DATA: ok_code   TYPE sy-ucomm.



DATA: gc_custom TYPE REF TO cl_gui_custom_container.

DATA: gc_grid   TYPE REF TO cl_gui_alv_grid.



DATA: gs_fc TYPE lvc_s_fcat,

      gt_fc TYPE lvc_t_fcat.



"### ### #### ##

DATA: go_event TYPE REF TO event.