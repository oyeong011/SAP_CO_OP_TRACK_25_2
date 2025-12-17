
*&---------------------------------------------------------------------*

*&  Include           ZEDR11_PRACTICE008_TOP

*&---------------------------------------------------------------------*




TABLES: zedt11_100, zedt11_101.



CONSTANTS: c_x TYPE char1 VALUE 'X',

           c_a TYPE char1 VALUE 'A'.



RANGES: r_fg FOR zedt11_100-zsale_fg,

        r_zg FOR zedt11_101-zflag.



"--- [1] ####: DB ## ###

DATA: BEGIN OF gs_order,

        zordno   LIKE zedt11_100-zordno,

        zidcode  LIKE zedt11_100-zidcode,

        zmatnr   LIKE zedt11_100-zmatnr,

        zmtart   LIKE zedt11_100-zmtart,

        zmatname LIKE zedt11_100-zmatname,

        zvolum   LIKE zedt11_100-zvolum,

        vrkme    LIKE zedt11_100-vrkme,

        znsamt   LIKE zedt11_100-znsamt,

        zslamt   LIKE zedt11_100-zslamt,

        zdcamt   LIKE zedt11_100-zdcamt,

        zwaers   LIKE zedt11_100-zwaers,

        zdc_fg   LIKE zedt11_100-zdc_fg,

        zsale_fg LIKE zedt11_100-zsale_fg,

        zret_fg  LIKE zedt11_100-zret_fg,

        zjdate   LIKE zedt11_100-zjdate,

        zrdate   LIKE zedt11_100-zrdate,

      END OF gs_order.

DATA: gt_order LIKE TABLE OF gs_order.



"--- [1] ####: ALV ### ### (Print)

DATA: BEGIN OF gs_order_print,

        icon       TYPE c LENGTH 4,

        zordno     LIKE zedt11_100-zordno,

        zidcode    LIKE zedt11_100-zidcode,

        zmatnr     LIKE zedt11_100-zmatnr,

        zmatname   LIKE zedt11_100-zmatname,

        zmat_name  TYPE c LENGTH 8,

        zvolum     LIKE zedt11_100-zvolum,

        vrkme      LIKE zedt11_100-vrkme,

        znsamt     LIKE zedt11_100-znsamt,

        zslamt     LIKE zedt11_100-zslamt,

        zdcamt     LIKE zedt11_100-zdcamt,

        zwaers     LIKE zedt11_100-zwaers,

        zsale_name TYPE c LENGTH 4,

        zjdate     LIKE zedt11_100-zjdate,

        zret_name  TYPE c LENGTH 10,

        zrdate     LIKE zedt11_100-zrdate,

      END OF gs_order_print.

DATA: gt_order_print LIKE TABLE OF gs_order_print.



"--- [2] ####: DB ## ###

DATA: BEGIN OF gs_deli,

        zordno   LIKE zedt11_101-zordno,

        zidcode  LIKE zedt11_101-zidcode,

        zmatnr   LIKE zedt11_101-zmatnr,

        zmtart   LIKE zedt11_101-zmtart,

        zmatname LIKE zedt11_101-zmatname,

        zvolum   LIKE zedt11_101-zvolum,

        vrkme    LIKE zedt11_101-vrkme,

        zslamt   LIKE zedt11_101-zslamt,

        zwaers   LIKE zedt11_101-zwaers,

        zdflag   LIKE zedt11_101-zdflag,

        zdgubun  LIKE zedt11_101-zdgubun,

        zddate   LIKE zedt11_101-zddate,

        zrdate   LIKE zedt11_101-zrdate,

        zflag    LIKE zedt11_101-zflag,

      END OF gs_deli.

DATA: gt_deli LIKE TABLE OF gs_deli.



"--- [2] ####: ALV ### ### (Print)

DATA: BEGIN OF gs_deli_print,

        icon         TYPE c LENGTH 4,

        zordno       LIKE zedt11_101-zordno,

        zidcode      LIKE zedt11_101-zidcode,

        zmatnr       LIKE zedt11_101-zmatnr,

        zmatname     LIKE zedt11_101-zmatname,

        zmat_name    TYPE c LENGTH 8,

        zvolum       LIKE zedt11_101-zvolum,

        vrkme        LIKE zedt11_101-vrkme,

        zslamt       LIKE zedt11_101-zslamt,

        zwaers       LIKE zedt11_101-zwaers,

        zdflag_name  TYPE c LENGTH 8,

        zdgubun_name TYPE c LENGTH 6,

        zddate       LIKE zedt11_101-zddate,

        zrdate       LIKE zedt11_101-zrdate,

        zflag        LIKE zedt11_101-zflag,

      END OF gs_deli_print.

DATA: gt_deli_print LIKE TABLE OF gs_deli_print.



DATA: ok_code TYPE sy-ucomm.



DATA: gc_docking  TYPE REF TO cl_gui_docking_container,

      gc_grid_100 TYPE REF TO cl_gui_alv_grid,

      gc_grid_200 TYPE REF TO cl_gui_alv_grid.



DATA: gs_fieldcat TYPE lvc_s_fcat,

      gt_fieldcat TYPE lvc_t_fcat,

      gs_layout   TYPE lvc_s_layo,

      gs_sort     TYPE lvc_s_sort,

      gt_sort     TYPE lvc_t_sort,

      gs_variant  TYPE disvariant.