
*&---------------------------------------------------------------------*

*& Include ZWORK11_002_TOP

*&---------------------------------------------------------------------*




TABLES: ztcurr11.

INCLUDE ole2incl.



" ALV ### ### (### ###)

DATA: BEGIN OF gs_list.

        include structure
ztcurr11
.

DATA:   uname TYPE sy-uname,  " ###

        cdate TYPE sy-datum,  " ###

      END OF gs_list.



DATA: gt_list LIKE TABLE OF gs_list.



" ALV ##

DATA: ok_code      TYPE sy-ucomm,

      go_container TYPE REF TO cl_gui_custom_container,

      go_grid      TYPE REF TO cl_gui_alv_grid.



" ## ####

DATA: gt_fcat TYPE lvc_t_fcat,

      gs_fcat TYPE lvc_s_fcat.